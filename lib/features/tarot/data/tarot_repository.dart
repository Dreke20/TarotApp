import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tarot_app/core/services/storage_service.dart';
import 'package:tarot_app/core/services/prompt_sanitizer_service.dart';
import 'package:tarot_app/core/supabase/supabase_config.dart';
import 'package:tarot_app/core/utils/lunar_calculator.dart';
import 'package:tarot_app/features/astrology/data/ephemeris_calculator.dart';
import 'package:uuid/uuid.dart';
import '../domain/oracle_message.dart';
import '../domain/oracle_persona.dart';
import '../domain/reading.dart';
import '../domain/spread_type.dart';
import '../domain/tarot_card.dart';

final tarotRepositoryProvider = Provider<TarotRepository>((ref) {
  try {
    return TarotRepository(Supabase.instance.client);
  } catch (_) {
    return TarotRepository();
  }
});

class TarotRepository {
  final SupabaseClient? _supabase;
  final StorageService _storage;
  final _uuid = const Uuid();

  // Local fallback cache for offline or unconfigured environments
  static final List<Reading> _localReadings = [];

  TarotRepository([this._supabase, StorageService? storage])
      : _storage = storage ?? StorageService();

  /// Calculates elemental percentages and chemical tension/synergy between drawn cards
  static String calculateElementalChemistry(List<TarotCard> cards) {
    if (cards.isEmpty) return 'Ether: Pure potentiality awaiting activation.';
    int fire = 0, water = 0, air = 0, earth = 0;
    for (final c in cards) {
      final name = c.name.toLowerCase();
      final suit = c.suit?.toLowerCase() ?? '';
      if (suit == 'wands' || name.contains('wands')) {
        fire++;
      } else if (suit == 'cups' || name.contains('cups')) {
        water++;
      } else if (suit == 'swords' || name.contains('swords')) {
        air++;
      } else if (suit == 'pentacles' || name.contains('pentacles')) {
        earth++;
      } else {
        // Major Arcana elemental alignments
        if (name.contains('fool') || name.contains('magician') || name.contains('lovers') || name.contains('justice') || name.contains('star')) {
          air++;
        } else if (name.contains('priestess') || name.contains('chariot') || name.contains('hanged') || name.contains('death') || name.contains('moon')) {
          water++;
        } else if (name.contains('emperor') || name.contains('strength') || name.contains('wheel') || name.contains('temperance') || name.contains('tower') || name.contains('sun') || name.contains('judgement')) {
          fire++;
        } else {
          earth++;
        }
      }
    }
    final total = cards.length;
    final fPct = ((fire / total) * 100).round();
    final wPct = ((water / total) * 100).round();
    final aPct = ((air / total) * 100).round();
    final ePct = ((earth / total) * 100).round();

    String interaction;
    if (fire > 0 && water > 0 && fire >= water) {
      interaction = 'Fire & Water: Volatile steam where deep emotions challenge courageous will';
    } else if (water > 0 && earth > 0) {
      interaction = 'Water & Earth: Fertile ground nurturing intuitive guidance into lasting form';
    } else if (fire > 0 && air > 0) {
      interaction = 'Fire & Air: Swift conflagration accelerating ideas into decisive spiritual momentum';
    } else if (air > 0 && earth > 0) {
      interaction = 'Air & Earth: Strategic grounding aligning visionary ideals with tangible reality';
    } else if (water > 0) {
      interaction = 'Dominant Water: Deep subconscious currents urging emotional healing and surrender';
    } else if (fire > 0) {
      interaction = 'Dominant Fire: Radiant solar willpower commanding courage and creative sovereignty';
    } else if (air > 0) {
      interaction = 'Dominant Air: Lucid intellect illuminating truth and piercing comfortable illusions';
    } else {
      interaction = 'Dominant Earth: Sacred temple stability anchoring long-term foundations';
    }

    return '$interaction (Fire: $fPct%, Water: $wPct%, Air: $aPct%, Earth: $ePct%)';
  }

  /// Instance forwarder for elemental chemistry calculation
  String getElementalChemistry(List<TarotCard> cards) => calculateElementalChemistry(cards);

