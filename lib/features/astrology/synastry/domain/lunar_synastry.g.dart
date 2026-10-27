// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lunar_synastry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SynastryPartner _$SynastryPartnerFromJson(Map<String, dynamic> json) =>
    _SynastryPartner(
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      sunSign: json['sunSign'] as String,
      moonSign: json['moonSign'] as String,
      risingSign: json['risingSign'] as String,
      dominantElement: json['dominantElement'] as String,
      soulCardNumber: (json['soulCardNumber'] as num).toInt(),
      soulCardName: json['soulCardName'] as String,
    );

Map<String, dynamic> _$SynastryPartnerToJson(_SynastryPartner instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
      'sunSign': instance.sunSign,
      'moonSign': instance.moonSign,
      'risingSign': instance.risingSign,
      'dominantElement': instance.dominantElement,
      'soulCardNumber': instance.soulCardNumber,
      'soulCardName': instance.soulCardName,
    };

_SynastryAspect _$SynastryAspectFromJson(Map<String, dynamic> json) =>
    _SynastryAspect(
      title: json['title'] as String,
      placementA: json['placementA'] as String,
      placementB: json['placementB'] as String,
      aspectType: json['aspectType'] as String,
      harmonyStars: (json['harmonyStars'] as num).toInt(),
      dynamicDescription: json['dynamicDescription'] as String,
      tarotTalisman: json['tarotTalisman'] as String,
    );

Map<String, dynamic> _$SynastryAspectToJson(_SynastryAspect instance) =>
    <String, dynamic>{
      'title': instance.title,
      'placementA': instance.placementA,
      'placementB': instance.placementB,
      'aspectType': instance.aspectType,
      'harmonyStars': instance.harmonyStars,
      'dynamicDescription': instance.dynamicDescription,
      'tarotTalisman': instance.tarotTalisman,
    };

_LunarSynastryReading _$LunarSynastryReadingFromJson(
  Map<String, dynamic> json,
) => _LunarSynastryReading(
  partnerA: SynastryPartner.fromJson(json['partnerA'] as Map<String, dynamic>),
  partnerB: SynastryPartner.fromJson(json['partnerB'] as Map<String, dynamic>),
  compatibilityScore: (json['compatibilityScore'] as num).toInt(),
  bondTitle: json['bondTitle'] as String,
  relationshipArchetype: json['relationshipArchetype'] as String,
  elementalConfluence: json['elementalConfluence'] as String,
  elementalDynamic: json['elementalDynamic'] as String,
  elementalBalancePercent: (json['elementalBalancePercent'] as num).toDouble(),
  moonPhaseSynergy: json['moonPhaseSynergy'] as String,
  aspects: (json['aspects'] as List<dynamic>)
      .map((e) => SynastryAspect.fromJson(e as Map<String, dynamic>))
      .toList(),
  karmicLesson: json['karmicLesson'] as String,
  soulChallenge: json['soulChallenge'] as String,
  sacredRitual: json['sacredRitual'] as String,
  oracleProphecy: json['oracleProphecy'] as String,
);

Map<String, dynamic> _$LunarSynastryReadingToJson(
  _LunarSynastryReading instance,
) => <String, dynamic>{
  'partnerA': instance.partnerA,
  'partnerB': instance.partnerB,
  'compatibilityScore': instance.compatibilityScore,
  'bondTitle': instance.bondTitle,
  'relationshipArchetype': instance.relationshipArchetype,
  'elementalConfluence': instance.elementalConfluence,
  'elementalDynamic': instance.elementalDynamic,
  'elementalBalancePercent': instance.elementalBalancePercent,
  'moonPhaseSynergy': instance.moonPhaseSynergy,
  'aspects': instance.aspects,
  'karmicLesson': instance.karmicLesson,
  'soulChallenge': instance.soulChallenge,
  'sacredRitual': instance.sacredRitual,
  'oracleProphecy': instance.oracleProphecy,
};
