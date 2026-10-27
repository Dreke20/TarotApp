// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celestial_bazaar_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActiveSanctuaryCandle _$ActiveSanctuaryCandleFromJson(
  Map<String, dynamic> json,
) => _ActiveSanctuaryCandle(
  id: json['id'] as String,
  type: $enumDecode(_$CandleTypeEnumMap, json['type']),
  intention: json['intention'] as String,
  litAt: DateTime.parse(json['litAt'] as String),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$ActiveSanctuaryCandleToJson(
  _ActiveSanctuaryCandle instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$CandleTypeEnumMap[instance.type]!,
  'intention': instance.intention,
  'litAt': instance.litAt.toIso8601String(),
  'expiresAt': instance.expiresAt.toIso8601String(),
};

const _$CandleTypeEnumMap = {
  CandleType.protection: 'protection',
  CandleType.love: 'love',
  CandleType.abundance: 'abundance',
  CandleType.clarity: 'clarity',
};

_CelestialFlashDiscount _$CelestialFlashDiscountFromJson(
  Map<String, dynamic> json,
) => _CelestialFlashDiscount(
  title: json['title'] as String,
  subtitle: json['subtitle'] as String,
  badgeText: json['badgeText'] as String,
  discountPercent: (json['discountPercent'] as num).toInt(),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  primaryColorHex: (json['primaryColorHex'] as num).toInt(),
);

Map<String, dynamic> _$CelestialFlashDiscountToJson(
  _CelestialFlashDiscount instance,
) => <String, dynamic>{
  'title': instance.title,
  'subtitle': instance.subtitle,
  'badgeText': instance.badgeText,
  'discountPercent': instance.discountPercent,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'primaryColorHex': instance.primaryColorHex,
};

_SynastryDossier _$SynastryDossierFromJson(Map<String, dynamic> json) =>
    _SynastryDossier(
      id: json['id'] as String,
      seekerName: json['seekerName'] as String,
      partnerName: json['partnerName'] as String,
      seekerSign: json['seekerSign'] as String,
      partnerSign: json['partnerSign'] as String,
      harmonyScore: (json['harmonyScore'] as num).toInt(),
      connectionArchetype: json['connectionArchetype'] as String,
      channeledReading: json['channeledReading'] as String,
      coreThemes: (json['coreThemes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$SynastryDossierToJson(_SynastryDossier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seekerName': instance.seekerName,
      'partnerName': instance.partnerName,
      'seekerSign': instance.seekerSign,
      'partnerSign': instance.partnerSign,
      'harmonyScore': instance.harmonyScore,
      'connectionArchetype': instance.connectionArchetype,
      'channeledReading': instance.channeledReading,
      'coreThemes': instance.coreThemes,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };
