import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sensory_service.g.dart';

class SensoryService {
  bool soundEnabled;
  bool hapticsEnabled;

  SensoryService({
    this.soundEnabled = true,
    this.hapticsEnabled = true,
  });

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
SensoryService sensoryService(Ref ref) => SensoryService();
