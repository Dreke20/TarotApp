import 'package:freezed_annotation/freezed_annotation.dart';

part 'tarot_card.freezed.dart';
part 'tarot_card.g.dart';

@freezed
abstract class TarotCard with _$TarotCard {
  const factory TarotCard({
    required String id,
    required String name,
    required String arcana,
    String? suit,
    int? number,
    required String meaningUpright,
    required String meaningReversed,
    @Default([]) List<String> keywords,
    String? element,
    String? astrology,
    @Default(false) bool isReversed,
    String? positionName,
    String? assetPath,
    String? imageUrl,
  }) = _TarotCard;

  factory TarotCard.fromJson(Map<String, dynamic> json) =>
      _$TarotCardFromJson(json);
}
