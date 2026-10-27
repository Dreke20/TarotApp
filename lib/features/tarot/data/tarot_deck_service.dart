import 'dart:math';
import '../domain/spread_type.dart';
import '../domain/tarot_card.dart';
import 'tarot_card_data.dart';

/// Service responsible for deck initialization, Fisher-Yates shuffling,
/// drawing cards according to spread rules, and mapping card assets.
class TarotDeckService {
  final Random _random;

  TarotDeckService({Random? random}) : _random = random ?? Random();

  /// Asset map linking card IDs (e.g. 'wands_ace') to local asset paths.
  /// All card artwork ships as `.webp` under `assets/cards/`.
  static final Map<String, String> cardAssets = {
    for (final card in TarotCardData.allCards)
      card.id: 'assets/cards/${card.id}.webp',
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
      final asset = cardAssets[card.id] ?? 'assets/cards/${card.id}.webp';
      return card.copyWith(
        isReversed: isReversed,
        assetPath: asset,
      );
    }).toList();
  }

  /// Implements physical 3D Riffle Shuffle based on the Gilbert-Shannon-Reeds model.
  /// Splits deck into two halves with natural clumping and interlacing.
  List<TarotCard> riffleShuffleDeck({
    List<TarotCard>? deck,
    int passes = 3,
    bool allowReversals = true,
  }) {
    List<TarotCard> current = List<TarotCard>.from(deck ?? TarotCardData.allCards);

    for (int p = 0; p < passes; p++) {
      // Split with human binomial variation around center
      final int splitVariation = _random.nextInt(7) - 3;
      final int splitPoint = (current.length ~/ 2 + splitVariation).clamp(10, current.length - 10);

      List<TarotCard> left = current.sublist(0, splitPoint);
      List<TarotCard> right = current.sublist(splitPoint);

      // Rotate half by 180 degrees if reversals are enabled
      if (allowReversals && _random.nextBool()) {
        right = right.map((c) => c.copyWith(isReversed: !c.isReversed)).toList();
      }

      final List<TarotCard> interlaced = [];
      int idxLeft = 0;
      int idxRight = 0;

      // Realistic physical card dropping (1 to 3 cards drop from either side)
      while (idxLeft < left.length || idxRight < right.length) {
        if (idxLeft < left.length && idxRight < right.length) {
          final bool takeFromLeft = _random.nextBool();
          final int dropCount = _random.nextInt(3) + 1;

          if (takeFromLeft) {
            final int end = (idxLeft + dropCount).clamp(0, left.length);
            interlaced.addAll(left.sublist(idxLeft, end));
            idxLeft = end;
          } else {
            final int end = (idxRight + dropCount).clamp(0, right.length);
            interlaced.addAll(right.sublist(idxRight, end));
            idxRight = end;
          }
        } else if (idxLeft < left.length) {
          interlaced.addAll(left.sublist(idxLeft));
          idxLeft = left.length;
        } else {
          interlaced.addAll(right.sublist(idxRight));
          idxRight = right.length;
        }
      }

      current = interlaced;
    }

    return current.map((c) {
      final asset = cardAssets[c.id] ?? 'assets/cards/${c.id}.webp';
      return c.copyWith(assetPath: asset);
    }).toList();
  }

  /// Sacred Tri-Fold Cut: splits deck into 3 piles (Past, Present, Future)
  /// and restacks according to seeker's intuitive selection order.
  List<TarotCard> threePileCutDeck({
    List<TarotCard>? deck,
    List<int>? restackOrder, // e.g. [1, 2, 0]
  }) {
    final List<TarotCard> current = List<TarotCard>.from(deck ?? TarotCardData.allCards);
    final int third = current.length ~/ 3;

    final pile0 = current.sublist(0, third);
    final pile1 = current.sublist(third, third * 2);
    final pile2 = current.sublist(third * 2);

    final piles = [pile0, pile1, pile2];
    final order = restackOrder ?? [2, 0, 1];

    final List<TarotCard> restacked = [];
    for (final pileIndex in order) {
      if (pileIndex >= 0 && pileIndex < 3) {
        restacked.addAll(piles[pileIndex]);
      }
    }

    return restacked.map((c) {
      final asset = cardAssets[c.id] ?? 'assets/cards/${c.id}.webp';
      return c.copyWith(assetPath: asset);
    }).toList();
  }

  /// Celtic Chaos Wash: physical circular table swirl scrambling positions and orientations.
  List<TarotCard> celticChaosScatter({
    List<TarotCard>? deck,
    bool allowReversals = true,
  }) {
    final list = List<TarotCard>.from(deck ?? TarotCardData.allCards);
    list.shuffle(_random);

    return list.map((c) {
      final bool rev = allowReversals ? _random.nextBool() : false;
      final asset = cardAssets[c.id] ?? 'assets/cards/${c.id}.webp';
      return c.copyWith(isReversed: rev, assetPath: asset);
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
