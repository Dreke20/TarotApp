import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/features/dream/domain/dream_entry.dart';
import 'package:tarot_app/features/dream/presentation/widgets/dream_oracle_modal.dart';
import 'package:tarot_app/features/tarot/data/tarot_card_data.dart';
import 'package:tarot_app/features/tarot/data/tarot_repository.dart';
import 'package:tarot_app/features/tarot/domain/oracle_persona.dart';
import 'package:tarot_app/features/tarot/domain/reading.dart';
import 'package:tarot_app/features/tarot/domain/spread_type.dart';
import 'package:tarot_app/features/tarot/presentation/screens/seekers_chronicle_screen.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/oracle_persona_selector_modal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('7-Pillar AI Intelligence Suite Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    // 1. Oracle Persona Architecture
    test('OraclePersona has 5 distinct archetypal personas with correct metadata', () {
      expect(OraclePersona.all.length, 5);
      final ids = OraclePersona.all.map((p) => p.id).toSet();
      expect(ids.contains('high_priestess'), isTrue);
      expect(ids.contains('hermit'), isTrue);
      expect(ids.contains('empress'), isTrue);
      expect(ids.contains('magician'), isTrue);
      expect(ids.contains('shadow_mirror'), isTrue);

      final priestess = OraclePersona.all.firstWhere((p) => p.id == 'high_priestess');
      expect(priestess.title, 'THE HIGH PRIESTESS');
      expect(priestess.subtitle, contains('Intuitive'));
      expect(priestess.description, contains('subconscious currents'));
    });

    // 2. Elemental Dignity Matrix & Card Chemistry
    test('calculateElementalChemistry correctly calculates percentages and Major Arcana presence', () {
      final majorCard = TarotCardData.allCards.firstWhere((c) => c.arcana == 'major'); // The Fool
      final cupsCard = TarotCardData.allCards.firstWhere((c) => c.suit == 'cups');
      final wandsCard = TarotCardData.allCards.firstWhere((c) => c.suit == 'wands');

      final chemistry = TarotRepository.calculateElementalChemistry([majorCard, cupsCard, wandsCard]);
      expect(chemistry.contains('Water: 33%'), isTrue);
      expect(chemistry.contains('Fire: 33%'), isTrue);
      expect(chemistry.contains('Air: 33%'), isTrue);
    });

    // 3. AI Dream-to-Tarot Altar Synthesis
    test('scryDreamVision extracts Jungian archetypes and 3-card consecration spread', () {
      final repository = TarotRepository();
      final result = repository.scryDreamVision(
        dreamTitle: 'Drowning in a Sunken Temple',
        dreamDescription: 'I was trapped in deep ocean water and searching for a golden key to open a heavy dark door.',
        astrologyInfo: {'sun': 'Pisces'},
      );

      final archetypes = result['archetypes'] as List<dynamic>;
      expect(archetypes.any((a) => a.toString().contains('Water')), isTrue);
      expect(archetypes.any((a) => a.toString().contains('Sacred Threshold')), isTrue);

      final spreadPositions = result['spread_positions'] as List<dynamic>;
      expect(spreadPositions.length, 3);
      expect(spreadPositions[0], contains('Subconscious Current'));
      expect(spreadPositions[1], contains('Shadow Threshold'));
      expect(spreadPositions[2], contains('Golden Key'));

      expect(result['consecration_question'], contains('Drowning in a Sunken Temple'));
    });

    // 4. The Seeker\'s Chronicle
    test('synthesizeChronicle aggregates readings over 7 and 30 days', () {
      final repository = TarotRepository();

      // Empty cycle
      final emptyResult = repository.synthesizeChronicle(days: 7, readings: []);
      expect(emptyResult['title'], 'The Blank Grimoire');
      expect(emptyResult['total_readings'], isNull);

      // Populated cycle
      final testCard = TarotCardData.allCards.firstWhere((c) => c.name == 'The Magician');
      final List<Reading> readings = [
        Reading(
          id: 'test_1',
          question: 'Guidance 1',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          spreadType: SpreadType.dailyGuidance.id,
          cards: [testCard],
          interpretation: 'Test Interpretation 1',
        ),
        Reading(
          id: 'test_2',
          question: 'Guidance 2',
          createdAt: DateTime.now().subtract(const Duration(days: 4)),
          spreadType: SpreadType.dailyGuidance.id,
          cards: [testCard],
          interpretation: 'Test Interpretation 2',
        ),
      ];

      final chronicle7 = repository.synthesizeChronicle(days: 7, readings: readings);
      expect(chronicle7['title'], contains('7-Day Lunar Crucible'));
      expect(chronicle7['total_readings'], 2);
      expect(chronicle7['total_cards'], 2);
      expect(chronicle7['guiding_archetype'], testCard.name);
      expect(chronicle7['chapter'], contains('The Magician'));

      final chronicle30 = repository.synthesizeChronicle(days: 30, readings: readings);
      expect(chronicle30['title'], contains('30-Day Solstice Chronicle'));
    });

    // 5. Reading Entity AI Serialization
    test('Reading model serializes and deserializes all 7 AI fields without data loss', () {
      final majorCard = TarotCardData.allCards.firstWhere((c) => c.arcana == 'major');
      final reading = Reading(
        id: 'r_ai_test',
        question: 'What is my sacred path?',
        createdAt: DateTime(2026, 10, 16),
        spreadType: SpreadType.threeFates.id,
        cards: [majorCard],
        interpretation: 'A sacred step into the void.',
        summary: 'Awaken the inner seeker.',
        advice: 'Trust the unknown.',
        journeyRecall: 'The recurring presence of The Fool marks a cycle of rebirth.',
        elementalChemistry: 'Major Arcana: 100%',
        cosmicWeather: 'Waning Crescent in Gemini (18% illuminated)',
        scryingPrompts: [
          'What threshold am I being asked to cross?',
          'What fear does The Fool urge me to release?',
        ],
        personaId: 'high_priestess',
        microRitual: 'Close your eyes for 60 seconds and breathe with The Fool.',
      );

      final json = jsonDecode(jsonEncode(reading.toJson())) as Map<String, dynamic>;
      expect(json['journey_recall'], contains('The Fool marks a cycle of rebirth'));
      expect(json['cosmic_weather'], contains('Gemini'));
      expect(json['persona_id'], 'high_priestess');
      expect(json['micro_ritual'], contains('Close your eyes for 60 seconds'));
      expect(json['scrying_prompts'], hasLength(2));

      final reconstructed = Reading.fromJson(json);
      expect(reconstructed.journeyRecall, reading.journeyRecall);
      expect(reconstructed.elementalChemistry, 'Major Arcana: 100%');
      expect(reconstructed.cosmicWeather, reading.cosmicWeather);
      expect(reconstructed.scryingPrompts, reading.scryingPrompts);
      expect(reconstructed.personaId, 'high_priestess');
      expect(reconstructed.microRitual, reading.microRitual);
    });

    // 6. consultOracle local fallback generates all enriched AI fields including micro_ritual
    test('consultOracle produces journey_recall, elemental_chemistry, cosmic_weather, micro_ritual, and scrying_prompts', () async {
      final repository = TarotRepository();
      final card = TarotCardData.allCards.firstWhere((c) => c.arcana == 'major');

      final result = await repository.consultOracle(
        drawnCards: [card],
        spreadType: SpreadType.dailyGuidance,
        question: 'What is my highest path?',
        astrologyInfo: {'sun': 'Scorpio'},
        persona: OraclePersona.hermit,
      );

      expect(result['journey_recall'], isNotNull);
      expect(result['elemental_chemistry'], isNotNull);
      expect(result['cosmic_weather'], isNotNull);
      expect(result['micro_ritual'], isNotNull);
      expect(result['micro_ritual'].toString(), contains('60 seconds'));
      final prompts = result['scrying_prompts'] as List<dynamic>?;
      expect(prompts, isNotNull);
      expect(prompts!.length, 3);
      expect(result['interpretation'].toString().toUpperCase(), contains('THE HERMIT'));
    });

    // 7. Master Hermeneutics: Optical Gaze & Karmic Crossroads
    test('consultOracle calculates Karmic Soul Crossroads and Optical Gaze tension when multiple cards appear', () async {
      final repository = TarotRepository();
      final majorA = TarotCardData.allCards.firstWhere((c) => c.name == 'The Tower');
      final majorB = TarotCardData.allCards.firstWhere((c) => c.name == 'The Star').copyWith(isReversed: true);

      final result = await repository.consultOracle(
        drawnCards: [majorA, majorB],
        spreadType: SpreadType.threeFates,
        question: 'Navigating profound upheaval',
      );

      final interpretation = result['interpretation'].toString();
      expect(interpretation, contains('KARMIC SOUL CROSSROADS'));
      expect(interpretation, contains('OPTICAL GAZE'));
      expect(result['micro_ritual'], isNotNull);
    });

    // 8. Follow-up Dialogue Memory
    test('askOracleFollowUp provides grounded archetypal response in context', () async {
      final repository = TarotRepository();
      final card = TarotCardData.allCards.firstWhere((c) => c.name == 'The Magician');
      final reading = Reading(
        id: 'r_follow_up_test',
        question: 'How do I manifest my purpose?',
        spreadType: SpreadType.dailyGuidance.id,
        cards: [card],
        interpretation: 'The Magician bridges the infinite into tangible reality.',
        advice: 'Align sovereign will with compassionate action.',
        createdAt: DateTime.now(),
      );

      final answer = await repository.askOracleFollowUp(
        reading: reading,
        userQuestion: 'How can I conquer my self-doubt?',
        conversationHistory: [],
      );

      expect(answer, contains('The Magician'));
      expect(answer, contains('self-doubt'));
    });


    // 7. Widget Verification: SeekersChronicleScreen
    testWidgets('SeekersChronicleScreen renders cycle tabs and metrics cleanly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SeekersChronicleScreen(),
          ),
        ),
      );

      expect(find.text("THE SEEKER'S CHRONICLE"), findsOneWidget);
      expect(find.text("7-DAY CRUCIBLE"), findsOneWidget);
      expect(find.text("30-DAY SOLSTICE"), findsOneWidget);
      expect(find.text("SACRED SPREADS"), findsOneWidget);
    });

    // 8. Widget Verification: DreamOracleModal
    testWidgets('DreamOracleModal renders archetypes and altar consecration button', (tester) async {
      final dream = DreamEntry(
        id: 'dream_1',
        title: 'Flying over the Crystal Spire',
        narrative: 'I soared above an ancient tower with wings of light.',
        mood: 'Transcendent',
        recordedAt: DateTime.now(),
        symbols: ['spirit', 'sky'],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: DreamOracleModal(dream: dream),
            ),
          ),
        ),
      );

      expect(find.text('DREAM ALTAR SYNTHESIS'), findsOneWidget);
      expect(find.text('CONSECRATE UPON SACRED ALTAR'), findsOneWidget);
      expect(find.text('VISION: "Flying over the Crystal Spire"'), findsOneWidget);
    });

    // 9. Widget Verification: OraclePersonaSelectorModal
    testWidgets('OraclePersonaSelectorModal renders all 5 archetypal voices', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: OraclePersonaSelectorModal(),
            ),
          ),
        ),
      );

      expect(find.text('ORACLE ARCHETYPE'), findsOneWidget);
      expect(find.text('THE HIGH PRIESTESS'), findsOneWidget);
      expect(find.text('THE HERMIT'), findsOneWidget);
      expect(find.text('THE EMPRESS'), findsOneWidget);
      expect(find.text('THE MAGICIAN'), findsOneWidget);
      expect(find.text('THE SHADOW MIRROR'), findsOneWidget);
    });
  });
}
