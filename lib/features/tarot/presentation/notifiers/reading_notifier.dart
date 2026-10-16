import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../../core/services/streak_service.dart';
import '../../../../core/supabase/supabase_client.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../data/tarot_deck_service.dart';
import '../../data/tarot_repository.dart';
import '../../domain/altar_theme.dart';
import '../../domain/oracle_message.dart';
import '../../domain/reading.dart';
import '../../domain/spread_type.dart';
import '../../domain/synastry_partner.dart';
import '../../domain/tarot_card.dart';
import '../../domain/tarot_deck_theme.dart';
import '../../services/tarot_widget_service.dart';
import 'reading_state.dart';

part 'reading_notifier.g.dart';

@riverpod
class ReadingNotifier extends _$ReadingNotifier {
  late TarotDeckService _deckService;
  late TarotRepository _repository;
  late SensoryService _sensory;

  @override
  ReadingState build() {
    final client = ref.watch(supabaseClientProvider);
    _deckService = TarotDeckService();
    _repository = TarotRepository(client);
    _sensory = ref.watch(sensoryServiceProvider);

    // Asynchronously load reading history on initialization
    Future.microtask(() => loadHistory());

    return const ReadingState();
  }

  /// Sets the active tarot spread
  void setSpreadType(SpreadType type) {
    if (state.spreadType == type) return;
    _sensory.cardSelectionHaptic();
    state = state.copyWith(
      spreadType: type,
      drawnCards: [],
      revealedIndices: {},
      currentReading: null,
      errorMessage: null,
      conversationHistory: [],
      selectedInspectIndex: null,
    );
  }

  /// Switch the active card deck style
  void setDeckTheme(TarotDeckTheme theme) {
    _sensory.cardSelectionHaptic();
    state = state.copyWith(deckTheme: theme);
  }

  /// Switch the active altar background theme
  void setAltarTheme(AltarTheme theme) {
    _sensory.cardSelectionHaptic();
    state = state.copyWith(altarTheme: theme);
  }

  /// Select a card on the table to inspect details
  void selectInspectIndex(int? index) {
    _sensory.cardSelectionHaptic();
    state = state.copyWith(selectedInspectIndex: index);
  }

  /// Sets the synastry partner profile for relationship spreads
  void setSynastryPartner(SynastryPartner partner) {
    _sensory.cardSelectionHaptic();
    state = state.copyWith(synastryPartner: partner);
  }

  /// Updates the user's question / query for the oracle
  void setQuestion(String query) {
    state = state.copyWith(question: query);
  }

