import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../../core/services/celestial_voice_service.dart';
import '../../../core/services/sensory_service.dart';
import '../../tarot/domain/oracle_persona.dart';
import '../domain/archetypal_pathworking.dart';

/// Service coordinating spoken oracle guidance layered over ambient Solfeggio soundscapes.
class PathworkingEngineService {
  static final PathworkingEngineService instance =
      PathworkingEngineService._internal();

  PathworkingEngineService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  ArchetypalPathworking? _currentPathworking;
  int _currentStepIndex = 0;
  bool _isPlaying = false;
  Timer? _stepTimer;
  int _secondsRemainingInStep = 0;

  ArchetypalPathworking? get currentPathworking => _currentPathworking;
  int get currentStepIndex => _currentStepIndex;
  bool get isPlaying => _isPlaying;
  int get secondsRemainingInStep => _secondsRemainingInStep;

  VoidCallback? onStateChanged;

  /// Start a guided pathworking journey.
  Future<void> startPathworking(
    ArchetypalPathworking pathworking, {
    OraclePersona? persona,
  }) async {
    await stop();

    _currentPathworking = pathworking;
    _currentStepIndex = 0;
    _isPlaying = true;

    // 1. Start ambient soundscape
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(0.45);
      try {
        await _audioPlayer.play(AssetSource(pathworking.track.assetPath));
      } catch (e) {
        debugPrint('[PathworkingEngine] Asset play error, fallback to stream: $e');
        await _audioPlayer.play(UrlSource(pathworking.track.fallbackUrl));
      }
    } catch (e) {
      debugPrint('[PathworkingEngine] Soundscape play error: $e');
    }

    // 2. Play initial step
    _playCurrentStep(persona: persona);
  }

  void _playCurrentStep({OraclePersona? persona}) {
    if (_currentPathworking == null || !_isPlaying) return;

    final step = _currentPathworking!.steps[_currentStepIndex];
    _secondsRemainingInStep = step.durationSeconds;

    SensoryService.instance.breathPhaseHaptic();

    // Spoken voice guidance
    CelestialVoiceService.instance.speak(
      step.guidanceText,
      persona: persona,
    );

    _stepTimer?.cancel();
    _stepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPlaying) return;

      if (_secondsRemainingInStep > 1) {
        _secondsRemainingInStep--;
        onStateChanged?.call();
      } else {
        _advanceToNextStep(persona: persona);
      }
    });

    onStateChanged?.call();
  }

  void _advanceToNextStep({OraclePersona? persona}) {
    if (_currentPathworking == null) return;

    if (_currentStepIndex < _currentPathworking!.steps.length - 1) {
      _currentStepIndex++;
      _playCurrentStep(persona: persona);
    } else {
      // Completed all steps
      stop();
    }
  }

  void pause() {
    _isPlaying = false;
    _stepTimer?.cancel();
    _audioPlayer.pause();
    CelestialVoiceService.instance.stop();
    onStateChanged?.call();
  }

  void resume({OraclePersona? persona}) {
    if (_currentPathworking == null) return;
    _isPlaying = true;
    _audioPlayer.resume();
    _playCurrentStep(persona: persona);
  }

  Future<void> stop() async {
    _isPlaying = false;
    _stepTimer?.cancel();
    _stepTimer = null;
    _currentPathworking = null;
    _currentStepIndex = 0;
    _secondsRemainingInStep = 0;

    try {
      await _audioPlayer.stop();
    } catch (_) {}

    await CelestialVoiceService.instance.stop();

    onStateChanged?.call();
  }
}
