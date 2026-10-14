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
  'created_at': instance.createdAt.toIso8601String(),
};
