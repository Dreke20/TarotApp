import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/tarot/data/tarot_card_data.dart';
import 'package:tarot_app/features/tarot/domain/card_deck_style.dart';
import 'package:tarot_app/features/tarot/presentation/notifiers/deck_style_notifier.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/deck_switcher_modal.dart';
import 'package:tarot_app/features/wallpaper/domain/wallpaper_config.dart';
import 'package:tarot_app/features/wallpaper/presentation/screens/wallpaper_studio_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Tier 1 • CardDeckStyle & Deck Sanctuary Tests', () {
    test('CardDeckStyle has 5 rich visual styles with unique IDs', () {
      expect(CardDeckStyle.values.length, 5);
      expect(CardDeckStyle.whispersAndWarnings.id, 'whispers_and_warnings');
      expect(CardDeckStyle.astralSilver.id, 'astral_silver');
      expect(CardDeckStyle.vintageAlchemical.id, 'vintage_alchemical');
      expect(CardDeckStyle.amethystStarlight.id, 'amethyst_starlight');
      expect(CardDeckStyle.solarLuminary.id, 'solar_luminary');

      // Test fallback
      expect(CardDeckStyle.fromId('unknown_style'), CardDeckStyle.whispersAndWarnings);
      expect(CardDeckStyle.fromId('astral_silver'), CardDeckStyle.astralSilver);
    });

    test('CardDeckStyle themes have valid primary accents and color filters', () {
      for (final style in CardDeckStyle.values) {
        expect(style.primaryAccent, isNotNull);
        expect(style.foilColors, isNotEmpty);
      }
      expect(CardDeckStyle.astralSilver.colorFilter, isNotNull);
      expect(CardDeckStyle.vintageAlchemical.colorFilter, isNotNull);
      expect(CardDeckStyle.whispersAndWarnings.colorFilter, isNull);
    });

    test('DeckStyleNotifier defaults to whispersAndWarnings and updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initial = container.read(deckStyleProvider);
      expect(initial, CardDeckStyle.whispersAndWarnings);

      container.read(deckStyleProvider.notifier).selectStyle(CardDeckStyle.astralSilver);
      expect(container.read(deckStyleProvider), CardDeckStyle.astralSilver);
    });

    testWidgets('DeckSwitcherModal mounts preview card, 5 deck styles, and action button',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: DeckSwitcherModal(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('DECK SANCTUARY'), findsOneWidget);
      expect(find.text('Whispers & Warnings'), findsWidgets);
      expect(find.text('Astral Silver & Sapphire'), findsWidgets);
      // Scroll down so the deck selector carousel is fully in view
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();

      // Tap on Astral Silver & Sapphire to preview a new deck
      final astralOption = find.text('Astral Silver & Sapphire').first;
      await tester.ensureVisible(astralOption);
      await tester.tap(astralOption);
      await tester.pumpAndSettle();

      // Now the button changes to CONSECRATE DECK STYLE
      expect(find.text('CONSECRATE DECK STYLE'), findsOneWidget);
    });
  });

  group('Tier 1 • Sacred Wallpaper Studio Tests', () {
    test('WallpaperAspectRatio has 3 distinct standard mobile ratios', () {
      expect(WallpaperAspectRatio.values.length, 3);
      expect(WallpaperAspectRatio.standard.ratio, closeTo(9 / 16, 0.01));
      expect(WallpaperAspectRatio.modern.ratio, closeTo(9 / 19.5, 0.01));
      expect(WallpaperAspectRatio.tall.ratio, closeTo(9 / 20, 0.01));
    });

    test('WallpaperTheme defines 4 celestial themes with valid palettes', () {
      expect(WallpaperTheme.values.length, 4);
      for (final theme in WallpaperTheme.values) {
        expect(theme.gradientColors.length, greaterThanOrEqualTo(2));
        expect(theme.accentColor, isNotNull);
      }
    });

    testWidgets('WallpaperStudioScreen mounts preview, ratio chips, and export button',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final testCard = TarotCardData.allCards.first;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: WallpaperStudioScreen(initialCard: testCard),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('SACRED WALLPAPER STUDIO'), findsOneWidget);
      expect(find.text('EXPORT 4K'), findsOneWidget);
      expect(find.text('9:19.5 Modern'), findsOneWidget);
      expect(find.text('Imperial 24k Gold'), findsWidgets);
      expect(find.text('Mantra'), findsOneWidget);

      // Tap on 9:16 Classic chip
      await tester.tap(find.text('9:16 Classic'));
      await tester.pumpAndSettle();

      // Tap Clock preview toggle
      await tester.tap(find.text('Clock'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });
  });
}
