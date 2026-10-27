import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/astrology/synastry/data/synastry_calculator.dart';
import 'package:tarot_app/features/astrology/synastry/data/synastry_service.dart';
import 'package:tarot_app/features/astrology/synastry/domain/lunar_synastry.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/screens/lunar_synastry_screen.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/widgets/elemental_matrix_view.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/widgets/synastry_aspect_card.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/widgets/synastry_harmony_gauge.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/widgets/synastry_partner_pod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Lunar Synastry Domain & Calculator Tests', () {
    test('SynastryCalculator.createPartner derives placements and soul card', () {
      final birthDate = DateTime(1995, 7, 15);
      final partner = SynastryCalculator.createPartner(
        name: 'Aurelia',
        birthDate: birthDate,
      );

      expect(partner.name, 'Aurelia');
      expect(partner.sunSign, 'Cancer');
      expect(partner.dominantElement, 'Water');
      expect(partner.soulCardNumber, inInclusiveRange(0, 21));
      expect(partner.soulCardName, isNotEmpty);
    });

    test('SynastryCalculator.calculateSynastry produces complete reading', () {
      final partnerA = SynastryCalculator.createPartner(
        name: 'Seeker',
        birthDate: DateTime(1996, 8, 8),
        sunSignOverride: 'Leo',
        moonSignOverride: 'Aries',
      );

      final partnerB = SynastryCalculator.createPartner(
        name: 'Beloved',
        birthDate: DateTime(1998, 12, 12),
        sunSignOverride: 'Sagittarius',
        moonSignOverride: 'Leo',
      );

      final reading = SynastryCalculator.calculateSynastry(
        partnerA: partnerA,
        partnerB: partnerB,
      );

      expect(reading.compatibilityScore, inInclusiveRange(60, 100));
      expect(reading.bondTitle, isNotEmpty);
      expect(reading.relationshipArchetype, isNotEmpty);
      expect(reading.elementalConfluence, contains('Fire'));
      expect(reading.elementalBalancePercent, inInclusiveRange(0.0, 1.0));
      expect(reading.aspects.length, 4);

      // Verify Sun-Moon aspect
      final sunMoonAspect = reading.aspects.first;
      expect(sunMoonAspect.placementA, contains('Leo'));
      expect(sunMoonAspect.placementB, contains('Leo'));
      expect(sunMoonAspect.aspectType, contains('Conjunction'));
      expect(sunMoonAspect.harmonyStars, 5);
      expect(sunMoonAspect.tarotTalisman, contains('The Sun'));

      // Verify channels
      expect(reading.karmicLesson, isNotEmpty);
      expect(reading.soulChallenge, isNotEmpty);
      expect(reading.sacredRitual, isNotEmpty);
      expect(reading.oracleProphecy, contains(partnerA.name));
      expect(reading.oracleProphecy, contains(partnerB.name));
    });

    test('SynastryService and Presets are valid', () {
      expect(SynastryPreset.allPresets.length, 4);

      const service = SynastryService();
      for (final preset in SynastryPreset.allPresets) {
        expect(preset.name, isNotEmpty);
        expect(preset.glyph, isNotEmpty);
        final reading = service.scryConnection(
          partnerA: preset.partnerA,
          partnerB: preset.partnerB,
        );
        expect(reading.compatibilityScore, inInclusiveRange(60, 100));

        final altarIntention = service.createAltarIntention(reading);
        expect(altarIntention, contains('harmonize'));
        expect(altarIntention, contains(preset.partnerA.name));
        expect(altarIntention, contains(preset.partnerB.name));
      }
    });
  });

  group('Lunar Synastry Widgets Tests', () {
    testWidgets('SynastryHarmonyGauge renders animated orbital score and titles', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SynastryHarmonyGauge(
              score: 94,
              bondTitle: 'The Celestial Twin Flame Conjunction',
              relationshipArchetype: 'Alchemical Sovereign Union',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('94%'), findsOneWidget);
      expect(find.text('HARMONY'), findsOneWidget);
      expect(find.text('The Celestial Twin Flame Conjunction'), findsOneWidget);
      expect(find.text('ALCHEMICAL SOVEREIGN UNION'), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('ElementalMatrixView renders elemental badges and narrative', (tester) async {
      final partnerA = SynastryCalculator.createPartner(
        name: 'Seeker',
        birthDate: DateTime(1994, 11, 4),
        sunSignOverride: 'Scorpio',
      );
      final partnerB = SynastryCalculator.createPartner(
        name: 'Beloved',
        birthDate: DateTime(1995, 7, 7),
        sunSignOverride: 'Cancer',
      );
      final reading = SynastryCalculator.calculateSynastry(
        partnerA: partnerA,
        partnerB: partnerB,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElementalMatrixView(reading: reading),
          ),
        ),
      );

      expect(find.text('WATER & WATER CONFLUENCE'), findsOneWidget);
      expect(find.text(reading.elementalDynamic), findsOneWidget);
      expect(find.text('Seeker'), findsOneWidget);
      expect(find.text('Beloved'), findsOneWidget);
    });

    testWidgets('SynastryAspectCard renders aspect metadata and talisman', (tester) async {
      const aspect = SynastryAspect(
        title: 'Golden Alchemical Union',
        placementA: 'Seeker Sun in Leo',
        placementB: 'Beloved Moon in Aries',
        aspectType: 'Trine (120°)',
        harmonyStars: 5,
        dynamicDescription: 'A divine meeting of conscious warmth and instinctive passion.',
        tarotTalisman: 'XIX. The Sun & II. The High Priestess',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SynastryAspectCard(aspect: aspect),
          ),
        ),
      );

      expect(find.text('Golden Alchemical Union'), findsOneWidget);
      expect(find.text('Trine (120°)'), findsOneWidget);
      expect(find.text('Seeker Sun in Leo'), findsOneWidget);
      expect(find.text('Beloved Moon in Aries'), findsOneWidget);
      expect(find.text('Tarot Talisman: XIX. The Sun & II. The High Priestess'), findsOneWidget);
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(5));
    });

    testWidgets('SynastryPartnerPod renders partner information and picker triggers', (tester) async {
      final partner = SynastryCalculator.createPartner(
        name: 'Hermione',
        birthDate: DateTime(1998, 9, 19),
        sunSignOverride: 'Virgo',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SynastryPartnerPod(
              podLabel: 'Partner B',
              partner: partner,
              onBirthDateChanged: (_) {},
              onSunSignChanged: (_) {},
              onNameChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('PARTNER B'), findsOneWidget);
      expect(find.text('Hermione'), findsOneWidget);
      expect(find.text('Sun: Virgo'), findsOneWidget);
      expect(find.text('1998-09-19'), findsOneWidget);
      expect(find.textContaining('Soul Card:'), findsOneWidget);
    });

    testWidgets('LunarSynastryScreen renders full view and anchors intention to altar', (tester) async {
      tester.view.physicalSize = const Size(800, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LunarSynastryScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('LUNAR SYNASTRY'), findsOneWidget);
      expect(find.text('ARCHETYPAL PRESETS'), findsOneWidget);
      expect(find.text('SCRY CELESTIAL SYNASTRY'), findsOneWidget);
      expect(find.byType(SynastryPartnerPod), findsNWidgets(2));
      expect(find.byType(SynastryHarmonyGauge), findsOneWidget);
      expect(find.byType(ElementalMatrixView), findsOneWidget);
      expect(find.text('✦ ANCHOR SYNASTRY TO ALTAR ✦'), findsOneWidget);

      // Tap Anchor button
      await tester.tap(find.text('✦ ANCHOR SYNASTRY TO ALTAR ✦'), warnIfMissed: false);
      await tester.pump();
    });
  });
}
