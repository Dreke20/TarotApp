import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/collective_pulse.dart';

part 'collective_notifier.g.dart';

@Riverpod(keepAlive: true)
class CollectiveNotifier extends _$CollectiveNotifier {
  @override
  CollectivePulse build() {
    return _initialPulse;
  }

  static final _initialPulse = CollectivePulse(
    dominantGlobalCardName: 'XVII. The Star',
    dominantCardArcana: 'Major Arcana',
    dominantAuraEnergy: 'Transcendent Hope, Intuitive Rebirth, and Spiritual Healing',
    totalReadingsToday: 1428,
    topDrawnCards: [
      'XVII. The Star (42% Frequency)',
      '0. The Fool (26% Frequency)',
      'XIX. The Sun (18% Frequency)',
      'III. The Empress (14% Frequency)',
    ],
    recentWishes: [
      CollectiveWish(
        id: 'w1',
        intention: 'May peace and soft gentle healing reach all souls carrying silent sorrow tonight.',
        zodiacSign: 'Pisces',
        createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      CollectiveWish(
        id: 'w2',
        intention: 'Courage to walk away from what is stagnant and embrace the unwritten dawn.',
        zodiacSign: 'Aries',
        createdAt: DateTime.now().subtract(const Duration(minutes: 34)),
      ),
      CollectiveWish(
        id: 'w3',
        intention: 'Deep abundance and rooted clarity for all divine creative projects.',
        zodiacSign: 'Taurus',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ],
  );

  void releaseWish(String intention, String zodiacSign) {
    final newWish = CollectiveWish(
      id: 'wish_${DateTime.now().millisecondsSinceEpoch}',
      intention: intention.trim(),
      zodiacSign: zodiacSign,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      recentWishes: [newWish, ...state.recentWishes],
      totalReadingsToday: state.totalReadingsToday + 1,
    );
  }
}
