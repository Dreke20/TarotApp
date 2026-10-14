// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hexagram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hexagram _$HexagramFromJson(Map<String, dynamic> json) => _Hexagram(
  number: (json['number'] as num).toInt(),
  name: json['name'] as String,
  englishTitle: json['englishTitle'] as String,
  chineseCharacter: json['chineseCharacter'] as String,
  upperTrigram: json['upperTrigram'] as String,
  lowerTrigram: json['lowerTrigram'] as String,
  lines: (json['lines'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  judgment: json['judgment'] as String,
  image: json['image'] as String,
  guidance: json['guidance'] as String,
);

Map<String, dynamic> _$HexagramToJson(_Hexagram instance) => <String, dynamic>{
  'number': instance.number,
  'name': instance.name,
  'englishTitle': instance.englishTitle,
  'chineseCharacter': instance.chineseCharacter,
  'upperTrigram': instance.upperTrigram,
  'lowerTrigram': instance.lowerTrigram,
  'lines': instance.lines,
  'judgment': instance.judgment,
  'image': instance.image,
  'guidance': instance.guidance,
};
