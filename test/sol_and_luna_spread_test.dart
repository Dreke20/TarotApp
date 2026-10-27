import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/features/sanctuary/data/sanctum_catalog.dart';
import 'package:tarot_app/features/tarot/data/tarot_deck_service.dart';
import 'package:tarot_app/features/tarot/data/tarot_repository.dart';
import 'package:tarot_app/features/tarot/domain/spread_type.dart';
import 'package:tarot_app/features/tarot/domain/synastry_partner.dart';
import 'package:tarot_app/features/tarot/presentation/notifiers/reading_notifier.dart';
import 'package:tarot_app/features/tarot/presentation/notifiers/reading_state.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/spread_board_view.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/spread_selector.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Sol & Luna Synastry Spread Domain & Service Tests', () {
    final deckService = TarotDeckService();
    final repository = TarotRepository();

    test('SpreadType.solAndLuna has correct 3-card synastry configuration', () {
      final spread = SpreadType.solAndLuna;
      expect(spread.id, 'sol_and_luna');
      expect(spread.cardCount, 3);
      expect(spread.title, 'Sol & Luna Synastry');
      expect(spread.positionTitles.length, 3);
      expect(spread.positionTitles[0], contains('Partner A'));
      expect(spread.positionTitles[1], contains('Partner B'));
      expect(spread.positionTitles[2], contains('The Conjunction'));

      expect(SpreadType.fromId('sol_and_luna'), SpreadType.solAndLuna);
    });

    test('TarotDeckService draws 3 cards with Sol & Luna position titles', () {
      final drawn = deckService.drawSpread(spreadType: SpreadType.solAndLuna);
      expect(drawn.length, 3);
      expect(drawn[0].positionName, contains('Partner A'));
      expect(drawn[1].positionName, contains('Partner B'));
      expect(drawn[2].positionName, contains('The Conjunction'));
    });

    test('TarotRepository generates bespoke Sol & Luna synastry synthesis', () async {
      final deck = deckService.drawSpread(spreadType: SpreadType.solAndLuna);
      final partner = const SynastryPartner(
        name: 'Elena Vance',
        sunSign: 'Taurus',
        moonSign: 'Pisces',
        connectionType: 'Twin Flame Sacred Conjunction',
      );

      final interpretation = await repository.consultOracle(
        question: 'What is our shared soul destiny?',
        spreadType: SpreadType.solAndLuna,
        drawnCards: deck,
        astrologyInfo: {
          'sun': 'Scorpio',
          'partner_name': partner.name,
          'partner_sun': partner.sunSign,
          'connection_type': partner.connectionType,
        },
      );

      expect(interpretation['summary'], contains('Sol & Luna Synastry'));
      expect(interpretation['summary'], contains('Elena Vance'));
      expect(interpretation['interpretation'], contains('SOL & LUNA RELATIONSHIP SYNASTRY'));
      expect(interpretation['interpretation'], contains('Partner A (Solar Essence & Will)'));
      expect(interpretation['interpretation'], contains('Partner B (Lunar Reflection & Heart)'));
      expect(interpretation['interpretation'], contains('The Conjunction Bridge'));
      expect(interpretation['advice'], isNotEmpty);
    });
  });

  group('Sol & Luna Synastry Altar UI & Widget Tests', () {
    testWidgets('SpreadSelector includes Sol & Luna option and fires callback', (tester) async {
      tester.view.physicalSize = const Size(1600, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      SpreadType? selected;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpreadSelector(
              selectedSpread: SpreadType.dailyGuidance,
              onSpreadChanged: (spread) => selected = spread,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find Sol & Luna spread option
      final solLunaOption = find.text('Sol & Luna Synastry');
      expect(solLunaOption, findsOneWidget);

      await tester.ensureVisible(solLunaOption);
      await tester.pumpAndSettle();

      await tester.tap(solLunaOption);
      await tester.pumpAndSettle();

      expect(selected, SpreadType.solAndLuna);
    });

    testWidgets('SpreadBoardView renders dedicated Sol & Luna 3-card altar pods', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final deck = TarotDeckService().drawSpread(spreadType: SpreadType.solAndLuna);
      const partner = SynastryPartner(
        name: 'Aurelia Sol',
        sunSign: 'Leo',
        connectionType: 'Alchemical Soul Mirror',
      );

      final readingState = ReadingState(
        spreadType: SpreadType.solAndLuna,
        drawnCards: deck,
        revealedIndices: {0, 1, 2},
        synastryPartner: partner,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, _) {
                  final notifier = ref.read(readingNotifierProvider.notifier);
                  return SpreadBoardView(
                    state: readingState,
                    notifier: notifier,
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Synastry Calibration Bar
      expect(find.text('Seeker'), findsOneWidget);
      expect(find.text('Aurelia Sol (Leo)'), findsOneWidget);
      expect(find.text('Alchemical Soul Mirror'), findsOneWidget);

      // Verify 3 Sacred Pods
      expect(find.text('PARTNER A'), findsOneWidget);
      expect(find.text('Solar Will & Essence'), findsOneWidget);

      expect(find.text('THE CONJUNCTION'), findsOneWidget);
      expect(find.text('Alchemical Destiny'), findsOneWidget);

      expect(find.text('PARTNER B'), findsOneWidget);
      expect(find.text('Lunar Heart & Depth'), findsOneWidget);
    });

    test('SanctumCatalog contains sanctuary_sol_luna_spread', () {
      final item = SanctumCatalog.allSanctuaries.firstWhere(
        (s) => s.id == 'sanctuary_sol_luna_spread',
      );
      expect(item.title, 'Sol & Luna Synastry Spread');
      expect(item.badgeText, 'SYNASTRY SPREAD');
      expect(item.searchKeywords, contains('synastry'));
      expect(item.searchKeywords, contains('sol and luna'));
    });
  });
}
