import 'celestial_voice_service.dart';

/// Whether text-to-speech is currently playing.
///
/// The microphone must not open while the oracle is speaking.
abstract class VoiceActivityGate {
  bool get isSpeaking;

  Future<void> stopSpeaking();
}

class CelestialVoiceActivityGate implements VoiceActivityGate {
  CelestialVoiceActivityGate({CelestialVoiceService? voice})
      : _voice = voice ?? CelestialVoiceService.instance;

  final CelestialVoiceService _voice;

  @override
  bool get isSpeaking => _voice.isPlaying;

  @override
  Future<void> stopSpeaking() => _voice.stop();
}
