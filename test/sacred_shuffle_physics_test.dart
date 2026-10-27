import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/tarot/data/tarot_deck_service.dart';
import 'package:tarot_app/features/tarot/domain/shuffle_ritual.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/deck_pile_widget.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/sacred_riffle_shuffle_modal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Sacred Deck Physics & Shuffling Algorithms Tests', () {
    final service = TarotDeckService();

    test('riffleShuffleDeck preserves 78 unique cards and applies reversals', () {
      final initialDeck = service.getFullDeck();
      expect(initialDeck.length, 78);

      final riffled = service.riffleShuffleDeck(passes: 3, allowReversals: true);

      expect(riffled.length, 78);
      // All 78 unique cards must still be present
      final ids = riffled.map((c) => c.id).toSet();
      expect(ids.length, 78);

      // Order should differ from original
      final initialOrder = initialDeck.map((c) => c.id).toList();
      final riffledOrder = riffled.map((c) => c.id).toList();
      expect(riffledOrder, isNot(equals(initialOrder)));
    });

    test('threePileCutDeck splits and reorders by intuitive sequence', () {
      final fullDeck = service.getFullDeck();
      final originalFirst = fullDeck.first.id;

      // Restack with pile 2 (Future) placed first
      final cutDeck = service.threePileCutDeck(deck: fullDeck, restackOrder: [2, 0, 1]);

      expect(cutDeck.length, 78);
      expect(cutDeck.first.id, isNot(equals(originalFirst)));

      // Exactly matches top of 3rd pile
      expect(cutDeck.first.id, fullDeck[52].id);
    });

    test('celticChaosScatter randomizes entire 78-card deck', () {
      final scattered = service.celticChaosScatter(allowReversals: true);
      expect(scattered.length, 78);
      final ids = scattered.map((c) => c.id).toSet();
      expect(ids.length, 78);
    });

    test('ShuffleStyle enum has all 3 sacred styles configured', () {
      expect(ShuffleStyle.values.length, 3);
      expect(ShuffleStyle.riffleBridge.glyph, '🎴');
      expect(ShuffleStyle.celticScatter.glyph, '🌀');
      expect(ShuffleStyle.threePilesCut.glyph, '⚖️');
    });
  });

  group('3D Shuffle Widgets Tests', () {
    testWidgets('DeckPileWidget supports onTap and onLongPress', (tester) async {
      bool tapped = false;
      bool longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeckPileWidget(
              isShuffling: false,
              onTap: () => tapped = true,
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      expect(find.byType(DeckPileWidget), findsOneWidget);
      expect(find.text('78'), findsOneWidget);
      expect(find.text('CARDS'), findsOneWidget);

      await tester.tap(find.byType(DeckPileWidget));
      expect(tapped, isTrue);

      await tester.longPress(find.byType(DeckPileWidget));
      expect(longPressed, isTrue);
    });

    testWidgets('SacredRiffleShuffleModal mounts styles and triggers interactive cut', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SacredRiffleShuffleModal(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('SACRED 3D SHUFFLE STUDIO'), findsOneWidget);
      expect(find.text('🎴'), findsWidgets);
      expect(find.text('🌀'), findsWidgets);
      expect(find.text('⚖️'), findsWidgets);

      // Switch to Three Fates Tri-Fold Cut
      await tester.tap(find.text('⚖️').first);
      await tester.pumpAndSettle();

      expect(find.text('THREE FATES TRI-FOLD CUT'), findsOneWidget);
      expect(find.text('The Weaver'), findsOneWidget);
      expect(find.text('The Measurer'), findsOneWidget);
      expect(find.text('The Cutter'), findsOneWidget);

      // Tap piles 2, 0, 1 to restack
      await tester.tap(find.text('The Cutter'));
      await tester.pump();
      await tester.tap(find.text('The Weaver'));
      await tester.pump();
      await tester.tap(find.text('The Measurer'));
      await tester.pumpAndSettle();

      expect(find.text('✦ CONSECRATE & DEAL SPREAD ✦'), findsOneWidget);
    });

    testWidgets('SacredRiffleShuffleModal.show launches via bottom sheet and performs riffle shuffle', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => SacredRiffleShuffleModal.show(context),
                  child: const Text('OPEN 3D SHUFFLE'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap to open modal
      await tester.tap(find.text('OPEN 3D SHUFFLE'));
      await tester.pumpAndSettle();

      expect(find.text('SACRED 3D SHUFFLE STUDIO'), findsOneWidget);
      expect(find.text('SACRED RIFFLE & BRIDGE'), findsOneWidget);
      expect(find.text('INITIATE SACRED RIFFLE & BRIDGE'), findsOneWidget);

      // Perform a Riffle & Cascade Pass
      await tester.tap(find.text('INITIATE SACRED RIFFLE & BRIDGE'));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      // Check Celtic Scatter tab
      await tester.tap(find.text('🌀').first);
      await tester.pumpAndSettle();
      expect(find.text('CELTIC ALTAR CHAOS WASH'), findsOneWidget);
      expect(find.text('INITIATE CELTIC ALTAR CHAOS WASH'), findsOneWidget);

      // Perform Scatter
      await tester.tap(find.text('INITIATE CELTIC ALTAR CHAOS WASH'));
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      // Consecrate button should appear
      expect(find.text('✦ CONSECRATE & DEAL SPREAD ✦'), findsOneWidget);
    });
  });
}
