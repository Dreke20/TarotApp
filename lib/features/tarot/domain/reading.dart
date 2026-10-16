import 'package:freezed_annotation/freezed_annotation.dart';
import 'tarot_card.dart';

part 'reading.freezed.dart';
part 'reading.g.dart';

@freezed
abstract class Reading with _$Reading {
  const factory Reading({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    required String question,
    @JsonKey(name: 'spread_type') required String spreadType,
    required List<TarotCard> cards,
    required String interpretation,
    String? summary,
    String? advice,
    @Default('') String notes,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'journey_recall') String? journeyRecall,
    @JsonKey(name: 'elemental_chemistry') String? elementalChemistry,
    @JsonKey(name: 'cosmic_weather') String? cosmicWeather,
    @JsonKey(name: 'scrying_prompts') @Default([]) List<String> scryingPrompts,
    @JsonKey(name: 'persona_id') String? personaId,
    @JsonKey(name: 'altar_consecration') String? altarConsecration,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Reading;

  factory Reading.fromJson(Map<String, dynamic> json) =>
      _$ReadingFromJson(json);
}