  /// Begins the reading sequence:
  /// 1. Shuffle deck with Fisher-Yates and tactile haptic vibration
  /// 2. Deal spread cards face-down
  Future<void> startReading() async {
    if (state.isShuffling || state.isDealing) return;

    state = state.copyWith(
      isShuffling: true,
      currentReading: null,
      errorMessage: null,
      drawnCards: [],
      revealedIndices: {},
      conversationHistory: [],
      selectedInspectIndex: null,
    );

    // Haptic tremors during shuffle
    _sensory.shuffleHaptic();
    await Future.delayed(const Duration(milliseconds: 350));
    _sensory.shuffleHaptic();
    await Future.delayed(const Duration(milliseconds: 350));
    _sensory.shuffleHaptic();
    await Future.delayed(const Duration(milliseconds: 400));

    // Draw cards for selected spread
    final cards = _deckService.drawSpread(spreadType: state.spreadType);

    state = state.copyWith(
      isShuffling: false,
      isDealing: true,
      drawnCards: cards,
    );

    _sensory.playCardFlipSound();
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isDealing: false);
  }

  /// Sets manually selected cards from the "Cut the Deck" sacred ritual
  Future<void> setManualDrawnCards(List<TarotCard> selectedCards) async {
    final positionedCards = <TarotCard>[];
    for (int i = 0; i < selectedCards.length; i++) {
      final pos = i < state.spreadType.positionTitles.length
          ? state.spreadType.positionTitles[i]
          : 'Card ${i + 1}';
      positionedCards.add(selectedCards[i].copyWith(positionName: pos));
    }

    state = state.copyWith(
      drawnCards: positionedCards,
      revealedIndices: {},
      selectedInspectIndex: null,
      currentReading: null,
      isDealing: true,
    );

    _sensory.playCardFlipSound();
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isDealing: false);
  }

  /// Flips a specific card at index face-up
  Future<void> flipCard(int index) async {
    if (index < 0 || index >= state.drawnCards.length) return;
    if (state.revealedIndices.contains(index)) return;

    _sensory.cardFlipHaptic();
    _sensory.playCardFlipSound();

    final updatedIndices = Set<int>.from(state.revealedIndices)..add(index);
    state = state.copyWith(
      revealedIndices: updatedIndices,
      selectedInspectIndex: index,
    );

    // If all cards in the spread are now revealed, consult the Oracle!
    if (updatedIndices.length == state.drawnCards.length) {
      _sensory.playRevelationSound();
      _sensory.completionHaptic();
      await consultOracle();
    }
  }

  /// Reveals all face-down cards simultaneously and calls oracle
  Future<void> revealAllCards() async {
    if (state.drawnCards.isEmpty) return;

    _sensory.completionHaptic();
    _sensory.playRevelationSound();

    final allIndices =
        List.generate(state.drawnCards.length, (i) => i).toSet();
    state = state.copyWith(revealedIndices: allIndices);

    await consultOracle();
  }

  /// Calls the Supabase Edge Function to get Vertex AI / Gemini interpretation,
  /// harmonized with seeker astrological placements.
  Future<void> consultOracle() async {
    if (state.isConsultingOracle || state.drawnCards.isEmpty) return;

    state = state.copyWith(isConsultingOracle: true, errorMessage: null);

    // Grab seeker astrological placements from AuthNotifier
    final profile = ref.read(authNotifierProvider).profile;
    final partner = state.synastryPartner;
    final astrologyInfo = <String, String>{
      'sun': profile?.zodiacSign ?? 'Scorpio',
      if (profile?.moonSign != null) 'moon': profile!.moonSign!,
      if (profile?.risingSign != null) 'rising': profile!.risingSign!,
      if (partner != null) ...{
        'partner_name': partner.name,
        'partner_sun': partner.sunSign,
        'connection_type': partner.connectionType,
      },
    };

    try {
      final oracleData = await _repository.consultOracle(
        question: state.question,
        spreadType: state.spreadType,
        drawnCards: state.drawnCards,
        astrologyInfo: astrologyInfo,
      );

      final interpretation = oracleData['interpretation'] as String? ??
          'The cosmos whispers in silence.';
      final summary = oracleData['summary'] as String?;
      final advice = oracleData['advice'] as String?;

      final savedReading = await _repository.saveReading(
        question: state.question,
        spreadType: state.spreadType,
        drawnCards: state.drawnCards,
        interpretation: interpretation,
        summary: summary,
        advice: advice,
      );

      final updatedHistory = List<Reading>.of(state.history)
        ..insert(0, savedReading);

      state = state.copyWith(
        isConsultingOracle: false,
        currentReading: savedReading,
        history: updatedHistory,
      );

      await StreakService.recordReadingToday();
      ref.invalidate(streakProvider);

      // Synchronize newly drawn card to Android home screen widget
      if (state.drawnCards.isNotEmpty) {
        final primaryCard = state.drawnCards.first;
        ref.read(tarotWidgetServiceProvider).updateHomeScreenWidget(
          card: primaryCard,
          isReversed: primaryCard.isReversed,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isConsultingOracle: false,
        errorMessage: 'The celestial connection was interrupted: $e',
      );
    }
  }

  /// Submits a conversational follow-up question regarding the active reading
  Future<void> askOracleFollowUp(String prompt) async {
    if (prompt.trim().isEmpty || state.currentReading == null) return;
    if (state.isAskingFollowUp) return;

    final userMsg = OracleMessage(
      role: 'user',
      content: prompt.trim(),
      timestamp: DateTime.now(),
    );

    final updatedHistory = List<OracleMessage>.from(state.conversationHistory)
      ..add(userMsg);

    state = state.copyWith(
      isAskingFollowUp: true,
      conversationHistory: updatedHistory,
    );

    try {
      final answer = await _repository.askOracleFollowUp(
        reading: state.currentReading!,
        userQuestion: prompt.trim(),
        conversationHistory: updatedHistory,
      );

      final modelMsg = OracleMessage(
        role: 'model',
        content: answer,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        isAskingFollowUp: false,
        conversationHistory: List<OracleMessage>.from(updatedHistory)
          ..add(modelMsg),
      );
    } catch (e) {
      state = state.copyWith(
        isAskingFollowUp: false,
        errorMessage: 'Follow-up interrupted: $e',
      );
    }
  }

  /// Appends personal notes to a reading
  Future<void> updateReadingNotes(String readingId, String notes) async {
    await _repository.updateReadingNotes(readingId, notes);
    final updatedList = state.history.map((r) {
      if (r.id == readingId) return r.copyWith(notes: notes);
      return r;
    }).toList();

    state = state.copyWith(
      history: updatedList,
      currentReading: state.currentReading?.id == readingId
          ? state.currentReading?.copyWith(notes: notes)
          : state.currentReading,
    );
  }

  /// Toggles favorite status for a reading
  Future<void> toggleFavorite(String readingId, bool isFavorite) async {
    _sensory.cardSelectionHaptic();
    await _repository.toggleFavorite(readingId, isFavorite);
    final updatedList = state.history.map((r) {
      if (r.id == readingId) return r.copyWith(isFavorite: isFavorite);
      return r;
    }).toList();

    state = state.copyWith(
      history: updatedList,
      currentReading: state.currentReading?.id == readingId
          ? state.currentReading?.copyWith(isFavorite: isFavorite)
          : state.currentReading,
    );
  }

  /// Resets the table for a brand new reading
  void resetTable() {
    _sensory.cardSelectionHaptic();
    state = state.copyWith(
      drawnCards: [],
      revealedIndices: {},
      currentReading: null,
      errorMessage: null,
      conversationHistory: [],
      selectedInspectIndex: null,
    );
  }

  /// Fetches saved readings from Supabase
  Future<void> loadHistory() async {
    try {
      final pastReadings = await _repository.getReadingHistory();
      state = state.copyWith(history: pastReadings);
    } catch (_) {}
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Backward/convenience alias for readingProvider
final readingNotifierProvider = readingProvider;
