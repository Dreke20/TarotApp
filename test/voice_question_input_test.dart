import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/core/services/ambient_soundscape_service.dart';
import 'package:tarot_app/core/services/sensory_service.dart';
import 'package:tarot_app/core/services/speech_capture.dart';
import 'package:tarot_app/core/services/voice_activity_gate.dart';
import 'package:tarot_app/core/supabase/supabase_client.dart';
import 'package:tarot_app/features/tarot/presentation/notifiers/reading_notifier.dart';
import 'package:tarot_app/features/voice_oracle/data/hands_free_voice_service.dart';
import 'package:tarot_app/features/voice_oracle/presentation/notifiers/hands_free_voice_notifier.dart';
import 'package:tarot_app/features/voice_oracle/presentation/widgets/hands_free_communion_modal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    AmbientAudioNotifier.createPlayer = false;
  });

  tearDown(() {
    AmbientAudioNotifier.createPlayer = true;
  });

  group('speech permission and error mapping', () {
    test('permanent denial is distinct from a denial that can be asked again', () {
      expect(
        resolveSpeechPermission(
          initializeSucceeded: false,
          microphoneStatus: 'denied',
          speechStatus: 'undetermined',
        ),
        SpeechCapturePermission.denied,
      );
      expect(
        resolveSpeechPermission(
          initializeSucceeded: false,
          microphoneStatus: 'permanentlyDenied',
          speechStatus: 'granted',
        ),
        SpeechCapturePermission.permanentlyDenied,
      );
      expect(
        resolveSpeechPermission(
          initializeSucceeded: false,
          microphoneStatus: 'granted',
          speechStatus: 'granted',
        ),
        SpeechCapturePermission.unavailable,
      );
    });

    test('no-match, timeout, and on-device language errors map to distinct failures', () {
      expect(
        failureFromRecognizerError(
          errorMsg: 'error_no_match',
          permanent: false,
          attemptingOnDevice: false,
          hadTranscript: false,
        )?.kind,
        SpeechCaptureFailureKind.noSpeech,
      );
      expect(
        failureFromRecognizerError(
          errorMsg: 'error_speech_timeout',
          permanent: false,
          attemptingOnDevice: false,
          hadTranscript: false,
        )?.kind,
        SpeechCaptureFailureKind.timeout,
      );
      expect(
        failureFromRecognizerError(
          errorMsg: 'error_language_unavailable',
          permanent: true,
          attemptingOnDevice: true,
          hadTranscript: false,
        )?.kind,
        SpeechCaptureFailureKind.onDeviceUnavailable,
      );
      expect(
        failureFromRecognizerStatus(
          status: 'doneNoResult',
          hadTranscript: false,
          userEnded: false,
        )?.kind,
        SpeechCaptureFailureKind.noSpeech,
      );
    });
  });

  group('HandsFreeVoiceService', () {
    late FakeSpeechQuestionRecognizer recognizer;
    late FakeVoiceGate gate;
    late HandsFreeVoiceService service;

    setUp(() {
      recognizer = FakeSpeechQuestionRecognizer();
      gate = FakeVoiceGate();
      service = HandsFreeVoiceService(recognizer: recognizer, voiceGate: gate);
    });

    tearDown(() {
      service.dispose();
    });

    test('reports partial then final text and prefers on-device recognition', () async {
      final heard = <String>[];
      final result = await service.startListening(
        onResult: (transcript, _) => heard.add(transcript),
        onSoundLevel: (_) {},
        onSilenceCommit: (_) {},
        onFailure: (_) {},
        silenceDuration: const Duration(hours: 1),
      );

      expect(result, VoiceListenResult.listening);
      expect(recognizer.onDeviceRequests, [true]);

      recognizer.emit(const SpeechTranscript(text: 'What sacred', isFinal: false));
      recognizer.emit(
        const SpeechTranscript(text: 'What sacred truth must I unveil', isFinal: true),
      );

      expect(heard, ['What sacred', 'What sacred truth must I unveil']);
    });

    test('does not listen when permission is denied or the recognizer is missing', () async {
      recognizer.permission = SpeechCapturePermission.denied;
      final denied = await service.startListening(
        onResult: (_, _) {},
        onSoundLevel: (_) {},
        onSilenceCommit: (_) {},
        onFailure: (_) {},
      );
      expect(denied, VoiceListenResult.denied);
      expect(recognizer.onDeviceRequests, isEmpty);

      recognizer.permission = SpeechCapturePermission.permanentlyDenied;
      expect(
        await service.startListening(
          onResult: (_, _) {},
          onSoundLevel: (_) {},
          onSilenceCommit: (_) {},
          onFailure: (_) {},
        ),
        VoiceListenResult.permanentlyDenied,
      );

      recognizer.permission = SpeechCapturePermission.unavailable;
      expect(
        await service.startListening(
          onResult: (_, _) {},
          onSoundLevel: (_) {},
          onSilenceCommit: (_) {},
          onFailure: (_) {},
        ),
        VoiceListenResult.unavailable,
      );
    });

    test('surfaces no-speech and recognizer errors', () async {
      final failures = <SpeechCaptureFailureKind>[];
      await service.startListening(
        onResult: (_, _) {},
        onSoundLevel: (_) {},
        onSilenceCommit: (_) {},
        onFailure: (failure) => failures.add(failure.kind),
        silenceDuration: const Duration(hours: 1),
      );

      recognizer.fail(
        const SpeechCaptureFailure(
          kind: SpeechCaptureFailureKind.noSpeech,
          message: 'error_no_match',
        ),
      );
      recognizer.fail(
        const SpeechCaptureFailure(
          kind: SpeechCaptureFailureKind.error,
          message: 'error_client',
        ),
      );

      expect(failures, [
        SpeechCaptureFailureKind.noSpeech,
        SpeechCaptureFailureKind.error,
      ]);
    });

    test('does not record while the oracle is speaking', () async {
      gate.speaking = true;
      gate.remainSpeakingAfterStop = true;

      final result = await service.startListening(
        onResult: (_, _) {},
        onSoundLevel: (_) {},
        onSilenceCommit: (_) {},
        onFailure: (_) {},
      );

      expect(gate.stopCalls, 1);
      expect(result, VoiceListenResult.ttsBusy);
      expect(recognizer.onDeviceRequests, isEmpty);
    });

    test('falls back to the platform recognizer when on-device is rejected', () async {
      recognizer.throwOnDevice = true;

      final result = await service.startListening(
        onResult: (_, _) {},
        onSoundLevel: (_) {},
        onSilenceCommit: (_) {},
        onFailure: (_) {},
        silenceDuration: const Duration(hours: 1),
      );

      expect(result, VoiceListenResult.listening);
      expect(recognizer.onDeviceRequests, [true, false]);
    });

    test('cancel stops the recognizer', () async {
      await service.startListening(
        onResult: (_, _) {},
        onSoundLevel: (_) {},
        onSilenceCommit: (_) {},
        onFailure: (_) {},
        silenceDuration: const Duration(hours: 1),
      );
      await service.stopListening();
      expect(recognizer.stopCalls, 1);
    });
  });

  test('anchored voice question is stored on the reading the oracle consults', () async {
    SharedPreferences.setMockInitialValues({});
    final service = HandsFreeVoiceService(
      recognizer: FakeSpeechQuestionRecognizer(),
      voiceGate: FakeVoiceGate(),
    );
    final container = ProviderContainer(
      overrides: [
        handsFreeVoiceServiceProvider.overrideWithValue(service),
        supabaseClientProvider.overrideWithValue(null),
        sensoryServiceProvider.overrideWithValue(
          SensoryService(hapticsEnabled: false, soundEnabled: false),
        ),
      ],
    );
    addTearDown(() {
      service.dispose();
      container.dispose();
    });

    final readingSub = container.listen(readingNotifierProvider, (_, _) {});
    final voiceSub = container.listen(handsFreeVoiceProvider, (_, _) {});
    addTearDown(readingSub.close);
    addTearDown(voiceSub.close);

    await container
        .read(handsFreeVoiceProvider.notifier)
        .commitInquiry('What sacred truth must I unveil?');
    await pumpEventQueue();

    expect(
      container.read(readingNotifierProvider).question,
      'What sacred truth must I unveil?',
    );
    expect(
      container.read(handsFreeVoiceProvider).lastFinalizedInquiry,
      'What sacred truth must I unveil?',
    );
  });

  testWidgets('Voice Oracle shows a denial and still accepts a typed question', (tester) async {
    final recognizer = FakeSpeechQuestionRecognizer()
      ..permission = SpeechCapturePermission.denied;
    final service = HandsFreeVoiceService(
      recognizer: recognizer,
      voiceGate: FakeVoiceGate(),
    );
    String? committed;

    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          handsFreeVoiceServiceProvider.overrideWithValue(service),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: HandsFreeCommunionModal(
              onQuestionCommitted: (question) => committed = question,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const Key('voice_oracle_mic')));
    await tester.pump();
    await tester.pump();

    expect(find.text(VoiceInputNotice.denied.message), findsOneWidget);
    expect(recognizer.onDeviceRequests, isEmpty);

    await tester.enterText(
      find.byKey(const Key('voice_oracle_transcript')),
      'I will type this question',
    );
    await tester.pump();
    await tester.tap(find.text('ANCHOR INQUIRY TO SACRED ALTAR'));
    await tester.pump();

    expect(committed, 'I will type this question');
    service.dispose();
  });
}

