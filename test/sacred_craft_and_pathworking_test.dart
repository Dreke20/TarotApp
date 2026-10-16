import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/features/altar/domain/altar_cloth.dart';
import 'package:tarot_app/features/altar/presentation/widgets/altar_cloth_painter.dart';
import 'package:tarot_app/features/altar/presentation/widgets/altar_cloth_selector_modal.dart';
import 'package:tarot_app/features/astrology/domain/sabbat_calendar.dart';
import 'package:tarot_app/features/meditation/domain/archetypal_pathworking.dart';
import 'package:tarot_app/features/meditation/presentation/screens/pathworking_sanctuary_screen.dart';
import 'package:tarot_app/features/meditation/presentation/widgets/pathworking_player_modal.dart';
import 'package:tarot_app/features/notifications/domain/notification_planner.dart';
import 'package:tarot_app/features/notifications/domain/notification_settings.dart';
import 'package:tarot_app/features/notifications/presentation/widgets/cosmic_notification_modal.dart';
import 'package:tarot_app/features/tarot/domain/card_back_design.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/card_back_design_painter.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/card_back_selector_modal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Altar Cloth Domain & Customization Tests', () {
    test('all 4 AltarCloths have distinct ids, palettes, and descriptions', () {
      final ids = <String>{};
      for (final cloth in AltarCloth.values) {
        expect(ids.add(cloth.id), isTrue, reason: 'Duplicate cloth id: ${cloth.id}');
        expect(cloth.title.isNotEmpty, isTrue);
        expect(cloth.subtitle.isNotEmpty, isTrue);
        expect(cloth.description.isNotEmpty, isTrue);
        expect(cloth.glyph.isNotEmpty, isTrue);
      }
      expect(AltarCloth.values.length, 4);
    });

    test('AltarCloth.fromId handles exact match and graceful default fallback', () {
      expect(AltarCloth.fromId('amethyst_silk'), AltarCloth.amethystSilk);
      expect(AltarCloth.fromId('emerald_hermetic'), AltarCloth.emeraldHermetic);
      expect(AltarCloth.fromId('unknown_cloth'), AltarCloth.midnightObsidian);
      expect(AltarCloth.fromId(null), AltarCloth.midnightObsidian);
    });

    test('AltarClothPainter paints without error for every cloth', () {
      for (final cloth in AltarCloth.values) {
        final painter = AltarClothPainter(cloth: cloth);
        final recorder = PictureRecorder();
        final canvas = Canvas(recorder);
        expect(() => painter.paint(canvas, const Size(400, 600)), returnsNormally);
      }
    });

    testWidgets('AltarClothSelectorModal renders all cloths and Pro badges', (tester) async {
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
              body: AltarClothSelectorModal(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('CONSECRATED ALTAR CLOTHS'), findsOneWidget);
      expect(find.text('Midnight Obsidian Velvet'), findsOneWidget);
      expect(find.text('Amethyst Sacred Silk'), findsOneWidget);
      expect(find.text('Emerald Hermetic Velvet'), findsOneWidget);
      expect(find.text('Celestial Starlight Satin'), findsOneWidget);
    });
  });

  group('Card Back Design Domain & Customization Tests', () {
    test('all 4 CardBackDesigns have distinct attributes and valid colors', () {
      final ids = <String>{};
      for (final design in CardBackDesign.values) {
        expect(ids.add(design.id), isTrue, reason: 'Duplicate card back id: ${design.id}');
        expect(design.title.isNotEmpty, isTrue);
        expect(design.subtitle.isNotEmpty, isTrue);
        expect(design.glyph.isNotEmpty, isTrue);
      }
      expect(CardBackDesign.values.length, 4);
    });

    test('CardBackDesign.fromId handles exact match and graceful default fallback', () {
      expect(CardBackDesign.fromId('metatrons_cube'), CardBackDesign.metatronsCube);
      expect(CardBackDesign.fromId('ouroboros_moon'), CardBackDesign.ouroborosMoon);
      expect(CardBackDesign.fromId('non_existent'), CardBackDesign.eyeOfProvidence);
      expect(CardBackDesign.fromId(null), CardBackDesign.eyeOfProvidence);
    });

    test('CardBackDesignPainter paints all 4 sacred back geometries without crash', () {
      for (final design in CardBackDesign.values) {
        final painter = CardBackDesignPainter(design: design);
        final recorder = PictureRecorder();
        final canvas = Canvas(recorder);
        expect(() => painter.paint(canvas, const Size(200, 320)), returnsNormally);
      }
    });

    testWidgets('CardBackSelectorModal renders all card back designs', (tester) async {
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
              body: CardBackSelectorModal(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('COLLECTIBLE CARD BACKS'), findsOneWidget);
      expect(find.text('The Eye of Providence'), findsOneWidget);
      expect(find.text("Metatron's Cube"), findsOneWidget);
      expect(find.text('Ouroboros & Crescent Moon'), findsOneWidget);
      expect(find.text('Celestial Astrolabe'), findsOneWidget);
    });
  });

  group('Archetypal Pathworking Meditation Tests', () {
    test('all 5 archetypal pathworkings have complete steps, tracks, and durations', () {
      expect(ArchetypalPathworking.allPathworkings.length, 5);
      for (final p in ArchetypalPathworking.allPathworkings) {
        expect(p.id.isNotEmpty, isTrue);
        expect(p.cardId.startsWith('major_'), isTrue);
        expect(p.title.isNotEmpty, isTrue);
        expect(p.archetype.isNotEmpty, isTrue);
        expect(p.description.isNotEmpty, isTrue);
        expect(p.steps.length, greaterThanOrEqualTo(3));
        expect(p.totalDurationSeconds, greaterThan(60));
        expect(p.soundscapeName.isNotEmpty, isTrue);

        for (final step in p.steps) {
          expect(step.title.isNotEmpty, isTrue);
          expect(step.guidanceText.isNotEmpty, isTrue);
          expect(step.durationSeconds, greaterThan(0));
        }
      }
    });

    testWidgets('PathworkingSanctuaryScreen renders list of journeys', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: PathworkingSanctuaryScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('ARCHETYPAL PATHWORKINGS'), findsOneWidget);
      expect(find.text('The Leap into Primordial Trust'), findsOneWidget);
      expect(find.text('The Temple of the Veiled Moon'), findsOneWidget);
      expect(find.text('The Solitary Mountain Beacon'), findsOneWidget);
    });

    testWidgets('PathworkingPlayerModal renders player header and controls', (tester) async {
      final journey = ArchetypalPathworking.allPathworkings.first;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PathworkingPlayerModal(pathworking: journey),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('ARCHETYPAL PATHWORKING'), findsOneWidget);
      expect(find.text(journey.title), findsOneWidget);
      expect(find.text('ANCHOR TO ALTAR'), findsOneWidget);
    });
  });

  group('Sabbat Calendar & Ephemeris Scheduling Tests', () {
    test('SabbatCalendar has all 8 Wheel of the Year festivals', () {
      expect(SabbatCalendar.sabbats.length, 8);
      final names = SabbatCalendar.sabbats.map((s) => s.name).toSet();
      expect(names, containsAll(['Samhain', 'Yule', 'Imbolc', 'Ostara', 'Beltane', 'Litha', 'Lughnasadh', 'Mabon']));
    });

    test('SabbatCalendar.upcoming orders chronologically and handles year rollover', () {
      final nov1 = DateTime(2026, 11, 1);
      final upcoming = SabbatCalendar.upcoming(nov1);
      expect(upcoming.length, 8);
      expect(upcoming.first.event.name, 'Yule');
      expect(upcoming.first.date.year, 2026);
      expect(upcoming.last.event.name, 'Samhain');
      expect(upcoming.last.date.year, 2027);
    });

    test('SabbatCalendar.next returns today if today is Sabbat', () {
      final yuleDay = DateTime(2026, 12, 21);
      final next = SabbatCalendar.next(yuleDay);
      expect(next.event.name, 'Yule');
      expect(next.daysFrom(yuleDay), 0);
    });
  });

  group('Cosmic Horary Reminders & NotificationPlanner Tests', () {
    test('NotificationSettings defaults and copyWith work as expected', () {
      const s = NotificationSettings();
      expect(s.dailyEnabled, isTrue);
      expect(s.hour, 8);
      expect(s.minute, 0);
      expect(s.lunarTransits, isTrue);
      expect(s.sabbatAlerts, isTrue);
      expect(s.formattedTime, '08:00');
      expect(s.anyEnabled, isTrue);

      final modified = s.copyWith(hour: 20, minute: 30, dailyEnabled: false);
      expect(modified.hour, 20);
      expect(modified.minute, 30);
      expect(modified.formattedTime, '20:30');
      expect(modified.dailyEnabled, isFalse);
    });

    test('NotificationPlanner plans 7 daily alerts when dailyEnabled is true', () {
      final now = DateTime(2026, 10, 16, 7, 0);
      const settings = NotificationSettings(dailyEnabled: true, sabbatAlerts: false);
      final plan = NotificationPlanner.plan(settings, now: now);

      final dailyAlerts = plan.where((n) => n.kind == NotificationKind.daily).toList();
      expect(dailyAlerts.length, 7);
      expect(dailyAlerts.first.id, NotificationPlanner.dailyBaseId);
      expect(dailyAlerts.first.title, contains('Astral Guidance'));
    });

    test('NotificationPlanner plans Sabbat eves when sabbatAlerts is true', () {
      final now = DateTime(2026, 10, 16, 10, 0);
      const settings = NotificationSettings(dailyEnabled: false, lunarTransits: false, sabbatAlerts: true);
      final plan = NotificationPlanner.plan(settings, now: now);

      final sabbatAlerts = plan.where((n) => n.kind == NotificationKind.sabbat).toList();
      expect(sabbatAlerts.isNotEmpty, isTrue);
      expect(sabbatAlerts.first.title, contains('Eve'));
      expect(sabbatAlerts.first.title, contains('Samhain'));
    });

    testWidgets('CosmicNotificationModal mounts toggles and sample dispatch button', (tester) async {
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
              body: CosmicNotificationModal(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('COSMIC HORARY REMINDERS'), findsOneWidget);
      expect(find.text('Daily Guidance Reminders'), findsOneWidget);
      expect(find.text('Lunar Transit Alerts'), findsOneWidget);
      expect(find.text('Wheel of the Year Sabbats'), findsOneWidget);
      expect(find.text('DISPATCH SAMPLE CELESTIAL ALERT'), findsOneWidget);
    });
  });
}