  /// Invokes the 'tarot-reader' Supabase Edge Function to get Vertex AI / Gemini interpretation,
  /// enriched with persona voice, sacred journey recall, elemental chemistry, and cosmic weather.
  Future<Map<String, dynamic>> consultOracle({
    required String question,
    required SpreadType spreadType,
    required List<TarotCard> drawnCards,
    Map<String, String>? astrologyInfo,
    OraclePersona persona = OraclePersona.highPriestess,
    String? dreamNarrative,
    String? altarConsecration,
  }) async {
    final cleanQuestion = PromptSanitizerService.sanitizeQuestion(
      question.trim().isEmpty ? 'Daily Cosmic Guidance' : question.trim(),
    );

    // 1. Live Cosmic Weather from astronomical engine
    final now = DateTime.now();
    final lunar = LunarCalculator.getTodayLunarInfo(now);
    final sunSignNow = EphemerisCalculator.getZodiacSignFromDate(now);
    final chartNow = EphemerisCalculator.calculateChart(sunSign: sunSignNow);
    final cosmicWeather = <String, String>{
      'moon_phase': lunar.phase.title,
      'moon_illumination': '${lunar.illuminationPercent.toStringAsFixed(0)}%',
      'moon_zodiac': lunar.moonZodiac,
      'planetary_transits': chartNow.placements.take(4).map((p) => '${p.planet}: ${p.sign}').join(', '),
    };

    // 2. Elemental Chemistry & Card Synergy
    final elementalChemistry = calculateElementalChemistry(drawnCards);

    // 3. Sacred Journey Recall: Extract recent themes & recurring cards
    final recentHistory = await getReadingHistory();
    final recentThemes = recentHistory
        .take(4)
        .map((r) => '"${r.question}" (${r.cards.take(2).map((c) => c.name).join(", ")})')
        .toList();

    final cardCounts = <String, int>{};
    for (final r in recentHistory.take(7)) {
      for (final c in r.cards) {
        cardCounts[c.name] = (cardCounts[c.name] ?? 0) + 1;
      }
    }
    final recurringCards = cardCounts.entries
        .where((e) => e.value >= 2)
        .map((e) => '${e.key} (seen ${e.value}x)')
        .toList();

    final payload = {
      'user_question': cleanQuestion,
      'spread_type': spreadType.title,
      'seeker_astrology': astrologyInfo,
      'oracle_persona': persona.id,
      'oracle_persona_title': persona.title,
      'cosmic_weather': cosmicWeather,
      'elemental_chemistry': elementalChemistry,
      'recent_journey_context': recentThemes,
      'recurring_cards': recurringCards,
      'dream_narrative': ?dreamNarrative,
      'altar_consecration': ?altarConsecration,
      'drawn_cards': drawnCards
          .map((card) => {
                'id': card.id,
                'name': card.name,
                'arcana': card.arcana,
                'is_reversed': card.isReversed,
                'position_name': card.positionName,
                'meaning_upright': card.meaningUpright,
                'meaning_reversed': card.meaningReversed,
              })
          .toList(),
    };

    if (_supabase != null && SupabaseConfig.isConfigured) {
      try {
        final FunctionResponse response = await _supabase.functions.invoke(
          'tarot-reader',
          body: payload,
        );

        if (response.status == 200 && response.data != null) {
          if (response.data is Map<String, dynamic>) {
            return response.data as Map<String, dynamic>;
          } else if (response.data is String) {
            return jsonDecode(response.data as String) as Map<String, dynamic>;
          }
        }
      } catch (e) {
        debugPrint(
            'Edge function invocation error, falling back to local oracle engine: $e');
      }
    }

    // Local mystical synthesis engine (for offline/demo/testing resilience)
    return _generateLocalOracleInterpretation(
      question: question,
      spreadType: spreadType,
      cards: drawnCards,
      astrologyInfo: astrologyInfo,
      persona: persona,
      cosmicWeather: cosmicWeather,
      elementalChemistry: elementalChemistry,
      recurringCards: recurringCards,
      dreamNarrative: dreamNarrative,
      altarConsecration: altarConsecration,
    );
  }

