import 'package:freezed_annotation/freezed_annotation.dart';

part 'hands_free_voice_state.freezed.dart';
part 'hands_free_voice_state.g.dart';

/// State of the hands-free conversational voice engine.
@freezed
abstract class HandsFreeVoiceState with _$HandsFreeVoiceState {
  const factory HandsFreeVoiceState({
    @Default(false) bool isListening,
    @Default(false) bool isSpeaking,
    @Default(false) bool isProcessing,
    @Default('') String currentTranscript,
    @Default(0.0) double speechConfidence,
    @Default(0.0) double soundLevel,
    @Default(true) bool handsFreeEnabled,
    @Default(1.0) double duckingLevel,
    String? lastFinalizedInquiry,
  }) = _HandsFreeVoiceState;

  factory HandsFreeVoiceState.fromJson(Map<String, dynamic> json) =>
      _$HandsFreeVoiceStateFromJson(json);
}
