// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarot_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TarotCard _$TarotCardFromJson(Map<String, dynamic> json) => _TarotCard(
  id: json['id'] as String,
  name: json['name'] as String,
  arcana: json['arcana'] as String,
  suit: json['suit'] as String?,
  number: (json['number'] as num?)?.toInt(),
  meaningUpright: json['meaningUpright'] as String,
  meaningReversed: json['meaningReversed'] as String,
  keywords:
      (json['keywords'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  element: json['element'] as String?,
  astrology: json['astrology'] as String?,
  isReversed: json['isReversed'] as bool? ?? false,
  positionName: json['positionName'] as String?,
  assetPath: json['assetPath'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$TarotCardToJson(_TarotCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'arcana': instance.arcana,
      'suit': instance.suit,
      'number': instance.number,
      'meaningUpright': instance.meaningUpright,
      'meaningReversed': instance.meaningReversed,
      'keywords': instance.keywords,
      'element': instance.element,
      'astrology': instance.astrology,
      'isReversed': instance.isReversed,
      'positionName': instance.positionName,
      'assetPath': instance.assetPath,
      'imageUrl': instance.imageUrl,
    };
