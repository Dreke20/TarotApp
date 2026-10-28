import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'speech_capture.dart';
import 'speech_permission_bridge.dart';

/// `speech_to_text` 7.5.0 wrapper around Android `SpeechRecognizer` and iOS
/// `SFSpeechRecognizer`. Audio is not written to disk or uploaded by this class.
class SpeechToTextQuestionRecognizer implements SpeechQuestionRecognizer {
  SpeechToTextQuestionRecognizer({
    SpeechToText? speech,
    SpeechPermissionBridge? permissions,
  })  : _speech = speech ?? SpeechToText(),
        _permissions = permissions ?? SpeechPermissionBridge();

  final SpeechToText _speech;
  final SpeechPermissionBridge _permissions;

  void Function(SpeechTranscript update)? _onTranscript;
  void Function(SpeechCaptureFailure failure)? _onFailure;
  void Function()? _onSessionEnded;
  void Function(double level)? _onSoundLevel;
  bool _attemptingOnDevice = false;
  bool _hadTranscript = false;
  bool _userEnded = false;
  bool _initialized = false;

  @override
  Future<SpeechCapturePermission> ensureReady() async {
    var initialized = false;
    try {
      initialized = await _speech.initialize(
        onError: _handleError,
        onStatus: _handleStatus,
        options: [SpeechToText.androidNoBluetooth],
      );
      _initialized = initialized;
    } catch (error, stack) {
      debugPrint('Speech recognizer initialize failed: $error\n$stack');
      initialized = false;
    }

    if (initialized) return SpeechCapturePermission.granted;

    final microphone = await _permissions.microphoneStatus();
    final speech = await _permissions.speechStatus();
    return resolveSpeechPermission(
      initializeSucceeded: false,
      microphoneStatus: microphone,
      speechStatus: speech,
    );
  }

  @override
  Future<void> start({
    required bool onDevice,
    required void Function(SpeechTranscript update) onTranscript,
    required void Function(SpeechCaptureFailure failure) onFailure,
    required void Function() onSessionEnded,
    void Function(double level)? onSoundLevel,
  }) async {
    if (!_initialized && !_speech.isAvailable) {
      throw StateError('Speech recognizer is not initialized.');
    }
    _onTranscript = onTranscript;
    _onFailure = onFailure;
    _onSessionEnded = onSessionEnded;
    _onSoundLevel = onSoundLevel;
    _attemptingOnDevice = onDevice;
    _hadTranscript = false;
    _userEnded = false;

    try {
      await _speech.listen(
        onResult: _handleResult,
        onSoundLevelChange: onSoundLevel,
        listenOptions: SpeechListenOptions(
          partialResults: true,
          onDevice: onDevice,
          listenMode: ListenMode.dictation,
          cancelOnError: true,
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 4),
        ),
      );
    } on ListenFailedException catch (error) {
      final message = error.message ?? error.toString();
      if (onDevice && isOnDeviceRecognitionFailure(message)) {
        throw const OnDeviceRecognitionUnavailable();
      }
      _emitFailure(
        SpeechCaptureFailure(
          kind: SpeechCaptureFailureKind.error,
          message: message,
        ),
      );
    }
  }

  @override
  Future<void> stop() async {
    _userEnded = true;
    if (!_speech.isListening) return;
    await _speech.stop();
  }

  @override
  Future<void> cancel() async {
    _userEnded = true;
    _onTranscript = null;
    _onFailure = null;
    _onSessionEnded = null;
    if (!_speech.isListening) return;
    await _speech.cancel();
  }

  @override
  Future<bool> openSettings() => _permissions.openSettings();

  void _handleResult(SpeechRecognitionResult result) {
    final text = result.recognizedWords;
    if (text.trim().isNotEmpty) {
      _hadTranscript = true;
    }
    _onTranscript?.call(
      SpeechTranscript(text: text, isFinal: result.finalResult),
    );
  }

  void _handleError(SpeechRecognitionError error) {
    final failure = failureFromRecognizerError(
      errorMsg: error.errorMsg,
      permanent: error.permanent,
      attemptingOnDevice: _attemptingOnDevice,
      hadTranscript: _hadTranscript,
    );
    if (failure == null) {
      _onSessionEnded?.call();
      return;
    }
    _emitFailure(failure);
  }

  void _handleStatus(String status) {
    final failure = failureFromRecognizerStatus(
      status: status,
      hadTranscript: _hadTranscript,
      userEnded: _userEnded,
    );
    if (failure != null) {
      _emitFailure(failure);
      return;
    }
    if (status == 'done' || status == 'doneNoResult' || status == 'notListening') {
      _onSessionEnded?.call();
    }
  }

  void _emitFailure(SpeechCaptureFailure failure) {
    _onFailure?.call(failure);
  }
}