  /// Follow-up conversational inquiry to the AI Oracle regarding an existing reading
  Future<String> askOracleFollowUp({
    required Reading reading,
    required String userQuestion,
    required List<OracleMessage> conversationHistory,
  }) async {
    final cleanFollowUp = PromptSanitizerService.sanitizeFollowUp(userQuestion);

    final payload = {
      'follow_up_prompt': cleanFollowUp,
      'user_question': reading.question,
      'spread_type': reading.spreadType,
      'drawn_cards': reading.cards.map((c) => c.name).toList(),
      'chat_history': conversationHistory
          .map((m) => {'role': m.role, 'content': m.content})
          .toList(),
      'oracle_persona': reading.personaId,
    };

    if (_supabase != null && SupabaseConfig.isConfigured) {
      try {
        final FunctionResponse response = await _supabase.functions.invoke(
          'tarot-reader',
          body: payload,
        );

        if (response.status == 200 && response.data != null) {
          final data = response.data is String
              ? jsonDecode(response.data as String)
              : response.data;
          return data['answer'] as String? ??
              'The cosmos nods in solemn understanding.';
        }
      } catch (e) {
        debugPrint('Follow-up error: $e');
      }
    }

    return 'Regarding "$userQuestion", the archetype of ${reading.cards.first.name} suggests looking inward at your unspoken expectations. Trust the stillness before you speak.';
  }

  /// Saves a completed reading to the Supabase 'readings' table and local cache.
  Future<Reading> saveReading({
    required String question,
    required SpreadType spreadType,
    required List<TarotCard> drawnCards,
    required String interpretation,
    String? summary,
    String? advice,
    String? journeyRecall,
    String? elementalChemistry,
    String? cosmicWeather,
    List<String> scryingPrompts = const [],
    String? personaId,
    String? altarConsecration,
    String? userId,
  }) async {
    final newId = _uuid.v4();
    final now = DateTime.now().toUtc();

    final reading = Reading(
      id: newId,
      userId: userId ?? _supabase?.auth.currentUser?.id,
      question:
          question.trim().isEmpty ? 'Daily Cosmic Guidance' : question.trim(),
      spreadType: spreadType.id,
      cards: drawnCards,
      interpretation: interpretation,
      summary: summary,
      advice: advice,
      journeyRecall: journeyRecall,
      elementalChemistry: elementalChemistry,
      cosmicWeather: cosmicWeather,
      scryingPrompts: scryingPrompts,
      personaId: personaId,
      altarConsecration: altarConsecration,
      createdAt: now,
    );

    // Save to local memory and persistent storage mirror
    _localReadings.insert(0, reading);
    await _storage.saveReadings(_localReadings);

    // Guest readings stay on-device; only signed-in seekers sync to the cloud.
    if (_supabase != null &&
        SupabaseConfig.isConfigured &&
        reading.userId != null) {
      try {
        await _supabase.from('readings').insert({
          'id': reading.id,
          'user_id': reading.userId,
          'question': reading.question,
          'spread_type': reading.spreadType,
          'cards': reading.cards.map((c) => c.toJson()).toList(),
          'interpretation': reading.interpretation,
          'summary': reading.summary,
          'advice': reading.advice,
          'notes': reading.notes,
          'is_favorite': reading.isFavorite,
          'created_at': reading.createdAt.toIso8601String(),
        });
      } catch (e) {
        debugPrint('Supabase insert reading error: $e');
      }
    }

    return reading;
  }

  /// Updates personal reflection notes for a reading
  Future<void> updateReadingNotes(String readingId, String notes) async {
    final index = _localReadings.indexWhere((r) => r.id == readingId);
    if (index != -1) {
      _localReadings[index] = _localReadings[index].copyWith(notes: notes);
      await _storage.saveReadings(_localReadings);
    }

    if (_supabase != null && SupabaseConfig.isConfigured) {
      try {
        await _supabase
            .from('readings')
            .update({'notes': notes}).eq('id', readingId);
      } catch (e) {
        debugPrint('Supabase update notes error: $e');
      }
    }
  }

