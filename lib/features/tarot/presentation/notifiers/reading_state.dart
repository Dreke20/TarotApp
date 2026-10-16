import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/altar_theme.dart';
import '../../domain/oracle_message.dart';
import '../../domain/reading.dart';
import '../../domain/spread_type.dart';
import '../../domain/synastry_partner.dart';
import '../../domain/tarot_card.dart';
import '../../domain/tarot_deck_theme.dart';

part 'reading_state.freezed.dart';

@freezed
abstract class ReadingState with _$ReadingState {
  const factory ReadingState({
    @Default(SpreadType.dailyGuidance) SpreadType spreadType,
    @Default('') String question,
    @Default([]) List<TarotCard> drawnCards,
    @Default({}) Set<int> revealedIndices,
    @Default(false) bool isShuffling,
    @Default(false) bool isDealing,
    @Default(false) bool isConsultingOracle,
    @Default(false) bool isAskingFollowUp,
    Reading? currentReading,
    @Default([]) List<Reading> history,
    @Default([]) List<OracleMessage> conversationHistory,
    @Default(TarotDeckTheme.classic) TarotDeckTheme deckTheme,
    @Default(AltarTheme.midnightNebula) AltarTheme altarTheme,
    int? selectedInspectIndex,
    String? errorMessage,
    SynastryPartner? synastryPartner,
  }) = _ReadingState;

  const ReadingState._();

  bool get hasDrawnCards => drawnCards.isNotEmpty;
  bool get allCardsRevealed =>
      hasDrawnCards && revealedIndices.length == drawnCards.length;
}