class FakeSpeechQuestionRecognizer implements SpeechQuestionRecognizer {
  SpeechCapturePermission permission = SpeechCapturePermission.granted;
  bool throwOnDevice = false;
  final List<bool> onDeviceRequests = [];
  int stopCalls = 0;
  int openSettingsCalls = 0;

  void Function(SpeechTranscript update)? _onTranscript;
  void Function(SpeechCaptureFailure failure)? _onFailure;

  void emit(SpeechTranscript update) => _onTranscript?.call(update);

  void fail(SpeechCaptureFailure failure) => _onFailure?.call(failure);

  @override
  Future<SpeechCapturePermission> ensureReady() async => permission;

  @override
  Future<void> start({
    required bool onDevice,
    required void Function(SpeechTranscript update) onTranscript,
    required void Function(SpeechCaptureFailure failure) onFailure,
    required void Function() onSessionEnded,
    void Function(double level)? onSoundLevel,
  }) async {
    onDeviceRequests.add(onDevice);
    _onTranscript = onTranscript;
    _onFailure = onFailure;
    if (onDevice && throwOnDevice) {
      throw const OnDeviceRecognitionUnavailable();
    }
  }

  @override
  Future<void> stop() async {
    stopCalls++;
  }

  @override
  Future<void> cancel() async {}

  @override
  Future<bool> openSettings() async {
    openSettingsCalls++;
    return true;
  }
}

class FakeVoiceGate implements VoiceActivityGate {
  bool speaking = false;
  bool remainSpeakingAfterStop = false;
  int stopCalls = 0;

  @override
  bool get isSpeaking => speaking;

  @override
  Future<void> stopSpeaking() async {
    stopCalls++;
    if (!remainSpeakingAfterStop) speaking = false;
  }
}
