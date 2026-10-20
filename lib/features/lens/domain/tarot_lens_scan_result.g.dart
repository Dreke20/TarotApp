// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarot_lens_scan_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TarotLensScanResult _$TarotLensScanResultFromJson(Map<String, dynamic> json) =>
    _TarotLensScanResult(
      card: TarotCard.fromJson(json['card'] as Map<String, dynamic>),
      confidencePercent: (json['confidencePercent'] as num?)?.toInt() ?? 96,
      isReversed: json['isReversed'] as bool? ?? false,
      detectedSymbols:
          (json['detectedSymbols'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      scryingAnalysis: json['scryingAnalysis'] as String,
      physicalAltarRitual: json['physicalAltarRitual'] as String,
      capturedImagePath: json['capturedImagePath'] as String?,
      isHighConfidence: json['isHighConfidence'] as bool? ?? true,
    );

Map<String, dynamic> _$TarotLensScanResultToJson(
  _TarotLensScanResult instance,
) => <String, dynamic>{
  'card': instance.card,
  'confidencePercent': instance.confidencePercent,
  'isReversed': instance.isReversed,
  'detectedSymbols': instance.detectedSymbols,
  'scryingAnalysis': instance.scryingAnalysis,
  'physicalAltarRitual': instance.physicalAltarRitual,
  'capturedImagePath': instance.capturedImagePath,
  'isHighConfidence': instance.isHighConfidence,
};
