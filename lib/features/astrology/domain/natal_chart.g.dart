// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'natal_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanetPlacement _$PlanetPlacementFromJson(Map<String, dynamic> json) =>
    _PlanetPlacement(
      planet: json['planet'] as String,
      symbol: json['symbol'] as String,
      sign: json['sign'] as String,
      element: json['element'] as String,
      house: json['house'] as String,
      meaning: json['meaning'] as String,
      tarotCorrelation: json['tarotCorrelation'] as String,
    );

Map<String, dynamic> _$PlanetPlacementToJson(_PlanetPlacement instance) =>
    <String, dynamic>{
      'planet': instance.planet,
      'symbol': instance.symbol,
      'sign': instance.sign,
      'element': instance.element,
      'house': instance.house,
      'meaning': instance.meaning,
      'tarotCorrelation': instance.tarotCorrelation,
    };

_NatalChart _$NatalChartFromJson(Map<String, dynamic> json) => _NatalChart(
  sunSign: json['sunSign'] as String,
  moonSign: json['moonSign'] as String,
  risingSign: json['risingSign'] as String,
  placements: (json['placements'] as List<dynamic>)
      .map((e) => PlanetPlacement.fromJson(e as Map<String, dynamic>))
      .toList(),
  firePercent: (json['firePercent'] as num).toDouble(),
  earthPercent: (json['earthPercent'] as num).toDouble(),
  airPercent: (json['airPercent'] as num).toDouble(),
  waterPercent: (json['waterPercent'] as num).toDouble(),
  dominantElement: json['dominantElement'] as String,
  soulArchetype: json['soulArchetype'] as String,
);

Map<String, dynamic> _$NatalChartToJson(_NatalChart instance) =>
    <String, dynamic>{
      'sunSign': instance.sunSign,
      'moonSign': instance.moonSign,
      'risingSign': instance.risingSign,
      'placements': instance.placements,
      'firePercent': instance.firePercent,
      'earthPercent': instance.earthPercent,
      'airPercent': instance.airPercent,
      'waterPercent': instance.waterPercent,
      'dominantElement': instance.dominantElement,
      'soulArchetype': instance.soulArchetype,
    };
