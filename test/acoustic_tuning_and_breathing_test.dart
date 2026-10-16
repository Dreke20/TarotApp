import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/core/services/celestial_voice_service.dart';
import 'package:tarot_app/core/services/sensory_service.dart';
import 'package:tarot_app/features/altar/presentation/widgets/breathing_orb_widget.dart';
import 'package:tarot_app/features/altar/presentation/widgets/sacred_breathing_modal.dart';
import 'package:tarot_app/features/tarot/domain/oracle_persona.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('flutter_tts');
  final List<MethodCall> calls = [];

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      calls.add(methodCall);
      switch (methodCall.method) {
        case 'setLanguage':
        case 'setSpeechRate':
        case 'setPitch':
        case 'setVolume':
        case 'speak':
        case 'stop':
          return 1;
        default:
          return 1;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('Archetypal Acoustic Vocal Tuning Tests', () {
    test('all 5 OraclePersonas have valid calibrated acoustic parameters', () {
      for (final persona in OraclePersona.values) {
        expect(persona.pitch, greaterThanOrEqualTo(0.6));
        expect(persona.pitch, lessThanOrEqualTo(1.3));
        expect(persona.speechRate, greaterThanOrEqualTo(0.3));
        expect(persona.speechRate, lessThanOrEqualTo(0.6));
        expect(persona.timbreTitle.isNotEmpty, isTrue);
        expect(persona.timbreDescription.isNotEmpty, isTrue);
        expect(persona.solfeggioFrequency.isNotEmpty, isTrue);
      }
    });

    test('acoustic profiles reflect archetype gravitas and timbre contrast', () {
      final highPriestess = OraclePersona.highPriestess;
      final hermit = OraclePersona.hermit;
      final magician = OraclePersona.magician;

      // High Priestess has ethereal higher pitch than contemplative Hermit
      expect(highPriestess.pitch, greaterThan(hermit.pitch));
      // Hermit has slower, deliberate stoic cadence compared to incisive Magician
      expect(hermit.speechRate, lessThan(magician.speechRate));
    });

    test('CelestialVoiceService speaks with persona-specific acoustic tuning', () async {
      final voice = CelestialVoiceService.instance;
      await voice.init();

      await voice.speak('Cosmic wisdom unfolds.', persona: OraclePersona.hermit);

      // Verify pitch and rate calls were made
      final pitchCalls = calls.where((c) => c.method == 'setPitch').toList();
      final rateCalls = calls.where((c) => c.method == 'setSpeechRate').toList();

      expect(pitchCalls.isNotEmpty, isTrue);
      expect(rateCalls.isNotEmpty, isTrue);
      expect(pitchCalls.last.arguments, equals(OraclePersona.hermit.pitch));
      expect(rateCalls.last.arguments, equals(OraclePersona.hermit.speechRate));

      await voice.stop();
    });

    test('CelestialVoiceService auditions persona sample quote and tracks auditioning id', () async {
      final voice = CelestialVoiceService.instance;
      await voice.init();

      await voice.auditionPersona(OraclePersona.magician);
      expect(voice.currentlyAuditioningId, equals(OraclePersona.magician.id));
      expect(voice.isPlaying, isTrue);

      await voice.stop();
      expect(voice.currentlyAuditioningId, isNull);
      expect(voice.isPlaying, isFalse);
    });
  });

  group('Sacred 4-7-8 Breathing & Orb Tests', () {
    test('BreathingPhase enum defines exact 4-7-8 sacred ratios', () {
      expect(BreathingPhase.inhale.durationSeconds, equals(4));
      expect(BreathingPhase.hold.durationSeconds, equals(7));
      expect(BreathingPhase.exhale.durationSeconds, equals(8));

      final totalCycleSeconds = BreathingPhase.inhale.durationSeconds +
          BreathingPhase.hold.durationSeconds +
          BreathingPhase.exhale.durationSeconds;
      expect(totalCycleSeconds, equals(19));
    });

    test('SensoryService breathing haptics execute safely', () {
      final sensory = SensoryService();
      expect(() => sensory.breathPhaseHaptic(), returnsNormally);
      expect(() => sensory.breathTickHaptic(), returnsNormally);
      expect(() => sensory.sacredHeartbeatHaptic(), returnsNormally);
      expect(() => sensory.altarPurifiedHaptic(), returnsNormally);
    });

    testWidgets('BreathingOrbWidget renders with sacred geometry typography and canvas',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: BreathingOrbWidget(
                phase: BreathingPhase.inhale,
                secondsRemaining: 4,
                scale: 0.75,
                persona: OraclePersona.highPriestess,
                size: 240,
              ),
            ),
          ),
        ),
      );

      expect(find.text('INHALE'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('SECONDS'), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('SacredBreathingModal renders cycles, presets, and anchors intention',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      String? returnedIntention;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SacredBreathingModal(
                initialQuestion: 'Initial inquiry',
                onIntentionSet: (val) => returnedIntention = val,
              ),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 200));

      // Verify header and cycle badge
      expect(find.text('SACRED 4-7-8 CENTERING'), findsOneWidget);
      expect(find.text('SACRED CYCLE 1 OF 3'), findsOneWidget);

      // Verify preset intention chip and tap it
      final presetChip = find.text('✦ Clarity on my next threshold');
      expect(presetChip, findsOneWidget);
      await tester.ensureVisible(presetChip);
      await tester.tap(presetChip);
      await tester.pump(const Duration(milliseconds: 100));

      // Complete ritual and return intention
      final completeButton = find.text('CONSECRATE INTENTION & RETURN');
      expect(completeButton, findsOneWidget);
      await tester.ensureVisible(completeButton);
      await tester.tap(completeButton);
      await tester.pump(const Duration(milliseconds: 200));

      expect(returnedIntention, equals('Clarity on my next threshold'));
    });
  });
}