  /// Toggles favorite status for a reading
  Future<void> toggleFavorite(String readingId, bool isFavorite) async {
    final index = _localReadings.indexWhere((r) => r.id == readingId);
    if (index != -1) {
      _localReadings[index] =
          _localReadings[index].copyWith(isFavorite: isFavorite);
      await _storage.saveReadings(_localReadings);
    }

    if (_supabase != null && SupabaseConfig.isConfigured) {
      try {
        await _supabase
            .from('readings')
            .update({'is_favorite': isFavorite}).eq('id', readingId);
      } catch (e) {
        debugPrint('Supabase toggle favorite error: $e');
      }
    }
  }

  /// Fetches past readings from Supabase or local cache
  Future<List<Reading>> getReadingHistory({String? userId}) async {
    // Restore from persistent storage mirror if in-memory list is empty
    if (_localReadings.isEmpty) {
      final cached = await _storage.loadReadings();
      if (cached.isNotEmpty) {
        _localReadings.addAll(cached);
      }
    }

    final currentUid = userId ?? _supabase?.auth.currentUser?.id;

    // Guests read only from the on-device mirror; RLS restricts cloud rows
    // to their owner, so there is nothing to fetch without a signed-in user.
    if (_supabase != null && SupabaseConfig.isConfigured && currentUid != null) {
      try {
        final List<dynamic> response = await _supabase
            .from('readings')
            .select()
            .eq('user_id', currentUid)
            .order('created_at', ascending: false);

        final remote = response
            .map((data) => Reading.fromJson(data as Map<String, dynamic>))
            .toList();
        if (remote.isNotEmpty) {
          _localReadings.clear();
          _localReadings.addAll(remote);
          await _storage.saveReadings(_localReadings);
        }
        return remote;
      } catch (e) {
        debugPrint('Supabase fetch history error, using local readings: $e');
      }
    }

    return List<Reading>.unmodifiable(_localReadings);
  }

