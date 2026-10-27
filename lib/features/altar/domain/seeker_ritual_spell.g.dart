// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seeker_ritual_spell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RitualSpellStep _$RitualSpellStepFromJson(Map<String, dynamic> json) =>
    _RitualSpellStep(
      id: json['id'] as String,
      actionType: $enumDecode(_$RitualActionTypeEnumMap, json['actionType']),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      glyph: json['glyph'] as String,
      parameter: json['parameter'] as String? ?? '',
      durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$RitualSpellStepToJson(_RitualSpellStep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actionType': _$RitualActionTypeEnumMap[instance.actionType]!,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'glyph': instance.glyph,
      'parameter': instance.parameter,
      'durationSeconds': instance.durationSeconds,
    };

const _$RitualActionTypeEnumMap = {
  RitualActionType.riffleShuffle: 'riffleShuffle',
  RitualActionType.celticScatter: 'celticScatter',
  RitualActionType.threePilesCut: 'threePilesCut',
  RitualActionType.herbSmoke: 'herbSmoke',
  RitualActionType.crystalGrid: 'crystalGrid',
  RitualActionType.sacredBreath: 'sacredBreath',
  RitualActionType.intentionAnchor: 'intentionAnchor',
};

_SeekerRitualSpell _$SeekerRitualSpellFromJson(Map<String, dynamic> json) =>
    _SeekerRitualSpell(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      glyph: json['glyph'] as String,
      accentColorHex: json['accentColorHex'] as String? ?? '#D4AF37',
      steps: (json['steps'] as List<dynamic>)
          .map((e) => RitualSpellStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCurated: json['isCurated'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SeekerRitualSpellToJson(_SeekerRitualSpell instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'glyph': instance.glyph,
      'accentColorHex': instance.accentColorHex,
      'steps': instance.steps,
      'isCurated': instance.isCurated,
      'createdAt': instance.createdAt.toIso8601String(),
    };
