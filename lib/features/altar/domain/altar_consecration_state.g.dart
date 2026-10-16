// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altar_consecration_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AltarConsecrationState _$AltarConsecrationStateFromJson(
  Map<String, dynamic> json,
) => _AltarConsecrationState(
  activeHerb:
      $enumDecodeNullable(_$SacredHerbEnumMap, json['activeHerb']) ??
      SacredHerb.paloSanto,
  isPurified: json['isPurified'] as bool? ?? false,
  purificationProgress:
      (json['purificationProgress'] as num?)?.toDouble() ?? 0.0,
  placedCrystals:
      (json['placedCrystals'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {
        'topLeft': 'clear_quartz',
        'topRight': 'amethyst',
        'bottomLeft': 'black_tourmaline',
        'bottomRight': 'citrine',
      },
  lastPurifiedAt: json['lastPurifiedAt'] == null
      ? null
      : DateTime.parse(json['lastPurifiedAt'] as String),
);

Map<String, dynamic> _$AltarConsecrationStateToJson(
  _AltarConsecrationState instance,
) => <String, dynamic>{
  'activeHerb': _$SacredHerbEnumMap[instance.activeHerb]!,
  'isPurified': instance.isPurified,
  'purificationProgress': instance.purificationProgress,
  'placedCrystals': instance.placedCrystals,
  'lastPurifiedAt': instance.lastPurifiedAt?.toIso8601String(),
};

const _$SacredHerbEnumMap = {
  SacredHerb.paloSanto: 'paloSanto',
  SacredHerb.whiteSage: 'whiteSage',
  SacredHerb.copalResin: 'copalResin',
  SacredHerb.lavenderMugwort: 'lavenderMugwort',
  SacredHerb.atlasCedar: 'atlasCedar',
};