  /// Local astrological, archetypal, and persona synthesis
  Map<String, dynamic> _generateLocalOracleInterpretation({
    required String question,
    required SpreadType spreadType,
    required List<TarotCard> cards,
    Map<String, String>? astrologyInfo,
    OraclePersona persona = OraclePersona.highPriestess,
    Map<String, String>? cosmicWeather,
    String? elementalChemistry,
    List<String>? recurringCards,
    String? dreamNarrative,
    String? altarConsecration,
  }) {
    final primaryCard = cards.first;
    final primaryMeaning = primaryCard.isReversed
        ? primaryCard.meaningReversed
        : primaryCard.meaningUpright;

    String summary;
    String narrative;
    String advice;

    final sunSign = astrologyInfo?['sun'] ?? 'Cosmic Seeker';

    // Persona-tailored voice prefix
    String voicePrefix;
    switch (persona) {
      case OraclePersona.hermit:
        voicePrefix = '✦ THE HERMIT SPEAKS ✦\nIn solemn stillness, timeless wisdom reveals: ';
        break;
      case OraclePersona.empress:
        voicePrefix = '✦ THE EMPRESS GATHERS YOU ✦\nWith radiant compassion, abundance unfolds: ';
        break;
      case OraclePersona.magician:
        voicePrefix = '✦ THE MAGICIAN COMMANDS ✦\nBy your sovereign will, reality transforms: ';
        break;
      case OraclePersona.shadowMirror:
        voicePrefix = '✦ THE SHADOW MIRROR ILLUMINATES ✦\nGazing unflinchingly into your unconscious: ';
        break;
      case OraclePersona.highPriestess:
        voicePrefix = '✦ THE HIGH PRIESTESS CHANNELS ✦\nBeneath the sacred veil of intuition: ';
        break;
    }

    if (cards.length == 1) {
      summary =
          '${primaryCard.name} (${primaryCard.isReversed ? "Reversed" : "Upright"}) signals an essential inflection point.';
      narrative =
          '$voicePrefix\n\nRegarding your inquiry—"${question.trim().isEmpty ? "Daily Cosmic Guidance" : question}"—and aligning with your $sunSign essence, ${primaryCard.name} illuminates a powerful cosmic mirror. $primaryMeaning\n\n'
          'Notice how its ${primaryCard.element ?? "ethereal"} energy asks you to tune into subtle signs rather than pushing forcefully against the tide. '
          'This card does not dictate fate, but invites you into conscious co-creation with the unfolding moment.';
      advice =
          'Pause and reflect on the core archetype of ${primaryCard.name}. Trust your intuitive pulse and act from inner alignment rather than external urgency.';
    } else if (cards.length == 3) {
      final past = cards[0];
      final present = cards[1];
      final future = cards[2];

      summary =
          'A journey through ${past.name}, encountering the tension of ${present.name}, arriving at the transformation of ${future.name}.';
      narrative =
          '$voicePrefix\n\nYour inquiry—"${question.trim().isEmpty ? "The Three Fates" : question}"—unfolds across time:\n\n'
          '• Roots (${past.positionName ?? "Past"}): ${past.name} (${past.isReversed ? "Reversed" : "Upright"}). ${past.isReversed ? past.meaningReversed : past.meaningUpright}\n\n'
          '• Current Energy (${present.positionName ?? "Present"}): ${present.name} (${present.isReversed ? "Reversed" : "Upright"}). ${present.isReversed ? present.meaningReversed : present.meaningUpright}\n\n'
          '• Unfolding Trajectory (${future.positionName ?? "Future"}): ${future.name} (${future.isReversed ? "Reversed" : "Upright"}). ${future.isReversed ? future.meaningReversed : future.meaningUpright}\n\n'
          'The alchemy between these three forces shows a clear movement from releasing past conditioning into reclaiming authentic mastery.';
      advice =
          'Integrate the lesson of ${past.name} so you do not repeat old loops. Meet the challenge of ${present.name} with clarity, and keep your vision anchored in ${future.name}.';
    } else if (spreadType == SpreadType.heartOfTwo && cards.length >= 5) {
      final seekerCard = cards[0];
      final partnerCard = cards[1];
      final nexusCard = cards[2];
      final lessonCard = cards[3];
      final horizonCard = cards[4];
      final partnerName = astrologyInfo?['partner_name'] ?? 'Your Counterpart';
      final partnerSun = astrologyInfo?['partner_sun'] ?? 'Cosmic Counterpart';
      final connectionType = astrologyInfo?['connection_type'] ?? 'Soulmate Bond';

      summary =
          'Cosmic Synastry Mirror ($connectionType): $sunSign and $partnerSun unite through the alchemy of ${nexusCard.name}, culminating in ${horizonCard.name}.';
      narrative =
          '$voicePrefix\n\n✦ COSMIC SYNASTRY & RELATIONSHIP MIRROR ✦\n\n'
          'Seeking guidance for the sacred connection between you ($sunSign) and $partnerName ($partnerSun) anchored in a $connectionType:\n\n'
          '• Your Emotional Core (I): ${seekerCard.name} (${seekerCard.isReversed ? "Reversed" : "Upright"})\n'
          '${seekerCard.isReversed ? seekerCard.meaningReversed : seekerCard.meaningUpright}\n\n'
          '• Their Energetic Presence (II): ${partnerCard.name} (${partnerCard.isReversed ? "Reversed" : "Upright"})\n'
          '${partnerCard.isReversed ? partnerCard.meaningReversed : partnerCard.meaningUpright}\n\n'
          '• The Relational Nexus (III): ${nexusCard.name} (${nexusCard.isReversed ? "Reversed" : "Upright"})\n'
          'The magnetic center pulling both souls together: ${nexusCard.isReversed ? nexusCard.meaningReversed : nexusCard.meaningUpright}\n\n'
          '• Sacred Lesson & Growth Crucible (IV): ${lessonCard.name} (${lessonCard.isReversed ? "Reversed" : "Upright"})\n'
          'Where ego surrenders to spiritual evolution: ${lessonCard.isReversed ? lessonCard.meaningReversed : lessonCard.meaningUpright}\n\n'
          '• Highest Harmonious Horizon (V): ${horizonCard.name} (${horizonCard.isReversed ? "Reversed" : "Upright"})\n'
          'The destiny and ultimate potential of this sacred alliance: ${horizonCard.isReversed ? horizonCard.meaningReversed : horizonCard.meaningUpright}';
      advice =
          'Honor $partnerName\'s journey through the lens of ${partnerCard.name}. Transcend the crucible of ${lessonCard.name} through vulnerability, and step fearlessly into ${horizonCard.name}.';
    } else {
      // 10-Card Celtic Cross synthesis
      summary =
          'The Celtic Cross reveals a sacred matrix of transformation: present tensions are catalysts for profound spiritual sovereignty.';
      narrative =
          '$voicePrefix\n\nThe 10-card Celtic Cross reveals the complete sphere of your life path regarding "${question.trim().isEmpty ? "Life Destiny" : question}".\n\n'
          'At the heart of the matter lies ${cards[0].name}, while the immediate crossing challenge is mirrored by ${cards[1].name}. Your subconscious foundation rests upon ${cards[2].name}, as past lessons of ${cards[3].name} fade into the background.\n\n'
          'Above you, the crown potential is anchored in ${cards[4].name}, with the near future illuminated by ${cards[5].name}. Your inner self embodies the truth of ${cards[6].name}, responding to external forces of ${cards[7].name}. Between the secret hopes of ${cards[8].name} and the ultimate culmination of ${cards[9].name}, you are being guided into unwavering alignment with your higher calling.';
      advice =
          'Embrace the crucible of ${cards[1].name} without resistance. The final outcome in ${cards[9].name} promises profound awakening when you step forward with integrity.';
    }

    final journeyRecall = (recurringCards != null && recurringCards.isNotEmpty)
        ? 'The recurring presence of ${recurringCards.first} highlights an ongoing threshold calling for conscious integration.'
        : 'Your journey unfolds across consistent milestones; the cards honor your growing inner sight.';

    final weatherText = cosmicWeather != null
        ? 'Channeling under the ${cosmicWeather['moon_phase'] ?? "Moon"} in ${cosmicWeather['moon_zodiac'] ?? "Cosmos"} (${cosmicWeather['moon_illumination'] ?? "illuminated"}).'
        : 'The heavens align to magnify this sacred divination.';

    final scryingPrompts = [
      'How can I best embody the wisdom of ${primaryCard.name} in daily life?',
      if (cards.length > 1)
        'What shadow or blind spot does ${cards[1].name} ask me to illuminate?'
      else
        'What obstacle must I release to welcome this energy?',
      'What grounding ritual should I consecrate before the next moon phase?',
    ];

    return {
      'summary': summary,
      'interpretation': narrative,
      'card_insights': cards
          .map((c) => {
                'card_name': c.name,
                'position': c.positionName ?? 'Guidance',
                'insight': c.isReversed ? c.meaningReversed : c.meaningUpright,
              })
          .toList(),
      'advice': advice,
      'astrological_note': 'Harmonized with your $sunSign celestial alignment.',
      'journey_recall': journeyRecall,
      'elemental_chemistry': elementalChemistry ?? calculateElementalChemistry(cards),
      'cosmic_weather': weatherText,
      'scrying_prompts': scryingPrompts,
      'altar_consecration': ?altarConsecration,
    };
  }

