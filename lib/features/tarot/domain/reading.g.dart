// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reading _$ReadingFromJson(Map<String, dynamic> json) => _Reading(
  id: json['id'] as String,
  userId: json['user_id'] as String?,
  question: json['question'] as String,
  spreadType: json['spread_type'] as String,
  cards: (json['cards'] as List<dynamic>)
      .map((e) => TarotCard.fromJson(e as Map<String, dynamic>))
      .toList(),
  interpretation: json['interpretation'] as String,
  summary: json['summary'] as String?,
  advice: json['advice'] as String?,
  notes: json['notes'] as String? ?? '',
  isFavorite: json['is_favorite'] as bool? ?? false,
  journeyRecall: json['journey_recall'] as String?,
  elementalChemistry: json['elemental_chemistry'] as String?,
  cosmicWeather: json['cosmic_weather'] as String?,
  scryingPrompts:
      (json['scrying_prompts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  personaId: json['persona_id'] as String?,
  altarConsecration: json['altar_consecration'] as String?,
  microRitual: json['micro_ritual'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ReadingToJson(_Reading instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'question': instance.question,
  'spread_type': instance.spreadType,
  'cards': instance.cards,
  'interpretation': instance.interpretation,
  'summary': instance.summary,
  'advice': instance.advice,
  'notes': instance.notes,
  'is_favorite': instance.isFavorite,
  'journey_recall': instance.journeyRecall,
  'elemental_chemistry': instance.elementalChemistry,
  'cosmic_weather': instance.cosmicWeather,
  'scrying_prompts': instance.scryingPrompts,
  'persona_id': instance.personaId,
  'altar_consecration': instance.altarConsecration,
  'micro_ritual': instance.microRitual,
  'created_at': instance.createdAt.toIso8601String(),
};
