import 'dart:async';
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../tarot/data/tarot_card_data.dart';
import '../../../tarot/domain/tarot_card.dart';
import '../../data/ar_camera_service.dart';
import '../../data/ar_pose_tracker.dart';
import '../../domain/ar_altar_card.dart';
import 'ar_altar_state.dart';

part 'ar_altar_notifier.g.dart';

@riverpod
ArCameraService arCameraService(Ref ref) {
  final ArCameraService service = ArCameraService();
  ref.onDispose(service.stop);
  return service;
}

@riverpod
ArPoseTracker arPoseTracker(Ref ref) {
  final ArPoseTracker tracker = ArPoseTracker();
  ref.onDispose(tracker.dispose);
  return tracker;
}

/// High-frequency device pose, kept separate from [ArAltarNotifier] so 60 Hz
/// sensor updates only rebuild the projected plane, not the whole screen.
@riverpod
class ArPoseNotifier extends _$ArPoseNotifier {
  StreamSubscription<ArPose>? _sub;

  @override
  ArPose build() {
    final ArPoseTracker tracker = ref.watch(arPoseTrackerProvider);
    _sub = tracker.poses.listen((ArPose p) {
      if (ref.mounted) state = p;
    });
    ref.onDispose(() => _sub?.cancel());
    return const ArPose();
  }

  void recenter() => ref.read(arPoseTrackerProvider).recenter();
}

@riverpod
class ArAltarNotifier extends _$ArAltarNotifier {
  static const Uuid _uuid = Uuid();
  final Random _random = Random();

  @override
  ArAltarState build() => const ArAltarState();

  Future<void> startCamera() async {
    if (state.isCameraReady || state.isCameraStarting) return;
    state = state.copyWith(isCameraStarting: true, cameraError: null);
    String? error;
    try {
      error = await ref.read(arCameraServiceProvider).start();
    } catch (e) {
      error = 'The camera could not start.';
    }
    if (!ref.mounted) return;
    state = state.copyWith(
      isCameraStarting: false,
      isCameraReady: error == null,
      cameraError: error,
    );
  }

  /// Releases the camera (e.g. when the app is backgrounded).
  Future<void> pauseCamera() async {
    await ref.read(arCameraServiceProvider).stop();
    await ref.read(arPoseTrackerProvider).stop();
    if (!ref.mounted) return;
    state = state.copyWith(isCameraReady: false);
  }

  Future<void> resumeCamera() async {
    if (state.isMandalaAnchored) ref.read(arPoseTrackerProvider).start();
    await startCamera();
  }

  /// Anchors the mandala straight ahead and starts orientation tracking.
  void anchorMandala() {
    final ArPoseTracker tracker = ref.read(arPoseTrackerProvider);
    tracker.recenter();
    tracker.start();
    SensoryService().crystalPlacementHaptic();
    state = state.copyWith(isMandalaAnchored: true);
  }

  void setSpread(ArSpread spread) {
    if (state.isDealing || spread == state.spread) return;
    state = state.copyWith(spread: spread, cards: <ArAltarCard>[], selectedCardId: null);
  }

  /// Draws unique cards into the spread slots one by one.
  Future<void> dealSpread({Duration interval = const Duration(milliseconds: 420)}) async {
    if (state.isDealing) return;
    if (!state.isMandalaAnchored) anchorMandala();

    final List<TarotCard> deck = List<TarotCard>.of(TarotCardData.allCards)..shuffle(_random);
    final List<String> positions = state.spread.positions;
    state = state.copyWith(isDealing: true, cards: <ArAltarCard>[], selectedCardId: null);
    SensoryService().shuffleHaptic();

    for (int i = 0; i < positions.length; i++) {
      if (interval > Duration.zero) await Future<void>.delayed(interval);
      if (!ref.mounted) return;
      final TarotCard card = deck[i].copyWith(
        isReversed: _random.nextDouble() < 0.3,
        positionName: positions[i],
      );
      state = state.copyWith(cards: <ArAltarCard>[
        ...state.cards,
        ArAltarCard(
          id: _uuid.v4(),
          card: card,
          slotIndex: i,
          positionName: positions[i],
          placedAt: DateTime.now(),
        ),
      ]);
      SensoryService().cardSelectionHaptic();
    }
    state = state.copyWith(isDealing: false);
  }

  /// First tap flips the card face up; later taps select it for insight.
  void tapCard(String id) {
    final List<ArAltarCard> updated = <ArAltarCard>[
      for (final ArAltarCard c in state.cards)
        if (c.id == id && !c.isRevealed) c.copyWith(isRevealed: true) else c,
    ];
    final bool flipped = updated.any((ArAltarCard c) => c.id == id && c.isRevealed) &&
        state.cards.any((ArAltarCard c) => c.id == id && !c.isRevealed);
    if (flipped) {
      SensoryService().cardFlipHaptic();
      SensoryService().playCardFlipSound();
    }
    state = state.copyWith(cards: updated, selectedCardId: id);
    if (flipped && state.allRevealed) SensoryService().completionHaptic();
  }

  void revealAll() {
    state = state.copyWith(cards: <ArAltarCard>[
      for (final ArAltarCard c in state.cards) c.copyWith(isRevealed: true),
    ]);
    SensoryService().playRevelationSound();
  }

  void clearSelection() => state = state.copyWith(selectedCardId: null);

  void clearAltar() {
    state = state.copyWith(cards: <ArAltarCard>[], selectedCardId: null, isDealing: false);
  }

  /// Opening prompt for handing the revealed spread to the Voice Oracle.
  String consultationPrompt() {
    final String cards = state.cards
        .where((ArAltarCard c) => c.isRevealed)
        .map((ArAltarCard c) =>
            '${c.positionName}: ${c.card.name}${c.card.isReversed ? ' reversed' : ''}')
        .join(', ');
    return 'I just laid this spread on my altar — $cards. What are these cards telling me together?';
  }
}
