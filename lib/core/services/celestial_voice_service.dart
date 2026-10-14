import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Service managing spoken celestial prophecies via text-to-speech.
class CelestialVoiceService {
  CelestialVoiceService._();
  static final CelestialVoiceService instance = CelestialVoiceService._();

  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;
  bool _isPlaying = false;

  VoidCallback? onStarted;
  VoidCallback? onStopped;

  bool get isPlaying => _isPlaying;

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await _tts.setLanguage("en-US");
      // Slower, meditative pitch and rate for an oracle voice
      await _tts.setSpeechRate(0.42);
      await _tts.setPitch(0.92);
      await _tts.setVolume(1.0);

      _tts.setStartHandler(() {
        _isPlaying = true;
        onStarted?.call();
      });

      _tts.setCompletionHandler(() {
        _isPlaying = false;
        onStopped?.call();
      });

      _tts.setErrorHandler((dynamic msg) {
        _isPlaying = false;
        onStopped?.call();
      });

      _isInitialized = true;
    } catch (e) {
      debugPrint("CelestialVoiceService init warning: $e");
    }
  }

  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await init();
    }
    if (_isPlaying) {
      await stop();
    }
    try {
      _isPlaying = true;
      onStarted?.call();
      await _tts.speak(text);
    } catch (e) {
      _isPlaying = false;
      onStopped?.call();
      debugPrint("CelestialVoiceService speak error: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      debugPrint("CelestialVoiceService stop error: $e");
    } finally {
      _isPlaying = false;
      onStopped?.call();
    }
  }
}
