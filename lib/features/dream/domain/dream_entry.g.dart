// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DreamEntry _$DreamEntryFromJson(Map<String, dynamic> json) => _DreamEntry(
  id: json['id'] as String,
  recordedAt: DateTime.parse(json['recordedAt'] as String),
  title: json['title'] as String,
  narrative: json['narrative'] as String,
  mood: json['mood'] as String,
  symbols:
      (json['symbols'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  jungianAnalysis: json['jungianAnalysis'] as String?,
  correlatedTarotCardId: json['correlatedTarotCardId'] as String?,
  correlatedTarotCardName: json['correlatedTarotCardName'] as String?,
  archetypalMessage: json['archetypalMessage'] as String?,
);

Map<String, dynamic> _$DreamEntryToJson(_DreamEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recordedAt': instance.recordedAt.toIso8601String(),
      'title': instance.title,
      'narrative': instance.narrative,
      'mood': instance.mood,
      'symbols': instance.symbols,
      'jungianAnalysis': instance.jungianAnalysis,
      'correlatedTarotCardId': instance.correlatedTarotCardId,
      'correlatedTarotCardName': instance.correlatedTarotCardName,
      'archetypalMessage': instance.archetypalMessage,
    };
