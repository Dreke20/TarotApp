import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/tarot/domain/tarot_card.dart';
import 'package:tarot_app/features/tarot/services/tarot_widget_service.dart';

void main() {
  group('TarotWidgetService Unit Tests', () {
    late TarotWidgetService service;

    setUp(() {
      service = TarotWidgetService();
    });

    test('getDeterministicDailyCard produces consistent card for same day', () {
      final dateA = DateTime.utc(2026, 10, 15, 8, 30);
      final dateB = DateTime.utc(2026, 10, 15, 23, 59);

      final cardA = service.getDeterministicDailyCard(dateA);
      final cardB = service.getDeterministicDailyCard(dateB);

      expect(cardA.id, equals(cardB.id));
      expect(cardA.name, equals(cardB.name));
    });

    test('generateDailyData formats upright card and lunar transit accurately', () {
      final fixedDate = DateTime.utc(2026, 10, 15, 12, 0);
      const testCard = TarotCard(
        id: 'major_17_the_star',
        name: 'The Star',
        arcana: 'major',
        number: 17,
        meaningUpright: 'Hope, faith, purpose, renewal, spirituality.',
        meaningReversed: 'Lack of faith, despair, discouragement.',
        keywords: ['Hope', 'Faith', 'Inspiration'],
        element: 'Air',
      );

      final data = service.generateDailyData(
        card: testCard,
        isReversed: false,
        date: fixedDate,
      );

      expect(data.cardTitle, equals('The Star'));
      expect(data.cardSubtitle, contains('MAJOR 17'));
      expect(data.cardSubtitle, contains('Air'));
      expect(data.cardMeaning, equals(testCard.meaningUpright));
      expect(data.moonPhase, isNotEmpty);
      expect(data.moonZodiac, contains('Moon in'));
      expect(data.dailyDate, contains('Oct 15'));
    });

    test('generateDailyData formats reversed card title and reversed meaning', () {
      final fixedDate = DateTime.utc(2026, 10, 15, 12, 0);
      const testCard = TarotCard(
        id: 'major_1_the_magician',
        name: 'The Magician',
        arcana: 'major',
        number: 1,
        meaningUpright: 'Manifestation, resourcefulness, power.',
        meaningReversed: 'Illusion, out of touch, manipulation.',
        keywords: ['Manifestation', 'Power'],
        element: 'Air',
      );

      final data = service.generateDailyData(
        card: testCard,
        isReversed: true,
        date: fixedDate,
      );

      expect(data.cardTitle, equals('The Magician (Reversed)'));
      expect(data.cardMeaning, equals(testCard.meaningReversed));
    });

    test('updateHomeScreenWidget runs safely without throwing on non-mobile test runner', () async {
      // In flutter test (desktop host), updateHomeScreenWidget must return false gracefully
      final result = await service.updateHomeScreenWidget();
      expect(result, isFalse);
    });
  });
}
