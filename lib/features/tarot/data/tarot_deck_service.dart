import 'dart:math';
import '../domain/spread_type.dart';
import '../domain/tarot_card.dart';
import 'tarot_card_data.dart';

/// Service responsible for deck initialization, Fisher-Yates shuffling,
/// drawing cards according to spread rules, and mapping card assets.
class TarotDeckService {
  final Random _random;

  TarotDeckService({Random? random}) : _random = random ?? Random();

  /// Asset map linking card IDs (e.g. 'wands_ace') to local asset paths
  static final Map<String, String> cardAssets = {
    for (final card in TarotCardData.allCards)
      card.id: 'assets/cards/${card.id}.png',
  };

  /// Returns a fresh full standard 78-card deck
  List<TarotCard> getFullDeck() {
    return List<TarotCard>.from(TarotCardData.allCards);
  }

  /// Implements the Fisher-Yates shuffle algorithm.
  /// Also introduces a natural probability of cards appearing reversed.
  List<TarotCard> shuffleDeck({
    List<TarotCard>? deck,
    bool allowReversals = true,
    double reversalChance = 0.25,
  }) {
    final list = List<TarotCard>.from(deck ?? TarotCardData.allCards);

    // Fisher-Yates Shuffle
    for (int i = list.length - 1; i > 0; i--) {
      final n = _random.nextInt(i + 1);
      final temp = list[i];
      list[i] = list[n];
      list[n] = temp;
    }

    // Apply orientation and asset mappings
    return list.map((card) {
      final isReversed =
          allowReversals && (_random.nextDouble() < reversalChance);
      final asset = cardAssets[card.id] ?? 'assets/cards/${card.id}.png';
      return card.copyWith(
        isReversed: isReversed,
        assetPath: asset,
      );
    }).toList();
  }

  /// Draws cards for a given SpreadType from the shuffled deck,
  /// attaching the respective position titles (e.g. Past, Present, Future).
  List<TarotCard> drawSpread({
    required SpreadType spreadType,
    List<TarotCard>? shuffledDeck,
  }) {
    final deck = shuffledDeck ?? shuffleDeck();
    final count = spreadType.cardCount;

    if (deck.length < count) {
      throw StateError('Not enough cards in deck to draw spread $spreadType');
    }

    final drawn = <TarotCard>[];
    for (int i = 0; i < count; i++) {
      final positionTitle = i < spreadType.positionTitles.length
          ? spreadType.positionTitles[i]
          : 'Card ${i + 1}';
      final card = deck[i].copyWith(positionName: positionTitle);
      drawn.add(card);
    }

    return drawn;
  }
}
