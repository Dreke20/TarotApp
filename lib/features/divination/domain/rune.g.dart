// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rune.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Rune _$RuneFromJson(Map<String, dynamic> json) => _Rune(
  id: json['id'] as String,
  name: json['name'] as String,
  symbol: json['symbol'] as String,
  englishMeaning: json['englishMeaning'] as String,
  aett: json['aett'] as String,
  uprightMeaning: json['uprightMeaning'] as String,
  reversedMeaning: json['reversedMeaning'] as String,
  isReversed: json['isReversed'] as bool? ?? false,
  positionName: json['positionName'] as String?,
);

Map<String, dynamic> _$RuneToJson(_Rune instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'symbol': instance.symbol,
  'englishMeaning': instance.englishMeaning,
  'aett': instance.aett,
  'uprightMeaning': instance.uprightMeaning,
  'reversedMeaning': instance.reversedMeaning,
  'isReversed': instance.isReversed,
  'positionName': instance.positionName,
};
