// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_reflection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudioReflection _$AudioReflectionFromJson(Map<String, dynamic> json) =>
    _AudioReflection(
      id: json['id'] as String,
      readingId: json['readingId'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      transcription: json['transcription'] as String,
      waveformSamples:
          (json['waveformSamples'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AudioReflectionToJson(_AudioReflection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'readingId': instance.readingId,
      'recordedAt': instance.recordedAt.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'transcription': instance.transcription,
      'waveformSamples': instance.waveformSamples,
    };
