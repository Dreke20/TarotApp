import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/core/services/mystic_performance_service.dart';
import 'package:tarot_app/features/astrology/domain/natal_chart.dart';
import 'package:tarot_app/features/astrology/transit/data/celestial_transit_calculator.dart';
import 'package:tarot_app/features/astrology/transit/domain/celestial_transit.dart';
import 'package:tarot_app/features/astrology/transit/presentation/notifiers/celestial_transit_notifier.dart';
import 'package:tarot_app/features/astrology/transit/presentation/screens/celestial_transit_screen.dart';
import 'package:tarot_app/features/astrology/transit/presentation/widgets/celestial_wheel_painter.dart';
import 'package:tarot_app/features/tarot/data/audio_reflection_service.dart';
import 'package:tarot_app/features/tarot/data/card_synergy_service.dart';
import 'package:tarot_app/features/tarot/data/tarot_card_data.dart';
import 'package:tarot_app/features/tarot/domain/audio_reflection.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/alchemical_crucible_modal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Option 1: Celestial Transit Scrying & Ephemeris Calculator Tests', () {
    test('Calculates current planetary hour with Chaldean sequence', () {
      final now = DateTime(2026, 10, 24, 14, 30); // 2:30 PM
      final hour = CelestialTransitCalculator.calculateCurrentPlanetaryHour(now);

      expect(hour.planetName.isNotEmpty, isTrue);
      expect(hour.planetGlyph.isNotEmpty, isTrue);
      expect(hour.rulingElement.isNotEmpty, isTrue);
      expect(hour.consecrationMantra.isNotEmpty, isTrue);
      expect(hour.hourIndex, inInclusiveRange(1, 12));
    });

    test('Calculates real-time transiting celestial bodies for all classical planets', () {
      final now = DateTime(2026, 10, 24, 12, 0);
      final snapshot = CelestialTransitCalculator.calculateSnapshot(date: now);
      final bodies = snapshot.bodies;

      expect(bodies.length, 7);
      final names = bodies.map((b) => b.name).toList();
      expect(names, containsAll(['Sun', 'Moon', 'Mercury', 'Venus', 'Mars', 'Jupiter', 'Saturn']));

      final sun = bodies.firstWhere((b) => b.name == 'Sun');
      expect(sun.glyph, '☉');
      expect(sun.tarotArchetype, 'XIX. The Sun');
      expect(sun.degree, inInclusiveRange(0, 30));

      final moon = bodies.firstWhere((b) => b.name == 'Moon');
      expect(moon.glyph, '☽');
      expect(moon.tarotArchetype, 'XVIII. The Moon');
    });

    test('Derives transit-to-natal aspects matching tight orbs', () {
      final now = DateTime(2026, 10, 24, 12, 0);
      final natal = NatalChart(
        sunSign: 'Scorpio',
        moonSign: 'Taurus',
        risingSign: 'Sagittarius',
        placements: [
          const PlanetPlacement(
            planet: 'Sun',
            symbol: '☉',
            sign: 'Scorpio',
            element: 'Water',
            house: '1st House',
            meaning: 'Core Self',
            tarotCorrelation: 'XIX The Sun',
          ),
          const PlanetPlacement(
            planet: 'Moon',
            symbol: '☽',
            sign: 'Taurus',
            element: 'Earth',
            house: '7th House',
            meaning: 'Emotional Mirror',
            tarotCorrelation: 'II The High Priestess',
          ),
        ],
        firePercent: 20.0,
        earthPercent: 30.0,
        airPercent: 20.0,
        waterPercent: 30.0,
        dominantElement: 'Water',
        soulArchetype: 'The High Priestess',
      );

      final snapshot = CelestialTransitCalculator.calculateSnapshot(
        date: now,
        seekerNatalChart: natal,
      );

      expect(snapshot.aspects, isA<List<TransitAspect>>());
      for (final aspect in snapshot.aspects) {
        expect(aspect.aspectType.isNotEmpty, isTrue);
        expect(aspect.orbDegrees, lessThanOrEqualTo(8.0));
        expect(aspect.channelingGuidance.isNotEmpty, isTrue);
      }
    });

    test('CelestialTransitNotifier initializes and updates state cleanly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final snapshot = container.read(celestialTransitProvider);
      expect(snapshot.bodies.length, 7);
      expect(snapshot.planetaryHour.planetName.isNotEmpty, isTrue);

      container.read(celestialTransitProvider.notifier).refreshTransit();
      final refreshed = container.read(celestialTransitProvider);
      expect(refreshed.bodies.length, 7);
    });

    testWidgets('CelestialWheelPainter custom canvas paints without exceptions', (tester) async {
      final now = DateTime(2026, 10, 24, 12, 0);
      final snapshot = CelestialTransitCalculator.calculateSnapshot(date: now);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 320,
                height: 320,
                child: CustomPaint(
                  painter: CelestialWheelPainter(
                    transitingBodies: snapshot.bodies,
                    animationProgress: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('CelestialTransitScreen mounts planetary hour and wheel in UI', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CelestialTransitScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('CELESTIAL TRANSITS'), findsOneWidget);
      expect(find.textContaining('HOUR OF'), findsOneWidget);
      expect(find.text('ANCHOR TRANSIT TO ALTAR'), findsOneWidget);
      expect(find.text('PERSONAL TRANSIT-TO-NATAL ASPECTS'), findsOneWidget);
    });
  });

  group('Option 2: Dual-Card Elemental Crucible & Synergy Tests', () {
    test('CardSynergyService accurately calculates elemental confluence & chemical dignity', () {
      final card1 = TarotCardData.allCards.firstWhere((c) => c.name == 'The Magician');
      final card2 = TarotCardData.allCards.firstWhere((c) => c.name == 'The High Priestess');

      final synergy = CardSynergyService.synthesize(card1, card2);
      expect(synergy.alchemicalTitle.isNotEmpty, isTrue);
      expect(synergy.alchemicalPhase.isNotEmpty, isTrue);
      expect(synergy.synthesisInsight.isNotEmpty, isTrue);
      expect(synergy.elementalReaction.isNotEmpty, isTrue);
      expect(synergy.harmonyScore, inInclusiveRange(0, 100));
    });

    testWidgets('AlchemicalCrucibleModal mounts 2 cards and interactive cauldron', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final card1 = TarotCardData.allCards[0];
      final card2 = TarotCardData.allCards[1];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: AlchemicalCrucibleModal(drawnCards: [card1, card2]),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('ALCHEMICAL CRUCIBLE'), findsOneWidget);
      expect(find.text('☀️ PRIMA'), findsOneWidget);
      expect(find.text('🌙 SECUNDA'), findsOneWidget);
      expect(find.text('✦ HEAR ALCHEMICAL CONJUNCTION ✦'), findsOneWidget);
      expect(find.text('ELEMENTAL CONFLUENCE'), findsOneWidget);
    });
  });

  group('Option 3: Seeker Audio Reflections & Audio Grimoire Tests', () {
    test('AudioReflection JSON serialization round-trip', () {
      final reflection = AudioReflection(
        id: 'voice_ref_101',
        readingId: 'reading_test_999',
        durationSeconds: 42,
        waveformSamples: [0.1, 0.4, 0.8, 0.95, 0.6, 0.3, 0.1],
        transcription: 'I felt a sudden shift when the Tower appeared in reverse.',
        recordedAt: DateTime(2026, 10, 24, 3, 0),
      );

      final encoded = jsonEncode(reflection.toJson());
      final jsonMap = jsonDecode(encoded) as Map<String, dynamic>;
      final revived = AudioReflection.fromJson(jsonMap);

      expect(revived.id, reflection.id);
      expect(revived.readingId, reflection.readingId);
      expect(revived.durationSeconds, 42);
      expect(revived.waveformSamples.length, 7);
      expect(revived.transcription, contains('shift when the Tower appeared'));
    });

    test('AudioReflectionService persists, queries, and deletes reflections in storage', () async {
      final service = AudioReflectionService.instance;
      final reflection = AudioReflection(
        id: 'voice_ref_202',
        readingId: 'reading_alpha_7',
        durationSeconds: 28,
        waveformSamples: [0.2, 0.5, 0.7, 0.3],
        transcription: 'A reflection upon the Ace of Cups.',
        recordedAt: DateTime.now(),
      );

      await service.saveReflection(reflection);

      final retrieved = await service.getReflectionForReading('reading_alpha_7');
      expect(retrieved, isNotNull);
      expect(retrieved!.id, 'voice_ref_202');
      expect(retrieved.durationSeconds, 28);
      expect(retrieved.transcription, 'A reflection upon the Ace of Cups.');

      // Test waveform sample generation
      final samples = AudioReflectionService.generateWaveformSamples(24);
      expect(samples.length, 24);
      for (final s in samples) {
        expect(s, inInclusiveRange(0.15, 1.0));
      }

      await service.deleteReflection('reading_alpha_7');
      final afterDelete = await service.getReflectionForReading('reading_alpha_7');
      expect(afterDelete, isNull);
    });
  });

  group('Option 4: Mystic Eco Saver & Performance Engine Tests', () {
    test('MysticPerformanceNotifier defaults to high fidelity settings', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initial = container.read(mysticPerformanceProvider);
      expect(initial.isBatterySaverEnabled, isFalse);
      expect(initial.maxParticleCount, 60);
      expect(initial.enableHolographicSensors, isTrue);
      expect(initial.enableGpuParticleDrift, isTrue);
    });

    test('MysticPerformanceNotifier toggles battery saver mode and throttles engine', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mysticPerformanceProvider.notifier);
      notifier.toggleBatterySaver();

      final ecoState = container.read(mysticPerformanceProvider);
      expect(ecoState.isBatterySaverEnabled, isTrue);
      expect(ecoState.maxParticleCount, 16);
      expect(ecoState.enableHolographicSensors, isFalse);
      expect(ecoState.enableGpuParticleDrift, isFalse);

      notifier.toggleBatterySaver();
      final restoredState = container.read(mysticPerformanceProvider);
      expect(restoredState.isBatterySaverEnabled, isFalse);
      expect(restoredState.maxParticleCount, 60);
      expect(restoredState.enableHolographicSensors, isTrue);
      expect(restoredState.enableGpuParticleDrift, isTrue);
    });

    test('MysticPerformanceNotifier allows explicit setBatterySaver', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mysticPerformanceProvider.notifier);
      notifier.setBatterySaver(true);

      final ecoState = container.read(mysticPerformanceProvider);
      expect(ecoState.isBatterySaverEnabled, isTrue);
      expect(ecoState.maxParticleCount, 16);
      expect(ecoState.enableHolographicSensors, isFalse);
      expect(ecoState.enableGpuParticleDrift, isFalse);
    });
  });
}
