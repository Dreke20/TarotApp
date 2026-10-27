import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/features/tarot/data/tarot_card_data.dart';
import 'package:tarot_app/features/tarot/domain/tarot_card.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/mystic_widget_hub_modal.dart';
import 'package:tarot_app/features/tarot/services/tarot_widget_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('TarotWidgetService Unit Tests', () {
    final service = TarotWidgetService();

    test('getDeterministicDailyCard produces consistent seed-based cards', () {
      final date1 = DateTime(2026, 10, 24);
      final date2 = DateTime(2026, 10, 24);
      final date3 = DateTime(2026, 10, 25);

      final card1 = service.getDeterministicDailyCard(date1);
      final card2 = service.getDeterministicDailyCard(date2);
      final card3 = service.getDeterministicDailyCard(date3);

      expect(card1.id, card2.id);
      expect(card1.name, card2.name);
      // Different day seed gives different card index
      expect(card1.id, isNot(card3.id));
    });

    test('generateDailyData constructs complete widget payload with moon phase', () {
      const card = TarotCard(
        id: 'major_17_the_star',
        name: 'The Star',
        arcana: 'major',
        number: 17,
        meaningUpright: 'Hope, faith, purpose, renewal',
        meaningReversed: 'Lack of faith, despair, discouragement',
        element: 'Air',
      );
      final fixedDate = DateTime(2026, 10, 24, 12, 0);

      final data = service.generateDailyData(
        card: card,
        isReversed: false,
        date: fixedDate,
      );

      expect(data.cardTitle, 'The Star');
      expect(data.cardSubtitle, contains('MAJOR'));
      expect(data.cardSubtitle, contains('17'));
      expect(data.cardSubtitle, contains('Air'));
      expect(data.cardMeaning, 'Hope, faith, purpose, renewal');
      expect(data.moonPhase, isNotEmpty);
      expect(data.moonZodiac, contains('Moon in'));
      expect(data.dailyDate, contains('Saturday'));
    });

    test('handles card reversal in generated widget payload', () {
      const card = TarotCard(
        id: 'major_16_the_tower',
        name: 'The Tower',
        arcana: 'major',
        number: 16,
        meaningUpright: 'Sudden upheaval, disaster',
        meaningReversed: 'Disaster avoided, delayed disaster',
      );

      final data = service.generateDailyData(
        card: card,
        isReversed: true,
      );

      expect(data.cardTitle, 'The Tower (Reversed)');
      expect(data.cardMeaning, 'Disaster avoided, delayed disaster');
    });

    test('persists and toggles WidgetSyncMode in SharedPreferences', () async {
      expect(await service.getSyncMode(), WidgetSyncMode.dailySeed);

      await service.setSyncMode(WidgetSyncMode.activeReading);
      expect(await service.getSyncMode(), WidgetSyncMode.activeReading);

      await service.setSyncMode(WidgetSyncMode.dailySeed);
      expect(await service.getSyncMode(), WidgetSyncMode.dailySeed);
    });

    test('resolveActiveCard mirrors recorded drawn card in activeReading mode', () async {
      await service.setSyncMode(WidgetSyncMode.activeReading);
      final testCard = TarotCardData.allCards.firstWhere((c) => c.id == 'major_0_the_fool');

      await service.recordDrawnCard(testCard, isReversed: true);

      final resolved = await service.resolveActiveCard();
      expect(resolved.card.id, testCard.id);
      expect(resolved.isReversed, isTrue);
    });

    test('updateHomeScreenWidget safely exits on non-mobile platform in test environment', () async {
      final success = await service.updateHomeScreenWidget();
      // In flutter test (desktop/headless), platform check returns false safely without throwing
      expect(success, isFalse);
    });
  });

  group('MysticWidgetHubModal Widget Tests', () {
    testWidgets('renders widget simulator preview, sync mode selector, and action buttons', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MysticWidgetHubModal(),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('DAILY MYSTIC WIDGET'), findsOneWidget);
      expect(find.text('LIVE WIDGET PREVIEW (4×2)'), findsOneWidget);
      expect(find.text('✦ ORACULUM'), findsOneWidget);
      expect(find.text('✦ CONSULT DAILY ORACLE ✦'), findsOneWidget);
      expect(find.text('WIDGET SYNCHRONIZATION MODE'), findsOneWidget);
      expect(find.text('Daily Celestial Seed'), findsOneWidget);
      expect(find.text('Active Reading Mirror'), findsOneWidget);
      expect(find.text('FORCE SYNC NOW'), findsOneWidget);
      expect(find.text('ADD TO HOME'), findsOneWidget);

      // Tap ADD TO HOME to verify manual installation dialog
      await tester.tap(find.text('ADD TO HOME'));
      await tester.pumpAndSettle();

      expect(find.text('HOW TO ADD WIDGET'), findsOneWidget);
      expect(find.textContaining('Return to your phone\'s Home Screen'), findsOneWidget);
      expect(find.text('UNDERSTOOD'), findsOneWidget);

      await tester.tap(find.text('UNDERSTOOD'));
      await tester.pumpAndSettle();

      expect(find.text('HOW TO ADD WIDGET'), findsNothing);
    });

    testWidgets('switches sync mode on tap', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MysticWidgetHubModal(),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Active Reading Mirror'));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Active Reading Mirror'), findsOneWidget);
    });
  });
}
