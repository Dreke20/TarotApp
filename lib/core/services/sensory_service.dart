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

  /// Success or completion resonance
  void completionHaptic() {
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
