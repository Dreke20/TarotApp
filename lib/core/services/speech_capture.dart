/// Platform speech recognition, abstracted so tests can fake the microphone.
///
/// The production implementation wraps `speech_to_text`, which calls the
/// Android and iOS speech recognizers. This app never records or uploads audio.
library;

enum SpeechCapturePermission {
  granted,
  denied,
  permanentlyDenied,
  unavailable,
}

enum SpeechCaptureFailureKind {
  unavailable,
  permissionDenied,
  permissionPermanentlyDenied,
  noSpeech,
  timeout,
  error,
  onDeviceUnavailable,
}

class SpeechCaptureFailure {
  final SpeechCaptureFailureKind kind;
  final String message;

  const SpeechCaptureFailure({
    required this.kind,
    required this.message,
  });
}

class SpeechTranscript {
  final String text;
  final bool isFinal;

  const SpeechTranscript({
    required this.text,
    required this.isFinal,
  });
}

class OnDeviceRecognitionUnavailable implements Exception {
  const OnDeviceRecognitionUnavailable();
}

enum VoiceListenResult {
  listening,
  denied,
  permanentlyDenied,
  unavailable,
  ttsBusy,
}

/// Speech recognizer used to capture a tarot question.
abstract class SpeechQuestionRecognizer {
  Future<SpeechCapturePermission> ensureReady();

  /// [onDevice] asks the platform to keep recognition on the device.
  /// If that cannot be done, throw [OnDeviceRecognitionUnavailable] or report
  /// [SpeechCaptureFailureKind.onDeviceUnavailable].
  Future<void> start({
    required bool onDevice,
    required void Function(SpeechTranscript update) onTranscript,
    required void Function(SpeechCaptureFailure failure) onFailure,
    required void Function() onSessionEnded,
    void Function(double level)? onSoundLevel,
  });

  Future<void> stop();

  Future<void> cancel();

  Future<bool> openSettings();
}

SpeechCapturePermission resolveSpeechPermission({
  required bool initializeSucceeded,
  required String microphoneStatus,
  required String speechStatus,
}) {
  if (initializeSucceeded) return SpeechCapturePermission.granted;

  bool blocked(String status) =>
      status == 'permanentlyDenied' || status == 'restricted';
  if (blocked(microphoneStatus) || blocked(speechStatus)) {
    return SpeechCapturePermission.permanentlyDenied;
  }
  if (microphoneStatus == 'granted' && speechStatus == 'granted') {
    return SpeechCapturePermission.unavailable;
  }
  return SpeechCapturePermission.denied;
}

SpeechCaptureFailure? failureFromRecognizerError({
  required String errorMsg,
  required bool permanent,
  required bool attemptingOnDevice,
  required bool hadTranscript,
}) {
  final code = errorMsg.toLowerCase();
  final onDeviceFailure = code.contains('ondevice') ||
      code.contains('on_device') ||
      code.contains('on device') ||
      code.contains('error_language_not_supported') ||
      code.contains('error_language_unavailable');
  if (attemptingOnDevice && onDeviceFailure) {
    return SpeechCaptureFailure(
      kind: SpeechCaptureFailureKind.onDeviceUnavailable,
      message: errorMsg,
    );
  }
  if (code.contains('error_permission')) {
    return SpeechCaptureFailure(
      kind: permanent
          ? SpeechCaptureFailureKind.permissionPermanentlyDenied
          : SpeechCaptureFailureKind.permissionDenied,
      message: errorMsg,
    );
  }
  if (code.contains('error_speech_timeout') ||
      code.contains('error_network_timeout')) {
    if (hadTranscript) return null;
    return SpeechCaptureFailure(
      kind: SpeechCaptureFailureKind.timeout,
      message: errorMsg,
    );
  }
  if (code.contains('error_no_match')) {
    if (hadTranscript) return null;
    return SpeechCaptureFailure(
      kind: SpeechCaptureFailureKind.noSpeech,
      message: errorMsg,
    );
  }
  return SpeechCaptureFailure(
    kind: SpeechCaptureFailureKind.error,
    message: errorMsg,
  );
}

SpeechCaptureFailure? failureFromRecognizerStatus({
  required String status,
  required bool hadTranscript,
  required bool userEnded,
}) {
  if (userEnded) return null;
  if (status == 'doneNoResult' && !hadTranscript) {
    return const SpeechCaptureFailure(
      kind: SpeechCaptureFailureKind.noSpeech,
      message: 'doneNoResult',
    );
  }
  return null;
}

bool isOnDeviceRecognitionFailure(String message) {
  final code = message.toLowerCase();
  return code.contains('ondevice') ||
      code.contains('on_device') ||
      code.contains('on device');
}

class VoiceInputNotice {
  final VoiceListenResult? result;
  final SpeechCaptureFailureKind? failure;
  final String message;

  const VoiceInputNotice({
    this.result,
    this.failure,
    required this.message,
  });

  bool get canOpenSettings =>
      result == VoiceListenResult.permanentlyDenied ||
      failure == SpeechCaptureFailureKind.permissionPermanentlyDenied;

  static const denied = VoiceInputNotice(
    result: VoiceListenResult.denied,
    message:
        'Microphone access was denied. You can try again, or type your question instead.',
  );

  static const permanentlyDenied = VoiceInputNotice(
    result: VoiceListenResult.permanentlyDenied,
    message:
        'Microphone access is turned off for Oraculum. Enable the microphone in Settings, or type your question instead.',
  );

  static const unavailable = VoiceInputNotice(
    result: VoiceListenResult.unavailable,
    message:
        'Speech recognition is not available on this device. Type your question instead.',
  );

  static const ttsBusy = VoiceInputNotice(
    result: VoiceListenResult.ttsBusy,
    message:
        'The oracle is still speaking. Wait until it finishes, then tap to speak. You can type your question instead.',
  );

  static const noSpeech = VoiceInputNotice(
    failure: SpeechCaptureFailureKind.noSpeech,
    message: 'No speech was heard. Tap the orb to try again, or type your question.',
  );

  static const timeout = VoiceInputNotice(
    failure: SpeechCaptureFailureKind.timeout,
    message:
        'Listening timed out before any speech was heard. Tap the orb to try again, or type your question.',
  );

  static const error = VoiceInputNotice(
    failure: SpeechCaptureFailureKind.error,
    message:
        'Speech recognition stopped unexpectedly. You can try again, or type your question.',
  );

  static VoiceInputNotice? forResult(VoiceListenResult result) {
    switch (result) {
      case VoiceListenResult.listening:
        return null;
      case VoiceListenResult.denied:
        return denied;
      case VoiceListenResult.permanentlyDenied:
        return permanentlyDenied;
      case VoiceListenResult.unavailable:
        return unavailable;
      case VoiceListenResult.ttsBusy:
        return ttsBusy;
    }
  }

  static VoiceInputNotice? forFailure(SpeechCaptureFailure failure) {
    switch (failure.kind) {
      case SpeechCaptureFailureKind.noSpeech:
        return noSpeech;
      case SpeechCaptureFailureKind.timeout:
        return timeout;
      case SpeechCaptureFailureKind.error:
      case SpeechCaptureFailureKind.unavailable:
        return error;
      case SpeechCaptureFailureKind.permissionDenied:
        return denied;
      case SpeechCaptureFailureKind.permissionPermanentlyDenied:
        return permanentlyDenied;
      case SpeechCaptureFailureKind.onDeviceUnavailable:
        return null;
    }
  }
}
