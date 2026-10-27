import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/features/monetization/domain/celestial_bazaar_models.dart';
import 'package:tarot_app/features/monetization/presentation/notifiers/bazaar_notifier.dart';
import 'package:tarot_app/features/monetization/presentation/widgets/celestial_flash_banner.dart';
import 'package:tarot_app/features/monetization/presentation/widgets/grimoire_parchment_exporter.dart';
import 'package:tarot_app/features/monetization/presentation/widgets/mystic_bazaar_modal.dart';
import 'package:tarot_app/features/tarot/data/tarot_card_data.dart';
import 'package:tarot_app/features/tarot/domain/reading.dart';

import 'package:flutter_animate/flutter_animate.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    Animate.restartOnHotReload = false;
  });

  group('Celestial Bazaar Domain & Monetization Tests', () {
    test('ShardPack models have proper pricing and shard counts', () {
      expect(ShardPack.small.shardCount, 5);
      expect(ShardPack.medium.shardCount, 15);
      expect(ShardPack.large.shardCount, 40);

      expect(ShardPack.fromId('starlight_shards_medium'), ShardPack.medium);
    });

    test('CandleType models have elemental properties and 7-day duration calculations', () {
      expect(CandleType.values.length, 4);

      final candle = ActiveSanctuaryCandle(
        id: 'test_candle_1',
        type: CandleType.protection,
        intention: 'Sacred boundary of peace and vitality',
        litAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 7)),
      );

      expect(candle.isLit, isTrue);
      expect(candle.daysRemaining, greaterThanOrEqualTo(6));
    });

    test('CardFoilFinish accurately identifies free vs premium finishes', () {
      expect(CardFoilFinish.standard.isFree, isTrue);
      expect(CardFoilFinish.prismaticIridescent.isFree, isFalse);
      expect(CardFoilFinish.fromId('foil_golden_sunburst'), CardFoilFinish.goldenSunburst);
    });
  });

  group('BazaarNotifier State & Actions Tests', () {
    test('Can purchase shard pack and update state', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bazaarProvider.notifier);
      await pumpEventQueue();

      final success = await notifier.buyShardPack(ShardPack.medium);
      expect(success, isTrue);

      final state = container.read(bazaarProvider);
      expect(state.shards, 15);
      expect(state.message, contains('15 Starlight Shards received'));
    });

    test('Can light candle and deduct shards', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bazaarProvider.notifier);
      await pumpEventQueue();

      // Give shards first
      await notifier.buyShardPack(ShardPack.small); // 5 shards

      final success = await notifier.lightCandle(
        type: CandleType.love,
        intention: 'Harmony and sacred communion',
        isPro: false,
      );

      expect(success, isTrue);
      final state = container.read(bazaarProvider);
      expect(state.shards, 2); // 5 - 3 = 2
      expect(state.activeCandles.length, 1);
      expect(state.activeCandles.first.type, CandleType.love);
      expect(state.activeCandles.first.intention, 'Harmony and sacred communion');
    });

    test('Can equip and unlock holographic foil finish', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bazaarProvider.notifier);
      await pumpEventQueue();

      // Equip standard (free)
      await notifier.equipFoil(CardFoilFinish.standard);
      expect(container.read(bazaarProvider).equippedFoil, CardFoilFinish.standard.id);

      // Buy enough shards to unlock prismatic
      await notifier.buyShardPack(ShardPack.medium); // 15 shards
      final unlocked = await notifier.unlockFoil(CardFoilFinish.prismaticIridescent, isPro: false);
      expect(unlocked, isTrue);
      expect(container.read(bazaarProvider).isFoilUnlocked(CardFoilFinish.prismaticIridescent.id), isTrue);
      expect(container.read(bazaarProvider).shards, 7); // 15 - 8 = 7
    });

    test('Can generate Twin Flame Synastry Dossier', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bazaarProvider.notifier);
      await pumpEventQueue();

      await notifier.buyShardPack(ShardPack.small); // 5 shards
      final dossier = await notifier.generateSynastryDossier(
        seekerName: 'Aria',
        partnerName: 'Julian',
        seekerSign: 'Scorpio',
        partnerSign: 'Cancer',
        isPro: false,
      );

      expect(dossier, isNotNull);
      expect(dossier!.seekerName, 'Aria');
      expect(dossier.partnerName, 'Julian');
      expect(dossier.harmonyScore, inInclusiveRange(70, 100));
      expect(container.read(bazaarProvider).dossiers.length, 1);
    });
  });

  group('Monetization Widgets Tests', () {
    testWidgets('CelestialFlashBanner renders properly with active discount', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CelestialFlashBanner(),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.textContaining('FLASH EVENT', findRichText: true).evaluate().isNotEmpty ||
             find.textContaining('BONUS', findRichText: true).evaluate().isNotEmpty ||
             find.textContaining('RITUALS', findRichText: true).evaluate().isNotEmpty, isTrue);
      expect(find.text('TAP TO ENTER BAZAAR ›'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 500));
    });

    testWidgets('GrimoireParchmentExporter renders parchment transcript', (tester) async {
      final sampleReading = Reading(
        id: 'test_reading_1',
        question: 'What message does the universe have for me?',
        spreadType: 'three_fates',
        cards: [
          TarotCardData.allCards[0],
          TarotCardData.allCards[1],
        ],
        interpretation: 'The Star shines upon your spiritual ascent.',
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GrimoireParchmentExporter(reading: sampleReading),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('SACRED GRIMOIRE MANUSCRIPT'), findsOneWidget);
      expect(find.text('SHARE GRIMOIRE'), findsOneWidget);
      expect(find.text('COPY TRANSCRIPT'), findsOneWidget);
      expect(find.text('"What message does the universe have for me?"'), findsOneWidget);
    });

    testWidgets('MysticBazaarModal renders all 4 tabs', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MysticBazaarModal(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('MYSTIC BAZAAR & TREASURY'), findsOneWidget);
      expect(find.text('SHARDS'), findsOneWidget);
      expect(find.text('CANDLES'), findsOneWidget);
      expect(find.text('HOLO FOILS'), findsOneWidget);
      expect(find.text('SYNASTRY'), findsOneWidget);
    });
  });
}
