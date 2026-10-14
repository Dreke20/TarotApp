// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collective_pulse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollectiveWish _$CollectiveWishFromJson(Map<String, dynamic> json) =>
    _CollectiveWish(
      id: json['id'] as String,
      intention: json['intention'] as String,
      zodiacSign: json['zodiacSign'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CollectiveWishToJson(_CollectiveWish instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intention': instance.intention,
      'zodiacSign': instance.zodiacSign,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_CollectivePulse _$CollectivePulseFromJson(Map<String, dynamic> json) =>
    _CollectivePulse(
      dominantGlobalCardName: json['dominantGlobalCardName'] as String,
      dominantCardArcana: json['dominantCardArcana'] as String,
      dominantAuraEnergy: json['dominantAuraEnergy'] as String,
      totalReadingsToday: (json['totalReadingsToday'] as num).toInt(),
      topDrawnCards: (json['topDrawnCards'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recentWishes: (json['recentWishes'] as List<dynamic>)
          .map((e) => CollectiveWish.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectivePulseToJson(_CollectivePulse instance) =>
    <String, dynamic>{
      'dominantGlobalCardName': instance.dominantGlobalCardName,
      'dominantCardArcana': instance.dominantCardArcana,
      'dominantAuraEnergy': instance.dominantAuraEnergy,
      'totalReadingsToday': instance.totalReadingsToday,
      'topDrawnCards': instance.topDrawnCards,
      'recentWishes': instance.recentWishes,
    };
