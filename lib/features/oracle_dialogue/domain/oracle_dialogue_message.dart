import 'package:freezed_annotation/freezed_annotation.dart';
import '../../tarot/domain/tarot_card.dart';

part 'oracle_dialogue_message.freezed.dart';
part 'oracle_dialogue_message.g.dart';

enum DialogueSender { seeker, oracle }

enum DialogueState { idle, listening, synthesizing, speaking, complete }

@freezed
abstract class OracleDialogueMessage with _$OracleDialogueMessage {
  const factory OracleDialogueMessage({
    required String id,
    required DialogueSender sender,
    required String text,
    required DateTime timestamp,
    TarotCard? referencedCard,
    String? personaId,
    @Default(false) bool isSpoken,
  }) = _OracleDialogueMessage;

  factory OracleDialogueMessage.fromJson(Map<String, dynamic> json) =>
      _$OracleDialogueMessageFromJson(json);
}
