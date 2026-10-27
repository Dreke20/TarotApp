import 'package:freezed_annotation/freezed_annotation.dart';
import 'tarot_card.dart';

part 'card_pair_synergy.freezed.dart';
part 'card_pair_synergy.g.dart';

Map<String, dynamic> _cardToJson(TarotCard card) => card.toJson();

/// Represents the alchemical resonance and synthesis between any two tarot cards.
@freezed
abstract class CardPairSynergy with _$CardPairSynergy {
  const factory CardPairSynergy({
    @JsonKey(toJson: _cardToJson) required TarotCard firstCard,
    @JsonKey(toJson: _cardToJson) required TarotCard secondCard,
    required String alchemicalTitle,
    required String alchemicalPhase,
    required String element1,
    required String element2,
    required String elementalReaction,
    required int harmonyScore,
    required String tensionType,
    required String synthesisInsight,
    required String actionableFormula,
  }) = _CardPairSynergy;

  factory CardPairSynergy.fromJson(Map<String, dynamic> json) =>
      _$CardPairSynergyFromJson(json);
}
