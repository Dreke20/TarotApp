import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/core/utils/lunar_calculator.dart';
import 'package:tarot_app/features/auth/domain/user_profile.dart';
import 'package:tarot_app/features/tarot/data/tarot_deck_service.dart';
import 'package:tarot_app/features/tarot/domain/oracle_message.dart';
import 'package:tarot_app/features/tarot/domain/spread_type.dart';
import 'package:tarot_app/main.dart';

void main() {
  group('Tarot Engine Domain Tests', () {
    test('Deck contains 78 unique cards', () {
      final service = TarotDeckService();
      final deck = service.getFullDeck();
      expect(deck.length, 78);

      final uniqueIds = deck.map((c) => c.id).toSet();
      expect(uniqueIds.length, 78);
    });

    test('Fisher-Yates shuffle produces properly permuted deck', () {
      final service = TarotDeckService();
      final deck = service.getFullDeck();
      final shuffled = service.shuffleDeck(deck: deck);

      expect(shuffled.length, 78);
      final exactOrderMatch = List.generate(78, (i) => deck[i].id == shuffled[i].id)
          .every((matches) => matches);
      expect(exactOrderMatch, isFalse);
    });

    test('Daily Guidance draws 1 card with correct position name', () {
      final service = TarotDeckService();
      final drawn = service.drawSpread(spreadType: SpreadType.dailyGuidance);

      expect(drawn.length, 1);
      expect(drawn.first.positionName, 'Today\'s Guidance');
    });

    test('The Three Fates draws 3 cards with Past, Present, Future positions', () {
      final service = TarotDeckService();
      final drawn = service.drawSpread(spreadType: SpreadType.threeFates);

      expect(drawn.length, 3);
      expect(drawn[0].positionName, contains('Past'));
      expect(drawn[1].positionName, contains('Present'));
      expect(drawn[2].positionName, contains('Future'));
    });

    test('The Celtic Cross draws 10 cards with all 10 life path positions', () {
      final service = TarotDeckService();
      final drawn = service.drawSpread(spreadType: SpreadType.celticCross);

      expect(drawn.length, 10);
      expect(drawn[0].positionName, contains('Present'));
      expect(drawn[1].positionName, contains('Crossing'));
      expect(drawn[9].positionName, contains('Culmination'));
    });

    test('OracleMessage model serializes and parses properly', () {
      final msg = OracleMessage(
        role: 'user',
        content: 'What does the Empress signify here?',
        timestamp: DateTime(2026, 10, 13),
      );
      final json = msg.toJson();
      expect(json['role'], 'user');
      expect(json['content'], 'What does the Empress signify here?');

      final parsed = OracleMessage.fromJson(json);
      expect(parsed.role, 'user');
      expect(parsed.content, msg.content);
    });

    test('UserProfile supports astrological signs and pro membership', () {
      const profile = UserProfile(
        id: 'u1',
        displayName: 'Aura',
        zodiacSign: 'Aries',
        moonSign: 'Scorpio',
        risingSign: 'Leo',
        isPro: true,
      );
      expect(profile.isPro, isTrue);
      expect(profile.zodiacSign, 'Aries');
      expect(profile.moonSign, 'Scorpio');
      expect(profile.risingSign, 'Leo');
    });

    test('Specialized Spreads draw accurate card counts and positions', () {
      final service = TarotDeckService();

      final heart = service.drawSpread(spreadType: SpreadType.heartOfTwo);
      expect(heart.length, 5);
      expect(heart[0].positionName, contains('Emotional Core'));
      expect(heart[4].positionName, contains('Harmonious Horizon'));

      final career = service.drawSpread(spreadType: SpreadType.careerCrossroads);
      expect(career.length, 5);
      expect(career[0].positionName, contains('Professional Station'));
      expect(career[4].positionName, contains('Peak Career'));

      final shadow = service.drawSpread(spreadType: SpreadType.shadowMirror);
      expect(shadow.length, 4);
      expect(shadow[0].positionName, contains('Persona'));
      expect(shadow[3].positionName, contains('Integration'));
    });

    test('LunarCalculator calculates valid moon phase and illumination', () {
      final lunar = LunarCalculator.getTodayLunarInfo();
      expect(lunar.phase.title.isNotEmpty, isTrue);
      expect(lunar.phase.symbol.isNotEmpty, isTrue);
      expect(lunar.illuminationPercent, inInclusiveRange(0.0, 100.0));
      expect(lunar.moonZodiac.isNotEmpty, isTrue);
    });
  });

  group('TarotApp Smoke Test', () {
    testWidgets('App renders Oraculum altar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: TarotApp(),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('ORACULUM'), findsOneWidget);
      expect(find.text('CONSULT ORACLE'), findsOneWidget);
    });
  });
}
