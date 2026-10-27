import 'package:freezed_annotation/freezed_annotation.dart';
import '../../tarot/domain/tarot_card.dart';

part 'oracle_dialogue_reply.freezed.dart';

/// Immutable result of a single Oracle dialogue turn.
@freezed
abstract class OracleDialogueReply with _$OracleDialogueReply {
  const factory OracleDialogueReply({
    required String text,
    TarotCard? drawnCard,
    @Default(false) bool isOfflineFallback,
  }) = _OracleDialogueReply;
}
