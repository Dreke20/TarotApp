import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/prompt_sanitizer_service.dart';
import '../../../core/supabase/supabase_config.dart';
import '../../tarot/data/tarot_card_data.dart';
import '../../tarot/domain/oracle_persona.dart';
import '../../tarot/domain/tarot_card.dart';
import '../domain/oracle_dialogue_message.dart';
import '../domain/oracle_dialogue_reply.dart';

/// Orchestrates a single spoken dialogue turn with the Oracle.
///
/// All AI generation is routed through the `tarot-reader` Supabase Edge
/// Function (`dialogue_prompt` mode). A local fallback keeps the experience
/// alive offline or when Supabase is not configured.
class OracleDialogueService {
  OracleDialogueService({SupabaseClient? supabase, Random? random})
      // ignore: prefer_initializing_formals
      : _supabase = supabase,
        _random = random ?? Random();

  final SupabaseClient? _supabase;
  final Random _random;

  static final RegExp _cardIntent = RegExp(
    r'\b(card|draw|pull|deal|spread|tarot|show me|reveal)\b',
    caseSensitive: false,
  );

  /// Whether this turn should draw a fresh card.
  ///
  /// A card is drawn on the seeker's first question and whenever they
  /// explicitly ask for one, so the conversation does not become repetitive.
  bool shouldDrawCard(String prompt, List<OracleDialogueMessage> history) {
    final bool isFirstSeekerTurn =
        !history.any((m) => m.sender == DialogueSender.seeker);
    return isFirstSeekerTurn || _cardIntent.hasMatch(prompt);
  }

  /// Draws a random card (30% reversal chance), avoiding cards already in play.
  TarotCard drawCard({Set<String> excludeIds = const <String>{}}) {
    final List<TarotCard> pool = TarotCardData.allCards
        .where((c) => !excludeIds.contains(c.id))
        .toList();
    final List<TarotCard> source = pool.isEmpty ? TarotCardData.allCards : pool;
    final TarotCard card = source[_random.nextInt(source.length)];
    return card.copyWith(isReversed: _random.nextDouble() < 0.3);
  }

  Future<OracleDialogueReply> consult({
    required String prompt,
    required List<OracleDialogueMessage> history,
    required OraclePersona persona,
  }) async {
    final String clean = PromptSanitizerService.sanitizeFollowUp(prompt);
    final Set<String> usedIds = history
        .map((m) => m.referencedCard?.id)
        .whereType<String>()
        .toSet();
    final TarotCard? card =
        shouldDrawCard(clean, history) ? drawCard(excludeIds: usedIds) : null;

    final Map<String, Object?> payload = <String, Object?>{
      'dialogue_prompt': clean,
      'oracle_persona': persona.id,
      'dialogue_history': history
          .map((m) => <String, String>{
                'role': m.sender == DialogueSender.oracle ? 'model' : 'user',
                'content': m.text,
              })
          .toList(),
      'drawn_cards': card == null
          ? <Map<String, Object?>>[]
          : <Map<String, Object?>>[
              <String, Object?>{
                'id': card.id,
                'name': card.name,
                'arcana': card.arcana,
                'is_reversed': card.isReversed,
                'meaning_upright': card.meaningUpright,
                'meaning_reversed': card.meaningReversed,
              },
            ],
    };

    final SupabaseClient? client = _supabase;
    if (client != null && SupabaseConfig.isConfigured) {
      try {
        final FunctionResponse response =
            await client.functions.invoke('tarot-reader', body: payload);
        if (response.status == 200 && response.data != null) {
          final Object? raw = response.data;
          final Map<String, dynamic> data = raw is String
              ? jsonDecode(raw) as Map<String, dynamic>
              : raw as Map<String, dynamic>;
          final String? answer = data['answer'] as String?;
          if (answer != null && answer.trim().isNotEmpty) {
            return OracleDialogueReply(text: answer.trim(), drawnCard: card);
          }
        }
      } catch (e) {
        debugPrint('Oracle dialogue edge error, using local oracle: $e');
      }
    }

    return OracleDialogueReply(
      text: localReply(clean, card, persona),
      drawnCard: card,
      isOfflineFallback: true,
    );
  }

  /// Offline oracle voice used when the edge function is unreachable.
  @visibleForTesting
  String localReply(String prompt, TarotCard? card, OraclePersona persona) {
    final String opener = switch (persona) {
      OraclePersona.highPriestess => 'Beneath the veil, I hear you.',
      OraclePersona.hermit => 'Let us sit with this in stillness.',
      OraclePersona.empress => 'Come, rest here a moment, dear one.',
      OraclePersona.magician => 'Good. Now we can work with this.',
      OraclePersona.shadowMirror => 'Look closer. Do not flinch.',
    };
    if (card == null) {
      return '$opener What you speak of already carries its own answer, waiting '
          'for you to listen without fear. Which part of this weighs on you most?';
    }
    final String orient = card.isReversed ? 'reversed' : 'upright';
    final String meaning = card.isReversed ? card.meaningReversed : card.meaningUpright;
    final String firstClause = meaning.split(RegExp(r'[,.;]')).first.trim().toLowerCase();
    return '$opener ${card.name} arrives $orient, speaking of $firstClause. '
        'It asks you to notice where this is already moving in your life. '
        'What does this card stir in you?';
  }
}
