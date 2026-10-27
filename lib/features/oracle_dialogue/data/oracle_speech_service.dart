import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Thin wrapper around on-device speech recognition for the Conversational Oracle.
///
/// Speech is transcribed by the platform recognizer; only the resulting text is
/// ever sent onward (through the Supabase Edge Function), never raw audio.
class OracleSpeechService {
  OracleSpeechService({SpeechToText? speech}) : _speech = speech ?? SpeechToText();

  final SpeechToText _speech;
  bool _isAvailable = false;

  bool get isAvailable => _isAvailable;
  bool get isListening => _speech.isListening;

  /// Requests microphone permission and prepares the recognizer.
  Future<bool> initialize({
    void Function(String status)? onStatus,
    void Function(String error)? onError,
  }) async {
    if (_isAvailable) return true;
    try {
      _isAvailable = await _speech.initialize(
        onStatus: (String status) => onStatus?.call(status),
        onError: (SpeechRecognitionError error) => onError?.call(error.errorMsg),
      );
    } catch (e) {
      debugPrint('OracleSpeechService init error: $e');
      _isAvailable = false;
    }
    return _isAvailable;
  }

  /// Begins listening. [onResult] receives partial and final transcripts.
  Future<void> listen({
    required void Function(String words, bool isFinal) onResult,
    void Function(double level)? onSoundLevel,
  }) async {
    if (!_isAvailable) return;
    try {
      await _speech.listen(
        onResult: (SpeechRecognitionResult result) =>
            onResult(result.recognizedWords, result.finalResult),
        onSoundLevelChange: onSoundLevel,
        listenOptions: SpeechListenOptions(
          listenFor: const Duration(seconds: 45),
          pauseFor: const Duration(seconds: 3),
          partialResults: true,
          cancelOnError: true,
          listenMode: ListenMode.dictation,
          // Keep audio on the phone; matches the Play data safety answers.
          onDevice: true,
        ),
      );
    } catch (e) {
      debugPrint('OracleSpeechService listen error: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _speech.stop();
    } catch (e) {
      debugPrint('OracleSpeechService stop error: $e');
    }
  }

  Future<void> cancel() async {
    try {
      await _speech.cancel();
    } catch (e) {
      debugPrint('OracleSpeechService cancel error: $e');
    }
  }
}
