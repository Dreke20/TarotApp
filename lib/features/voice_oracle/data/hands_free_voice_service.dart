import 'dart:async';

import '../../../core/services/speech_capture.dart';
import '../../../core/services/speech_to_text_question_recognizer.dart';
import '../../../core/services/voice_activity_gate.dart';

/// Hands-free speech capture for the Voice Oracle sheet.
///
/// Recognition goes through [SpeechQuestionRecognizer]. On-device recognition
/// is requested first and, if the platform rejects it, the session falls back
/// to the platform default recognizer. Audio is never stored by this class.
class HandsFreeVoiceService {
  HandsFreeVoiceService({
    SpeechQuestionRecognizer? recognizer,
    VoiceActivityGate? voiceGate,
  })  : _recognizer = recognizer ?? SpeechToTextQuestionRecognizer(),
        _voiceGate = voiceGate ?? CelestialVoiceActivityGate();

  final SpeechQuestionRecognizer _recognizer;
  final VoiceActivityGate _voiceGate;
  Timer? _silenceTimer;
  bool _fellBackFromOnDevice = false;

  bool get isListening => false;

  Future<VoiceListenResult> startListening({
    required void Function(String transcript, double confidence) onResult,
    required void Function(double soundLevel) onSoundLevel,
    required void Function(String finalizedText) onSilenceCommit,
    required void Function(SpeechCaptureFailure failure) onFailure,
    Duration silenceDuration = const Duration(milliseconds: 1800),
  }) async {
    _silenceTimer?.cancel();
    _fellBackFromOnDevice = false;

    if (_voiceGate.isSpeaking) {
      await _voiceGate.stopSpeaking();
    }
    if (_voiceGate.isSpeaking) {
      return VoiceListenResult.ttsBusy;
    }

    final permission = await _recognizer.ensureReady();
    switch (permission) {
      case SpeechCapturePermission.granted:
        break;
      case SpeechCapturePermission.denied:
        return VoiceListenResult.denied;
      case SpeechCapturePermission.permanentlyDenied:
        return VoiceListenResult.permanentlyDenied;
      case SpeechCapturePermission.unavailable:
        return VoiceListenResult.unavailable;
    }

    final started = await _listen(
      onDevice: true,
      onResult: onResult,
      onSoundLevel: onSoundLevel,
      onSilenceCommit: onSilenceCommit,
      onFailure: onFailure,
      silenceDuration: silenceDuration,
    );
    if (!started) return VoiceListenResult.unavailable;
    return VoiceListenResult.listening;
  }

  Future<bool> _listen({
    required bool onDevice,
    required void Function(String transcript, double confidence) onResult,
    required void Function(double soundLevel) onSoundLevel,
    required void Function(String finalizedText) onSilenceCommit,
    required void Function(SpeechCaptureFailure failure) onFailure,
    required Duration silenceDuration,
  }) async {
    try {
      await _recognizer.start(
        onDevice: onDevice,
        onSoundLevel: onSoundLevel,
        onTranscript: (update) {
          if (update.text.trim().isEmpty) return;
          onResult(update.text, update.isFinal ? 1 : 0);
          _silenceTimer?.cancel();
          _silenceTimer = Timer(silenceDuration, () {
            final text = update.text.trim();
            if (text.isNotEmpty) onSilenceCommit(text);
          });
        },
        onFailure: (failure) {
          if (failure.kind == SpeechCaptureFailureKind.onDeviceUnavailable &&
              onDevice &&
              !_fellBackFromOnDevice) {
            _fellBackFromOnDevice = true;
            _listen(
              onDevice: false,
              onResult: onResult,
              onSoundLevel: onSoundLevel,
              onSilenceCommit: onSilenceCommit,
              onFailure: onFailure,
              silenceDuration: silenceDuration,
            );
            return;
          }
          _silenceTimer?.cancel();
          onFailure(failure);
        },
        onSessionEnded: () {},
      );
      return true;
    } on OnDeviceRecognitionUnavailable {
      if (onDevice && !_fellBackFromOnDevice) {
        _fellBackFromOnDevice = true;
        return _listen(
          onDevice: false,
          onResult: onResult,
          onSoundLevel: onSoundLevel,
          onSilenceCommit: onSilenceCommit,
          onFailure: onFailure,
          silenceDuration: silenceDuration,
        );
      }
      onFailure(
        const SpeechCaptureFailure(
          kind: SpeechCaptureFailureKind.unavailable,
          message: 'On-device recognition is not available.',
        ),
      );
      return false;
    }
  }

  Future<void> stopListening() async {
    _silenceTimer?.cancel();
    await _recognizer.stop();
  }

  Future<bool> openSettings() => _recognizer.openSettings();

  void dispose() {
    _silenceTimer?.cancel();
    _recognizer.cancel();
  }
}
