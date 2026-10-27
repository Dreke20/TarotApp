// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hands_free_voice_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HandsFreeVoiceState _$HandsFreeVoiceStateFromJson(Map<String, dynamic> json) =>
    _HandsFreeVoiceState(
      isListening: json['isListening'] as bool? ?? false,
      isSpeaking: json['isSpeaking'] as bool? ?? false,
      isProcessing: json['isProcessing'] as bool? ?? false,
      currentTranscript: json['currentTranscript'] as String? ?? '',
      speechConfidence: (json['speechConfidence'] as num?)?.toDouble() ?? 0.0,
      soundLevel: (json['soundLevel'] as num?)?.toDouble() ?? 0.0,
      handsFreeEnabled: json['handsFreeEnabled'] as bool? ?? true,
      duckingLevel: (json['duckingLevel'] as num?)?.toDouble() ?? 1.0,
      lastFinalizedInquiry: json['lastFinalizedInquiry'] as String?,
    );

Map<String, dynamic> _$HandsFreeVoiceStateToJson(
  _HandsFreeVoiceState instance,
) => <String, dynamic>{
  'isListening': instance.isListening,
  'isSpeaking': instance.isSpeaking,
  'isProcessing': instance.isProcessing,
  'currentTranscript': instance.currentTranscript,
  'speechConfidence': instance.speechConfidence,
  'soundLevel': instance.soundLevel,
  'handsFreeEnabled': instance.handsFreeEnabled,
  'duckingLevel': instance.duckingLevel,
  'lastFinalizedInquiry': instance.lastFinalizedInquiry,
};
