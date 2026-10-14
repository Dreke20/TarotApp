// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_spread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomSpread _$CustomSpreadFromJson(Map<String, dynamic> json) =>
    _CustomSpread(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      positions: (json['positions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      layoutType: json['layoutType'] as String? ?? 'custom',
      isUserCreated: json['isUserCreated'] as bool? ?? true,
    );

Map<String, dynamic> _$CustomSpreadToJson(_CustomSpread instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'positions': instance.positions,
      'layoutType': instance.layoutType,
      'isUserCreated': instance.isUserCreated,
    };
