import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tarot_app/core/services/storage_service.dart';
import 'package:tarot_app/core/supabase/supabase_config.dart';
import 'package:uuid/uuid.dart';
import '../domain/oracle_message.dart';
import '../domain/reading.dart';
import '../domain/spread_type.dart';
import '../domain/tarot_card.dart';

class TarotRepository {
  final SupabaseClient? _supabase;
  final StorageService _storage;
  final _uuid = const Uuid();

  // Local fallback cache for offline or unconfigured environments
  static final List<Reading> _localReadings = [];

  TarotRepository([this._supabase, StorageService? storage])
      : _storage = storage ?? StorageService();

  /// Invokes the 'tarot-reader' Supabase Edge Function to get Vertex AI / Gemini interpretation.
  Future<Map<String, dynamic>> consultOracle({
    required String question,
    required SpreadType spreadType,
    required List<TarotCard> drawnCards,
    Map<String, String>? astrologyInfo,
  }) async {
    final payload = {
      'user_question':
          question.trim().isEmpty ? 'Daily Cosmic Guidance' : question.trim(),
      'spread_type': spreadType.title,
      'seeker_astrology': astrologyInfo,
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
    );
  }

  /// Follow-up conversational inquiry to the AI Oracle regarding an existing reading
  Future<String> askOracleFollowUp({
    required Reading reading,
    required String userQuestion,
    required List<OracleMessage> conversationHistory,
  }) async {
    final payload = {
      'follow_up_prompt': userQuestion,
      'user_question': reading.question,
      'spread_type': reading.spreadType,
      'drawn_cards': reading.cards.map((c) => c.name).toList(),
      'chat_history': conversationHistory
          .map((m) => {'role': m.role, 'content': m.content})
          .toList(),
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

  /// Local astrological and archetypal synthesis
  Map<String, dynamic> _generateLocalOracleInterpretation({
    required String question,
    required SpreadType spreadType,
    required List<TarotCard> cards,
    Map<String, String>? astrologyInfo,
  }) {
    final primaryCard = cards.first;
    final primaryMeaning = primaryCard.isReversed
        ? primaryCard.meaningReversed
        : primaryCard.meaningUpright;

    String summary;
    String narrative;
    String advice;

    final sunSign = astrologyInfo?['sun'] ?? 'Cosmic Seeker';

    if (cards.length == 1) {
      summary =
          '${primaryCard.name} (${primaryCard.isReversed ? "Reversed" : "Upright"}) signals an essential inflection point.';
      narrative =
          'Regarding your inquiry—"${question.trim().isEmpty ? "Daily Cosmic Guidance" : question}"—and aligning with your $sunSign essence, ${primaryCard.name} illuminates a powerful cosmic mirror. $primaryMeaning '
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
          'Your inquiry—"${question.trim().isEmpty ? "The Three Fates" : question}"—unfolds across time:\n\n'
          '• Roots (${past.positionName ?? "Past"}): ${past.name} (${past.isReversed ? "Reversed" : "Upright"}). ${past.isReversed ? past.meaningReversed : past.meaningUpright}\n\n'
          '• Current Energy (${present.positionName ?? "Present"}): ${present.name} (${present.isReversed ? "Reversed" : "Upright"}). ${present.isReversed ? present.meaningReversed : present.meaningUpright}\n\n'
          '• Unfolding Trajectory (${future.positionName ?? "Future"}): ${future.name} (${future.isReversed ? "Reversed" : "Upright"}). ${future.isReversed ? future.meaningReversed : future.meaningUpright}\n\n'
          'The alchemy between these three forces shows a clear movement from releasing past conditioning into reclaiming authentic mastery.';
      advice =
          'Integrate the lesson of ${past.name} so you do not repeat old loops. Meet the challenge of ${present.name} with clarity, and keep your vision anchored in ${future.name}.';
    } else {
      // 10-Card Celtic Cross synthesis
      summary =
          'The Celtic Cross reveals a sacred matrix of transformation: present tensions are catalysts for profound spiritual sovereignty.';
      narrative =
          'The 10-card Celtic Cross reveals the complete sphere of your life path regarding "${question.trim().isEmpty ? "Life Destiny" : question}".\n\n'
          'At the heart of the matter lies ${cards[0].name}, while the immediate crossing challenge is mirrored by ${cards[1].name}. Your subconscious foundation rests upon ${cards[2].name}, as past lessons of ${cards[3].name} fade into the background.\n\n'
          'Above you, the crown potential is anchored in ${cards[4].name}, with the near future illuminated by ${cards[5].name}. Your inner self embodies the truth of ${cards[6].name}, responding to external forces of ${cards[7].name}. Between the secret hopes of ${cards[8].name} and the ultimate culmination of ${cards[9].name}, you are being guided into unwavering alignment with your higher calling.';
      advice =
          'Embrace the crucible of ${cards[1].name} without resistance. The final outcome in ${cards[9].name} promises profound awakening when you step forward with integrity.';
    }

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
    };
  }
}