  /// AI Dream-to-Tarot Altar Scrying:
  /// Analyzes a dream description using Jungian archetypal psychology and
  /// crafts a dedicated 3-card spread for altar consecration.
  Map<String, dynamic> scryDreamVision({
    required String dreamTitle,
    required String dreamDescription,
    Map<String, String>? astrologyInfo,
  }) {
    final lower = dreamDescription.toLowerCase();
    final archetypes = <String>[];
    if (lower.contains('water') || lower.contains('ocean') || lower.contains('drown') || lower.contains('rain')) {
      archetypes.add('The Emotional Abyss (Water Archetype)');
    }
    if (lower.contains('fall') || lower.contains('chase') || lower.contains('dark') || lower.contains('monster')) {
      archetypes.add('The Unintegrated Shadow');
    }
    if (lower.contains('fly') || lower.contains('sky') || lower.contains('bird') || lower.contains('light')) {
      archetypes.add('The Transcendent Self (Air / Spirit)');
    }
    if (lower.contains('door') || lower.contains('key') || lower.contains('room') || lower.contains('house')) {
      archetypes.add('The Sacred Threshold / Psyche Architecture');
    }
    if (archetypes.isEmpty) {
      archetypes.add('The Primordial Unconscious');
    }

    final sun = astrologyInfo?['sun'] ?? 'Cosmic Dreamer';

    final analysis =
        '✦ JUNGIAN DREAM VISION ANALYSIS ✦\n\n'
        'Your vision—"$dreamTitle"—stirs deep symbolic currents aligned with your $sun soul blueprint. '
        'In depth psychology, dreams do not deceive; they present the unvarnished psychic landscape that the waking ego strives to ignore. '
        'The prominent symbols manifest as ${archetypes.join(" & ")}, indicating that your subconscious mind is actively working to transmute an old psychic loop.\n\n'
        'By consecrating this dream upon the altar, you transmute ephemeral nocturnal visions into actionable spiritual sovereignty.';

    return {
      'title': dreamTitle,
      'archetypes': archetypes,
      'analysis': analysis,
      'spread_positions': [
        'The Subconscious Current (What stirs beneath the waking mind)',
        'The Shadow Threshold (What the ego fears or resists)',
        'The Golden Key (The waking integration truth)',
      ],
      'consecration_question': 'What does my dream of "$dreamTitle" demand that I awaken to?',
    };
  }

