import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tarot_app/features/sanctuary/data/sanctum_catalog.dart';
import 'package:tarot_app/features/sanctuary/domain/sanctum_item.dart';
import 'package:tarot_app/features/sanctuary/presentation/screens/mystic_sanctum_hub_modal.dart';
import 'package:tarot_app/features/sanctuary/presentation/widgets/sanctum_item_card.dart';

void main() {
  group('Mystic Sanctum Hub • Catalog & Omni-Search Tests', () {
    test('Catalog contains all 4 sacred quadrants with valid sanctuaries', () {
      expect(SanctumCatalog.allSanctuaries.isNotEmpty, isTrue);

      final divinationItems =
          SanctumCatalog.getCategoryItems(SanctumCategory.divination);
      final celestialItems =
          SanctumCatalog.getCategoryItems(SanctumCategory.celestial);
      final innerItems = SanctumCatalog.getCategoryItems(SanctumCategory.inner);
      final grimoireItems =
          SanctumCatalog.getCategoryItems(SanctumCategory.grimoire);

      expect(divinationItems.length, greaterThanOrEqualTo(5));
      expect(celestialItems.length, greaterThanOrEqualTo(4));
      expect(innerItems.length, greaterThanOrEqualTo(5));
      expect(grimoireItems.length, greaterThanOrEqualTo(5));

      // Verify each quadrant has unique IDs and valid titles
      final allIds = SanctumCatalog.allSanctuaries.map((s) => s.id).toSet();
      expect(allIds.length, equals(SanctumCatalog.allSanctuaries.length));
    });

    test('omniSearch returns empty on blank queries', () {
      expect(SanctumCatalog.omniSearch(''), isEmpty);
      expect(SanctumCatalog.omniSearch('   '), isEmpty);
    });

    test('omniSearch finds core Sanctuaries by keyword', () {
      final arResults = SanctumCatalog.omniSearch('AR Altar');
      expect(arResults.any((r) => r.id == 'sanctuary_ar_altar'), isTrue);

      final voiceResults = SanctumCatalog.omniSearch('voice');
      expect(voiceResults.any((r) => r.id == 'sanctuary_voice_oracle'), isTrue);

      final lensResults = SanctumCatalog.omniSearch('camera');
      expect(lensResults.any((r) => r.id == 'sanctuary_tarot_lens'), isTrue);
    });

    test('omniSearch finds Tarot Cards across Major & Minor Arcana', () {
      final foolResults = SanctumCatalog.omniSearch('The Fool');
      expect(foolResults.any((r) => r.id == 'card_major_0_the_fool'), isTrue);

      final priestessResults = SanctumCatalog.omniSearch('High Priestess');
      expect(
        priestessResults.any((r) => r.id == 'card_major_2_the_high_priestess'),
        isTrue,
      );

      final aceOfWands = SanctumCatalog.omniSearch('Ace of Wands');
      expect(aceOfWands.any((r) => r.title.contains('Ace of Wands')), isTrue);
    });

    test('omniSearch finds Elder Futhark Runes', () {
      final fehu = SanctumCatalog.omniSearch('Fehu');
      expect(fehu.any((r) => r.id == 'rune_fehu'), isTrue);

      final uruz = SanctumCatalog.omniSearch('Vital Strength');
      expect(uruz.any((r) => r.id == 'rune_uruz'), isTrue);
    });

    test('omniSearch finds I Ching Hexagrams', () {
      final qian = SanctumCatalog.omniSearch('Creative Force');
      expect(qian.any((r) => r.id == 'iching_1'), isTrue);

      final kun = SanctumCatalog.omniSearch('Receptive Earth');
      expect(kun.any((r) => r.id == 'iching_2'), isTrue);
    });

    test('omniSearch finds Jungian Dream Symbols', () {
      final water = SanctumCatalog.omniSearch('Abyssal Ocean');
      expect(water.any((r) => r.id == 'dream_water'), isTrue);

      final shadow = SanctumCatalog.omniSearch('Jungian Shadow');
      expect(shadow.any((r) => r.id == 'dream_shadow'), isTrue);
    });

    test('omniSearch finds Wheel of the Year Sabbats', () {
      final samhain = SanctumCatalog.omniSearch('Samhain');
      expect(samhain.any((r) => r.id == 'sabbat_samhain'), isTrue);

      final yule = SanctumCatalog.omniSearch('Winter Solstice');
      expect(yule.any((r) => r.id == 'sabbat_yule'), isTrue);
    });

    test('omniSearch finds Archetypal Pathworkings', () {
      final pathworking = SanctumCatalog.omniSearch('Primordial Trust');
      expect(
        pathworking.any((r) => r.id == 'pathworking_the_fools_leap'),
        isTrue,
      );
    });
  });

  group('Mystic Sanctum Hub • Widget & Modal UI Tests', () {
    testWidgets('MysticSanctumHubModal renders header, search field and quadrants',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MysticSanctumHubModal(),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Verify Header
      expect(find.text('MYSTIC SANCTUM'), findsOneWidget);
      expect(find.text('SACRED REALMS & ESOTERIC OMNI-PORTAL'), findsOneWidget);

      // Verify Omni-Search Bar
      expect(
        find.text('Seek any card, rune, hexagram, or sanctuary...'),
        findsOneWidget,
      );

      // Verify Category Filter Tabs
      expect(find.text('ALL REALMS'), findsOneWidget);

      // Verify Sanctum Items are mounted
      expect(find.byType(SanctumItemCard), findsWidgets);
      expect(find.text('Astral Guidance Altar'), findsOneWidget);
    });

    testWidgets('Entering query switches view to live Omni-Search results',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MysticSanctumHubModal(),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Enter search term
      await tester.enterText(find.byType(TextField), 'The High Priestess');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Verify search header appears
      expect(find.textContaining('ESOTERIC RESONANCES DISCOVERED'), findsOneWidget);
      expect(find.text('The High Priestess'), findsWidgets);

      // Clear the query via the clear button
      final clearButton = find.byKey(const Key('omni_search_clear_button'));
      await tester.tap(clearButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Restored back to categorized view
      expect(find.text('ALL REALMS'), findsOneWidget);
    });
  });
}
