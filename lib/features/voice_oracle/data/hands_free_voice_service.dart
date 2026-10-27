import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../core/services/celestial_voice_service.dart';

/// Hands-Free Conversational Voice Engine with Voice Activity Detection (VAD)
/// and automatic background audio ducking.
class HandsFreeVoiceService {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;
  Timer? _silenceTimer;

  bool get isAvailable => _isInitialized;
  bool get isListening => _speech.isListening;

  Future<bool> initialize() async {
    if (_isInitialized) return true;
    try {
      _isInitialized = await _speech.initialize(
        onError: (err) => debugPrint('[HandsFreeVoice] Error: ${err.errorMsg}'),
        onStatus: (status) => debugPrint('[HandsFreeVoice] Status: $status'),
      );
      return _isInitialized;
    } catch (e) {
      debugPrint('[HandsFreeVoice] Init exception: $e');
      _isInitialized = false;
      return false;
    }
  }

  /// Begins continuous hands-free listening with silence commit detection.
  Future<void> startListening({
    required Function(String transcript, double confidence) onResult,
    required Function(double soundLevel) onSoundLevel,
    required Function(String finalizedText) onSilenceCommit,
    Duration silenceDuration = const Duration(milliseconds: 1800),
  }) async {
    // If Celestial Voice TTS is speaking, interrupt it so Oracle listens to the seeker
    if (CelestialVoiceService.instance.isPlaying) {
      await CelestialVoiceService.instance.stop();
    }

    final ready = await initialize();
    if (!ready) {
      debugPrint('[HandsFreeVoice] Speech recognition not available on this platform/device');
      return;
    }

    String lastWords = '';

    await _speech.listen(
      onResult: (result) {
        lastWords = result.recognizedWords;
        onResult(result.recognizedWords, result.confidence);

        // Reset silence commit countdown on new words
        _silenceTimer?.cancel();
        _silenceTimer = Timer(silenceDuration, () {
          if (lastWords.trim().isNotEmpty) {
            onSilenceCommit(lastWords.trim());
          }
        });
      },
      onSoundLevelChange: onSoundLevel,
      listenOptions: SpeechListenOptions(
        listenFor: const Duration(seconds: 45),
        pauseFor: const Duration(seconds: 4),
        partialResults: true,
        cancelOnError: false,
        listenMode: ListenMode.dictation,
      ),
    );
  }

  /// Stops speech listening and cancels silence timers.
  Future<void> stopListening() async {
    _silenceTimer?.cancel();
    if (_speech.isListening) {
      await _speech.stop();
    }
  }

  void dispose() {
    _silenceTimer?.cancel();
    _speech.stop();
  }
}
