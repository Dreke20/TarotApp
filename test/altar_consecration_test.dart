import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/features/altar/domain/sacred_herb.dart';
import 'package:tarot_app/features/altar/domain/altar_crystal.dart';
import 'package:tarot_app/features/altar/domain/altar_consecration_state.dart';
import 'package:tarot_app/features/altar/presentation/notifiers/altar_consecration_notifier.dart';
import 'package:tarot_app/features/tarot/data/tarot_repository.dart';
import 'package:tarot_app/features/tarot/domain/spread_type.dart';
import 'package:tarot_app/features/tarot/domain/tarot_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SacredHerb Domain Tests', () {
    test('all 5 sacred herbs are uniquely identified', () {
      expect(SacredHerb.values.length, 5);
      final ids = SacredHerb.values.map((h) => h.id).toSet();
      expect(ids.length, 5);
    });

    test('SacredHerb.fromId returns correct herb or defaults to paloSanto', () {
      expect(SacredHerb.fromId('white_sage'), SacredHerb.whiteSage);
      expect(SacredHerb.fromId('copal_resin'), SacredHerb.copalResin);
      expect(SacredHerb.fromId('lavender_mugwort'), SacredHerb.lavenderMugwort);
      expect(SacredHerb.fromId('atlas_cedar'), SacredHerb.atlasCedar);
      expect(SacredHerb.fromId('non_existent'), SacredHerb.paloSanto);
    });

    test('all herbs have non-empty mantras and botanical titles', () {
      for (final herb in SacredHerb.values) {
        expect(herb.mantra.isNotEmpty, isTrue);
        expect(herb.botanicalTitle.isNotEmpty, isTrue);
        expect(herb.element.isNotEmpty, isTrue);
      }
    });
  });

  group('AltarCrystal and GridCorner Domain Tests', () {
    test('all 6 crystals are mapped to chakras and elements', () {
      expect(AltarCrystal.values.length, 6);
      for (final c in AltarCrystal.values) {
        expect(c.chakra.isNotEmpty, isTrue);
        expect(c.element.isNotEmpty, isTrue);
        expect(c.affirmation.isNotEmpty, isTrue);
      }
    });

    test('GridCorner cardinal lookups resolve correctly', () {
      expect(GridCorner.fromId('top_left'), GridCorner.topLeft);
      expect(GridCorner.fromId('topRight'), GridCorner.topRight);
      expect(GridCorner.fromId('bottom_left'), GridCorner.bottomLeft);
      expect(GridCorner.fromId('bottomRight'), GridCorner.bottomRight);
    });

    test('AltarCrystal.fromId handles invalid id safely', () {
      expect(AltarCrystal.fromId('amethyst'), AltarCrystal.amethyst);
      expect(AltarCrystal.fromId('unknown'), AltarCrystal.clearQuartz);
    });
  });

  group('AltarConsecrationState Tests', () {
    test('default state has 4 placed crystals and is unpurified', () {
      const state = AltarConsecrationState();
      expect(state.isPurified, isFalse);
      expect(state.purificationProgress, 0.0);
      expect(state.crystalAt(GridCorner.topLeft), AltarCrystal.clearQuartz);
      expect(state.crystalAt(GridCorner.topRight), AltarCrystal.amethyst);
      expect(state.crystalAt(GridCorner.bottomLeft), AltarCrystal.blackTourmaline);
      expect(state.crystalAt(GridCorner.bottomRight), AltarCrystal.citrine);
      expect(state.isFullyConsecrated, isFalse);
    });

    test('isFullyConsecrated becomes true when purified with 4 crystals', () {
      const state = AltarConsecrationState(isPurified: true);
      expect(state.isFullyConsecrated, isTrue);
      expect(state.summaryText, contains('Palo Santo smoke purification active'));
    });

    test('JSON serialization and deserialization preserves state', () {
      final state = AltarConsecrationState(
        activeHerb: SacredHerb.whiteSage,
        isPurified: true,
        purificationProgress: 1.0,
        placedCrystals: {
          'topLeft': 'amethyst',
          'topRight': 'clear_quartz',
        },
        lastPurifiedAt: DateTime.utc(2026, 10, 16, 12, 0, 0),
      );

      final json = state.toJson();
      final restored = AltarConsecrationState.fromJson(json);

      expect(restored.activeHerb, SacredHerb.whiteSage);
      expect(restored.isPurified, isTrue);
      expect(restored.crystalAt(GridCorner.topLeft), AltarCrystal.amethyst);
      expect(restored.crystalAt(GridCorner.topRight), AltarCrystal.clearQuartz);
      expect(restored.crystalAt(GridCorner.bottomLeft), isNull);
    });
  });

  group('AltarConsecrationNotifier Riverpod Tests', () {
    test('selectHerb updates active herb', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(altarConsecrationNotifierProvider.notifier);
      await notifier.selectHerb(SacredHerb.copalResin);

      expect(container.read(altarConsecrationNotifierProvider).activeHerb, SacredHerb.copalResin);
    });

    test('wafting progress increments and completes purification at 1.0', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(altarConsecrationNotifierProvider.notifier);
      expect(container.read(altarConsecrationNotifierProvider).isPurified, isFalse);

      notifier.addWaftingProgress(0.5);
      expect(container.read(altarConsecrationNotifierProvider).purificationProgress, 0.5);

      notifier.addWaftingProgress(0.6);
      expect(container.read(altarConsecrationNotifierProvider).isPurified, isTrue);
      expect(container.read(altarConsecrationNotifierProvider).purificationProgress, 1.0);
    });

    test('resetPurification resets status', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(altarConsecrationNotifierProvider.notifier);
      await notifier.completePurification();
      expect(container.read(altarConsecrationNotifierProvider).isPurified, isTrue);

      await notifier.resetPurification();
      expect(container.read(altarConsecrationNotifierProvider).isPurified, isFalse);
      expect(container.read(altarConsecrationNotifierProvider).purificationProgress, 0.0);
    });

    test('placeCrystal and removeCrystal modifies grid arrangement', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(altarConsecrationNotifierProvider.notifier);
      await notifier.placeCrystal(GridCorner.topLeft, AltarCrystal.roseQuartz);

      expect(
        container.read(altarConsecrationNotifierProvider).crystalAt(GridCorner.topLeft),
        AltarCrystal.roseQuartz,
      );

      await notifier.removeCrystal(GridCorner.topLeft);
      expect(
        container.read(altarConsecrationNotifierProvider).crystalAt(GridCorner.topLeft),
        isNull,
      );
    });
  });

  group('TarotRepository Altar Consecration Integration Tests', () {
    test('consultOracle passes altarConsecration to output', () async {
      final repo = TarotRepository();
      final dummyCard = TarotCard(
        id: 'the_magician',
        name: 'The Magician',
        arcana: 'Major Arcana',
        suit: 'Major',
        meaningUpright: 'Manifestation and sovereign willpower.',
        meaningReversed: 'Illusion and blocked channels.',
        element: 'Fire',
      );

      final result = await repo.consultOracle(
        question: 'Bless this altar',
        spreadType: SpreadType.dailyGuidance,
        drawnCards: [dummyCard],
        altarConsecration: 'Palo Santo smoke with Clear Quartz and Amethyst grid',
      );

      expect(result['altar_consecration'], contains('Palo Santo'));
      expect(result['interpretation'], isNotEmpty);
    });
  });
}