  /// The Seeker\'s Chronicle:
  /// Compiles all readings over the past 7 or 30 days and synthesizes an overarching
  /// chapter prophecy highlighting dominant elements, recurring archetypes, and upcoming trajectories.
  Map<String, dynamic> synthesizeChronicle({
    required int days,
    required List<Reading> readings,
    String? seekerSun,
  }) {
    if (readings.isEmpty) {
      return {
        'title': 'The Blank Grimoire',
        'chapter': 'No divination ceremonies recorded in this cycle yet. Consecrate your altar to begin your chronicle.',
        'dominant_element': 'Ether (100%)',
        'total_cards': 0,
        'breakthrough_insight': 'Every master begins with a clean slate.',
        'trajectory': 'Draw your first daily card to initiate the record.',
      };
    }

    final allCards = readings.expand((r) => r.cards).toList();
    final chemistry = calculateElementalChemistry(allCards);

    final cardCounts = <String, int>{};
    for (final c in allCards) {
      cardCounts[c.name] = (cardCounts[c.name] ?? 0) + 1;
    }
    final sortedCards = cardCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final mostFrequentCard = sortedCards.isNotEmpty ? sortedCards.first.key : 'The Fool';

    final periodName = days <= 7 ? '7-Day Lunar Crucible' : '30-Day Solstice Chronicle';

    final chapterText =
        '✦ $periodName ✦\n\n'
        'Across $days days, you approached the sacred altar ${readings.length} times, unveiling ${allCards.length} tarot archetypes. '
        'Your spiritual resonance was heavily anchored in the energy of $mostFrequentCard, which surfaced ${sortedCards.isNotEmpty ? sortedCards.first.value : 1} times to guide your conscious awareness.\n\n'
        '• Elemental Matrix: $chemistry\n\n'
        '• Spiritual Crucible & Transmutation: In this cycle, the tension between your analytical mind and your intuitive knowing reached a pivotal threshold. The recurring appearance of $mostFrequentCard proves that the universe does not repeat itself to bore you, but because the lesson was too magnificent to absorb in a single sitting.\n\n'
        '• The Horizon Opening: As this cycle concludes, the energetic foundation is set. Trust what has been stripped away; the space created is the crucible of your impending expansion.';

    return {
      'title': '$periodName: The Way of $mostFrequentCard',
      'chapter': chapterText,
      'dominant_element': chemistry,
      'total_cards': allCards.length,
      'total_readings': readings.length,
      'guiding_archetype': mostFrequentCard,
      'breakthrough_insight': 'What felt like delay was divine calibration. Honor the wisdom of $mostFrequentCard.',
      'trajectory': 'The next moon cycle invites decisive manifestation anchored in self-trust.',
    };
  }
}
