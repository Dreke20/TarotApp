import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sensory_service.g.dart';

class SensorySettings {
  final bool soundEnabled;
  final bool hapticsEnabled;

  const SensorySettings({
    this.soundEnabled = true,
    this.hapticsEnabled = true,
  });

  SensorySettings copyWith({
    bool? soundEnabled,
    bool? hapticsEnabled,
  }) {
    return SensorySettings(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
    );
  }
}

@Riverpod(keepAlive: true)
class SensorySettingsNotifier extends _$SensorySettingsNotifier {
  static const String _kSoundKey = 'sensory_sound_enabled';
  static const String _kHapticsKey = 'sensory_haptics_enabled';

  @override
  SensorySettings build() {
    _loadFromStorage();
    return SensorySettings(
      soundEnabled: SensoryService.instance.soundEnabled,
      hapticsEnabled: SensoryService.instance.hapticsEnabled,
    );
  }

  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sound = prefs.getBool(_kSoundKey) ?? true;
      final haptics = prefs.getBool(_kHapticsKey) ?? true;
      SensoryService.instance.soundEnabled = sound;
      SensoryService.instance.hapticsEnabled = haptics;
      state = SensorySettings(soundEnabled: sound, hapticsEnabled: haptics);
    } catch (_) {}
  }

  Future<void> toggleSound() async {
    await setSoundEnabled(!state.soundEnabled);
  }

  Future<void> toggleHaptics() async {
    await setHapticsEnabled(!state.hapticsEnabled);
  }

  Future<void> setSoundEnabled(bool enabled) async {
    SensoryService.instance.soundEnabled = enabled;
    state = state.copyWith(soundEnabled: enabled);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kSoundKey, enabled);
    } catch (_) {}
  }

  Future<void> setHapticsEnabled(bool enabled) async {
    SensoryService.instance.hapticsEnabled = enabled;
    state = state.copyWith(hapticsEnabled: enabled);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kHapticsKey, enabled);
    } catch (_) {}
  }
}

class SensoryService {
  static final SensoryService instance = SensoryService._internal();
  factory SensoryService({bool? soundEnabled, bool? hapticsEnabled}) {
    if (soundEnabled != null) instance.soundEnabled = soundEnabled;
    if (hapticsEnabled != null) instance.hapticsEnabled = hapticsEnabled;
    return instance;
  }
  SensoryService._internal();

  bool soundEnabled = true;
  bool hapticsEnabled = true;

  /// Loads persisted settings at app initialization
  static Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      instance.soundEnabled = prefs.getBool('sensory_sound_enabled') ?? true;
      instance.hapticsEnabled = prefs.getBool('sensory_haptics_enabled') ?? true;
    } catch (_) {}
  }

  /// General light haptic feedback
  void lightImpact() {
    if (!hapticsEnabled) return;
    HapticFeedback.lightImpact();
  }

  /// General medium haptic feedback
  void mediumImpact() {
    if (!hapticsEnabled) return;
    HapticFeedback.mediumImpact();
  }

  /// General heavy haptic feedback
  void heavyImpact() {
    if (!hapticsEnabled) return;
    HapticFeedback.heavyImpact();
  }

  /// General selection click haptic feedback
  void selectionClick() {
    if (!hapticsEnabled) return;
    HapticFeedback.selectionClick();
  }

  /// Haptic feedback when touching or selecting a card
  void cardSelectionHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.selectionClick();
  }

  /// Haptic feedback when flipping a card in 3D
  void cardFlipHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.mediumImpact();
  }

  /// Haptic tremor during shuffling
  void shuffleHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.lightImpact();
  }

  /// Tremor vibration during rune casting or coin shaking
  void shuffleTremorHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.vibrate();
  }

  /// Success or completion resonance
  void completionHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.heavyImpact();
  }

  /// Subtle micro-tick when thumb slides across card deck edges
  void deckFanningHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.selectionClick();
  }

  /// Pulsing heartbeat vibration during sacred attunement ritual
  void sacredHeartbeatHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.mediumImpact();
  }

  /// Micro-crackle haptic when sacred smoke wafts across the altar
  void smokeCrackleHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.selectionClick();
  }

  /// Resonant haptic when a crystal is consecrated or placed on the altar
  void crystalPlacementHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.lightImpact();
  }

  /// Sacred chime haptic when the altar achieves full purification
  void altarPurifiedHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.heavyImpact();
  }

  /// Gentle haptic pulse when breath changes phase (Inhale, Hold, Exhale)
  void breathPhaseHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.mediumImpact();
  }

  /// Micro-tick for each second during meditation hold or inhale
  void breathTickHaptic() {
    if (!hapticsEnabled) return;
    HapticFeedback.selectionClick();
  }

  /// Sound effect when dealing/flipping cards
  void playCardFlipSound() {
    if (!soundEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  /// Sound effect when revealing revelation
  void playRevelationSound() {
    if (!soundEnabled) return;
    SystemSound.play(SystemSoundType.alert);
  }
}

@Riverpod(keepAlive: true)
SensoryService sensoryService(Ref ref) => SensoryService.instance;
