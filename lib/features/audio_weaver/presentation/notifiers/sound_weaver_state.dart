import '../../domain/sound_layer.dart';

/// Immutable state representing the 3-layer Sacred Sound Weaver studio.
class SoundWeaverState {
  final bool isPlaying;
  final double masterVolume;

  // Layer 1: Sacred Frequency
  final SoundLayerTrack frequencyTrack;
  final double frequencyVolume;
  final bool isFrequencyMuted;

  // Layer 2: Temple Instruments
  final SoundLayerTrack instrumentTrack;
  final double instrumentVolume;
  final bool isInstrumentMuted;

  // Layer 3: Elemental Nature
  final SoundLayerTrack natureTrack;
  final double natureVolume;
  final bool isNatureMuted;

  // Curated Preset / Custom
  final SoundPreset? activePreset;

  // Meditation / Sleep Timer
  final int? timerDurationSeconds;
  final int? remainingTimerSeconds;

  const SoundWeaverState({
    this.isPlaying = false,
    this.masterVolume = 0.70,
    this.frequencyTrack = SoundLayerTrack.solfeggio432,
    this.frequencyVolume = 0.75,
    this.isFrequencyMuted = false,
    this.instrumentTrack = SoundLayerTrack.tibetanBowls,
    this.instrumentVolume = 0.50,
    this.isInstrumentMuted = false,
    this.natureTrack = SoundLayerTrack.astralBreeze,
    this.natureVolume = 0.35,
    this.isNatureMuted = false,
    this.activePreset,
    this.timerDurationSeconds,
    this.remainingTimerSeconds,
  });

  /// Computes the audible volume for a specific layer.
  double effectiveVolume(SoundLayerCategory category) {
    if (!isPlaying) return 0.0;
    switch (category) {
      case SoundLayerCategory.frequency:
        if (isFrequencyMuted) return 0.0;
        return (masterVolume * frequencyVolume).clamp(0.0, 1.0);
      case SoundLayerCategory.instrument:
        if (isInstrumentMuted) return 0.0;
        return (masterVolume * instrumentVolume).clamp(0.0, 1.0);
      case SoundLayerCategory.nature:
        if (isNatureMuted) return 0.0;
        return (masterVolume * natureVolume).clamp(0.0, 1.0);
    }
  }

  /// Whether any layer is currently audible.
  bool get hasAudibleOutput =>
      isPlaying &&
      masterVolume > 0.0 &&
      ((!isFrequencyMuted && frequencyVolume > 0) ||
          (!isInstrumentMuted && instrumentVolume > 0) ||
          (!isNatureMuted && natureVolume > 0));

  /// Formatted countdown display (e.g., '14:59') if sleep timer is active.
  String? get formattedRemainingTime {
    if (remainingTimerSeconds == null) return null;
    final int minutes = remainingTimerSeconds! ~/ 60;
    final int seconds = remainingTimerSeconds! % 60;
    final String minStr = minutes.toString().padLeft(2, '0');
    final String secStr = seconds.toString().padLeft(2, '0');
    return '$minStr:$secStr';
  }

  SoundWeaverState copyWith({
    bool? isPlaying,
    double? masterVolume,
    SoundLayerTrack? frequencyTrack,
    double? frequencyVolume,
    bool? isFrequencyMuted,
    SoundLayerTrack? instrumentTrack,
    double? instrumentVolume,
    bool? isInstrumentMuted,
    SoundLayerTrack? natureTrack,
    double? natureVolume,
    bool? isNatureMuted,
    SoundPreset? activePreset,
    bool clearPreset = false,
    int? timerDurationSeconds,
    int? remainingTimerSeconds,
    bool clearTimer = false,
  }) {
    return SoundWeaverState(
      isPlaying: isPlaying ?? this.isPlaying,
      masterVolume: masterVolume ?? this.masterVolume,
      frequencyTrack: frequencyTrack ?? this.frequencyTrack,
      frequencyVolume: frequencyVolume ?? this.frequencyVolume,
      isFrequencyMuted: isFrequencyMuted ?? this.isFrequencyMuted,
      instrumentTrack: instrumentTrack ?? this.instrumentTrack,
      instrumentVolume: instrumentVolume ?? this.instrumentVolume,
      isInstrumentMuted: isInstrumentMuted ?? this.isInstrumentMuted,
      natureTrack: natureTrack ?? this.natureTrack,
      natureVolume: natureVolume ?? this.natureVolume,
      isNatureMuted: isNatureMuted ?? this.isNatureMuted,
      activePreset: clearPreset ? null : (activePreset ?? this.activePreset),
      timerDurationSeconds: clearTimer ? null : (timerDurationSeconds ?? this.timerDurationSeconds),
      remainingTimerSeconds: clearTimer ? null : (remainingTimerSeconds ?? this.remainingTimerSeconds),
    );
  }
}
