import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../features/tarot/domain/oracle_persona.dart';

/// Service managing spoken celestial prophecies and archetype auditions via text-to-speech.
class CelestialVoiceService {
  CelestialVoiceService._();
  static final CelestialVoiceService instance = CelestialVoiceService._();

  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;
  bool _isPlaying = false;
  String? _currentlyAuditioningId;

  VoidCallback? onStarted;
  VoidCallback? onStopped;

  bool get isPlaying => _isPlaying;
  String? get currentlyAuditioningId => _currentlyAuditioningId;

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await _tts.setLanguage("en-US");
      // Default meditative pitch and rate for an oracle voice
      await _tts.setSpeechRate(0.42);
      await _tts.setPitch(0.92);
      await _tts.setVolume(1.0);

      _tts.setStartHandler(() {
        _isPlaying = true;
        onStarted?.call();
      });

      _tts.setCompletionHandler(() {
        _isPlaying = false;
        _currentlyAuditioningId = null;
        onStopped?.call();
      });

      _tts.setErrorHandler((dynamic msg) {
        _isPlaying = false;
        _currentlyAuditioningId = null;
        onStopped?.call();
      });

      _isInitialized = true;
    } catch (e) {
      debugPrint("CelestialVoiceService init warning: $e");
    }
  }

  /// Speaks the prophecy text calibrated to the acoustic tuning of the [persona].
  Future<void> speak(String text, {OraclePersona? persona}) async {
    if (!_isInitialized) {
      await init();
    }
    if (_isPlaying) {
      await stop();
    }
    try {
      if (persona != null) {
        await _tts.setPitch(persona.pitch);
        await _tts.setSpeechRate(persona.speechRate);
      } else {
        await _tts.setPitch(0.92);
        await _tts.setSpeechRate(0.42);
      }

      _isPlaying = true;
      _currentlyAuditioningId = null;
      onStarted?.call();
      await _tts.speak(text);
    } catch (e) {
      _isPlaying = false;
      _currentlyAuditioningId = null;
      onStopped?.call();
      debugPrint("CelestialVoiceService speak error: $e");
    }
  }

  /// Auditions the archetypal acoustic profile and sample quote for the specified [persona].
  Future<void> auditionPersona(OraclePersona persona) async {
    if (!_isInitialized) {
      await init();
    }
    if (_isPlaying) {
      await stop();
    }
    try {
      await _tts.setPitch(persona.pitch);
      await _tts.setSpeechRate(persona.speechRate);

      // Clean quotation symbols for natural oral delivery
      final cleanQuote = persona.sampleQuote.replaceAll('“', '').replaceAll('”', '').replaceAll('"', '');
      final auditionScript = "I am ${persona.title}. $cleanQuote";

      _isPlaying = true;
      _currentlyAuditioningId = persona.id;
      onStarted?.call();
      await _tts.speak(auditionScript);
    } catch (e) {
      _isPlaying = false;
      _currentlyAuditioningId = null;
      onStopped?.call();
      debugPrint("CelestialVoiceService audition error: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      debugPrint("CelestialVoiceService stop error: $e");
    } finally {
      _isPlaying = false;
      _currentlyAuditioningId = null;
      onStopped?.call();
    }
  }
}

