// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celestial_transit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CelestialTransitBody _$CelestialTransitBodyFromJson(
  Map<String, dynamic> json,
) => _CelestialTransitBody(
  name: json['name'] as String,
  glyph: json['glyph'] as String,
  sign: json['sign'] as String,
  degree: (json['degree'] as num).toDouble(),
  element: json['element'] as String,
  isRetrograde: json['isRetrograde'] as bool? ?? false,
  house: (json['house'] as num?)?.toInt() ?? 1,
  tarotArchetype: json['tarotArchetype'] as String,
);

Map<String, dynamic> _$CelestialTransitBodyToJson(
  _CelestialTransitBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'glyph': instance.glyph,
  'sign': instance.sign,
  'degree': instance.degree,
  'element': instance.element,
  'isRetrograde': instance.isRetrograde,
  'house': instance.house,
  'tarotArchetype': instance.tarotArchetype,
};

_TransitAspect _$TransitAspectFromJson(Map<String, dynamic> json) =>
    _TransitAspect(
      transitingPlanet: json['transitingPlanet'] as String,
      transitingGlyph: json['transitingGlyph'] as String,
      natalPlacement: json['natalPlacement'] as String,
      natalGlyph: json['natalGlyph'] as String,
      aspectType: json['aspectType'] as String,
      aspectGlyph: json['aspectGlyph'] as String,
      orbDegrees: (json['orbDegrees'] as num).toDouble(),
      isHarmonious: json['isHarmonious'] as bool,
      channelingGuidance: json['channelingGuidance'] as String,
    );

Map<String, dynamic> _$TransitAspectToJson(_TransitAspect instance) =>
    <String, dynamic>{
      'transitingPlanet': instance.transitingPlanet,
      'transitingGlyph': instance.transitingGlyph,
      'natalPlacement': instance.natalPlacement,
      'natalGlyph': instance.natalGlyph,
      'aspectType': instance.aspectType,
      'aspectGlyph': instance.aspectGlyph,
      'orbDegrees': instance.orbDegrees,
      'isHarmonious': instance.isHarmonious,
      'channelingGuidance': instance.channelingGuidance,
    };

_PlanetaryHour _$PlanetaryHourFromJson(Map<String, dynamic> json) =>
    _PlanetaryHour(
      planetName: json['planetName'] as String,
      planetGlyph: json['planetGlyph'] as String,
      dayRuler: json['dayRuler'] as String,
      hourIndex: (json['hourIndex'] as num).toInt(),
      isDayHour: json['isDayHour'] as bool,
      rulingElement: json['rulingElement'] as String,
      sacredVibration: json['sacredVibration'] as String,
      consecrationMantra: json['consecrationMantra'] as String,
      recommendedSpread: json['recommendedSpread'] as String,
    );

Map<String, dynamic> _$PlanetaryHourToJson(_PlanetaryHour instance) =>
    <String, dynamic>{
      'planetName': instance.planetName,
      'planetGlyph': instance.planetGlyph,
      'dayRuler': instance.dayRuler,
      'hourIndex': instance.hourIndex,
      'isDayHour': instance.isDayHour,
      'rulingElement': instance.rulingElement,
      'sacredVibration': instance.sacredVibration,
      'consecrationMantra': instance.consecrationMantra,
      'recommendedSpread': instance.recommendedSpread,
    };

_CelestialTransitSnapshot _$CelestialTransitSnapshotFromJson(
  Map<String, dynamic> json,
) => _CelestialTransitSnapshot(
  timestamp: DateTime.parse(json['timestamp'] as String),
  planetaryHour: PlanetaryHour.fromJson(
    json['planetaryHour'] as Map<String, dynamic>,
  ),
  bodies: (json['bodies'] as List<dynamic>)
      .map((e) => CelestialTransitBody.fromJson(e as Map<String, dynamic>))
      .toList(),
  aspects: (json['aspects'] as List<dynamic>)
      .map((e) => TransitAspect.fromJson(e as Map<String, dynamic>))
      .toList(),
  lunarPhase: json['lunarPhase'] as String,
  lunarIllumination: (json['lunarIllumination'] as num).toDouble(),
);

Map<String, dynamic> _$CelestialTransitSnapshotToJson(
  _CelestialTransitSnapshot instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp.toIso8601String(),
  'planetaryHour': instance.planetaryHour,
  'bodies': instance.bodies,
  'aspects': instance.aspects,
  'lunarPhase': instance.lunarPhase,
  'lunarIllumination': instance.lunarIllumination,
};
