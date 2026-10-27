import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../tarot/domain/oracle_persona.dart';
import '../../domain/oracle_dialogue_message.dart';

part 'oracle_dialogue_state.freezed.dart';

@freezed
abstract class OracleDialogueViewState with _$OracleDialogueViewState {
  const factory OracleDialogueViewState({
    @Default(<OracleDialogueMessage>[]) List<OracleDialogueMessage> messages,
    @Default(DialogueState.idle) DialogueState phase,
    @Default('') String liveTranscript,
    @Default(0.0) double soundLevel,
    @Default(true) bool isHandsFree,
    @Default(false) bool isSpeechAvailable,
    @Default(false) bool isVoiceMuted,
    @Default(OraclePersona.highPriestess) OraclePersona persona,
    String? errorMessage,
  }) = _OracleDialogueViewState;
}
