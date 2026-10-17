import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/core/services/sensory_service.dart';
import 'package:tarot_app/core/services/review_service.dart';
import 'package:tarot_app/features/tarot/data/tarot_repository.dart';
import 'package:tarot_app/features/tarot/domain/tarot_card.dart';
import 'package:tarot_app/features/tarot/domain/spread_type.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Sensory Settings & Persistence Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('SensoryService initializes with default true values', () {
      final sensory = SensoryService.instance;
      expect(sensory.soundEnabled, isTrue);
      expect(sensory.hapticsEnabled, isTrue);
    });

    test('SensorySettingsNotifier updates state and persists to SharedPreferences', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(sensorySettingsProvider.notifier);
      expect(container.read(sensorySettingsProvider).soundEnabled, isTrue);

      await notifier.setSoundEnabled(false);
      expect(container.read(sensorySettingsProvider).soundEnabled, isFalse);
      expect(SensoryService.instance.soundEnabled, isFalse);

      await notifier.setHapticsEnabled(false);
      expect(container.read(sensorySettingsProvider).hapticsEnabled, isFalse);
      expect(SensoryService.instance.hapticsEnabled, isFalse);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('sensory_sound_enabled'), isFalse);
      expect(prefs.getBool('sensory_haptics_enabled'), isFalse);
    });
  });

  group('ReviewService Milestone Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('ReviewService increments readings count safely without throwing', () async {
      final review = ReviewService.instance;
      await review.checkAndPromptForReview();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('review_completed_readings_count'), 1);

      await review.checkAndPromptForReview(streak: 7);
      expect(prefs.getInt('review_completed_readings_count'), 2);
    });
  });

  group('Sacred Journal Export & GDPR Portability Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('exportSacredJournalAsJson returns valid structured JSON document', () async {
      final repo = TarotRepository();
      const testCard = TarotCard(
        id: 'the_magician',
        name: 'The Magician',
        number: 1,
        arcana: 'major',
        keywords: ['willpower', 'manifestation'],
        meaningUpright: 'Creative potential and mastery.',
        meaningReversed: 'Blocked talent or manipulation.',
        element: 'Air',
      );

      await repo.saveReading(
        question: 'What is unfolding?',
        spreadType: SpreadType.dailyGuidance,
        drawnCards: [testCard],
        interpretation: 'The astral currents align with sovereign will.',
        summary: 'Awaken your inner creator.',
        advice: 'Take bold action.',
      );

      final exportedJson = await repo.exportSacredJournalAsJson();
      expect(exportedJson, isNotEmpty);

      final decoded = jsonDecode(exportedJson) as Map<String, dynamic>;
      expect(decoded['sacred_archive_title'], contains('Sacred Journal'));
      expect(decoded['app_version'], '1.0.0+1');
      expect(decoded['total_readings'], greaterThanOrEqualTo(1));
      expect(decoded['readings'], isA<List>());
    });

    test('purgeAllUserData completely clears local readings and persistent store', () async {
      final repo = TarotRepository();
      const testCard = TarotCard(
        id: 'the_fool',
        name: 'The Fool',
        number: 0,
        arcana: 'major',
        keywords: ['beginnings', 'leap of faith'],
        meaningUpright: 'A new adventure begins.',
        meaningReversed: 'Recklessness.',
        element: 'Air',
      );

      await repo.saveReading(
        question: 'Testing purge',
        spreadType: SpreadType.dailyGuidance,
        drawnCards: [testCard],
        interpretation: 'Beginning of the journey.',
      );

      final historyBefore = await repo.getReadingHistory();
      expect(historyBefore, isNotEmpty);

      await repo.purgeAllUserData();

      final historyAfter = await repo.getReadingHistory();
      expect(historyAfter, isEmpty);
    });
  });
}

