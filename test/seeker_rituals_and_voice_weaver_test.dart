import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/core/services/celestial_voice_service.dart';
import 'package:tarot_app/features/altar/domain/seeker_ritual_spell.dart';
import 'package:tarot_app/features/altar/presentation/notifiers/custom_ritual_notifier.dart';
import 'package:tarot_app/features/altar/presentation/widgets/custom_ritual_forge_modal.dart';
import 'package:tarot_app/features/sanctuary/data/sanctum_catalog.dart';
import 'package:tarot_app/features/sanctuary/domain/sanctum_item.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Dual-Frequency Celestial Voice Weaver Tests', () {
    test('CelestialVoiceChannel enum parameters are acoustically calibrated', () {
      expect(CelestialVoiceChannel.solar.pitch, 0.82);
      expect(CelestialVoiceChannel.solar.speechRate, 0.44);
      expect(CelestialVoiceChannel.solar.glyph, '☀️');
      expect(CelestialVoiceChannel.solar.title, 'Solar Voice');

      expect(CelestialVoiceChannel.lunar.pitch, 1.18);
      expect(CelestialVoiceChannel.lunar.speechRate, 0.38);
      expect(CelestialVoiceChannel.lunar.glyph, '🌙');
      expect(CelestialVoiceChannel.lunar.title, 'Lunar Voice');

      expect(CelestialVoiceChannel.alchemical.pitch, 0.98);
      expect(CelestialVoiceChannel.alchemical.speechRate, 0.40);
      expect(CelestialVoiceChannel.alchemical.glyph, '⚡');
      expect(CelestialVoiceChannel.alchemical.title, 'Alchemical Conjunction');
    });

    test('CelestialVoiceService activeChannel initialization and callbacks', () {
      final service = CelestialVoiceService.instance;
      expect(service.activeChannel, isNull);
      expect(service.isPlaying, isFalse);

      CelestialVoiceChannel? reportedChannel;
      service.onChannelChanged = (channel) {
        reportedChannel = channel;
      };

      service.onChannelChanged?.call(CelestialVoiceChannel.solar);
      expect(reportedChannel, CelestialVoiceChannel.solar);

      service.onChannelChanged?.call(CelestialVoiceChannel.alchemical);
      expect(reportedChannel, CelestialVoiceChannel.alchemical);
    });
  });

  group('Seeker Rituals & Consecration Spells Domain Tests', () {
    test('RitualActionType has comprehensive esoteric metadata', () {
      for (final type in RitualActionType.values) {
        expect(type.glyph.isNotEmpty, isTrue);
        expect(type.title.isNotEmpty, isTrue);
      }
      expect(RitualActionType.values.length, 7);
      expect(RitualActionType.values, contains(RitualActionType.riffleShuffle));
      expect(RitualActionType.values, contains(RitualActionType.celticScatter));
      expect(RitualActionType.values, contains(RitualActionType.threePilesCut));
      expect(RitualActionType.values, contains(RitualActionType.herbSmoke));
      expect(RitualActionType.values, contains(RitualActionType.crystalGrid));
      expect(RitualActionType.values, contains(RitualActionType.sacredBreath));
      expect(RitualActionType.values, contains(RitualActionType.intentionAnchor));
    });

    test('Curated Presets are complete and properly configured', () {
      expect(SeekerRitualSpell.curatedSpells.length, 4);

      final hermetic = SeekerRitualSpell.curatedSpells.firstWhere((s) => s.id == 'hermetic_solfeggio');
      expect(hermetic.name, contains('Hermetic Solfeggio'));
      expect(hermetic.isCurated, isTrue);
      expect(hermetic.steps.length, 4);
      expect(hermetic.totalDurationSeconds, 3 + 4 + 3 + 2);

      final twinFlame = SeekerRitualSpell.curatedSpells.firstWhere((s) => s.id == 'twin_flame_consecration');
      expect(twinFlame.name, contains('Twin Flame'));
      expect(twinFlame.steps.length, 4);

      final shadow = SeekerRitualSpell.curatedSpells.firstWhere((s) => s.id == 'full_moon_shadow_dissolution');
      expect(shadow.name, contains('Full Moon'));
      expect(shadow.steps.length, 4);

      final solar = SeekerRitualSpell.curatedSpells.firstWhere((s) => s.id == 'morning_solar_ignition');
      expect(solar.name, contains('Morning Solar'));
      expect(solar.steps.length, 3);
    });

    test('SeekerRitualSpell JSON serialization round-trip', () {
      final original = SeekerRitualSpell.curatedSpells.first;
      final encoded = jsonEncode(original.toJson());
      final jsonMap = jsonDecode(encoded) as Map<String, dynamic>;
      final revived = SeekerRitualSpell.fromJson(jsonMap);

      expect(revived.id, original.id);
      expect(revived.name, original.name);
      expect(revived.description, original.description);
      expect(revived.steps.length, original.steps.length);
      expect(revived.totalDurationSeconds, original.totalDurationSeconds);
    });
  });

  group('CustomRitualNotifier State Management Tests', () {
    test('Initializes with curated presets and default active state', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(customRitualProvider);
      expect(state.allSpells.length, greaterThanOrEqualTo(4));
      expect(state.activeRunningSpell, isNull);
      expect(state.isRunning, isFalse);
      expect(state.activeStepIndex, 0);
    });

    test('Starts spell execution and advances through steps to completion', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(customRitualProvider.notifier);
      final shadowSpell = SeekerRitualSpell.curatedSpells.firstWhere((s) => s.id == 'full_moon_shadow_dissolution');

      notifier.startSpellExecution(shadowSpell);
      var state = container.read(customRitualProvider);
      expect(state.isRunning, isTrue);
      expect(state.activeRunningSpell?.id, shadowSpell.id);
      expect(state.activeStepIndex, 0);
      expect(state.currentStep?.id, shadowSpell.steps.first.id);

      // Advance through all steps
      for (int i = 0; i < shadowSpell.steps.length - 1; i++) {
        notifier.advanceStep();
      }
      state = container.read(customRitualProvider);
      expect(state.activeStepIndex, shadowSpell.steps.length - 1);
      expect(state.isRunning, isTrue);

      // Completes on last advance
      notifier.advanceStep();
      state = container.read(customRitualProvider);
      expect(state.isRunning, isFalse);
      expect(state.isCompleted, isTrue);
    });

    test('Creates and deletes custom ritual spell', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(customRitualProvider.notifier);
      final customSpell = SeekerRitualSpell(
        id: 'spell_test_custom_001',
        name: 'Custom Astral Weaver',
        description: 'Testing custom creation and persistence',
        glyph: '🔮',
        accentColorHex: '#9B51E0',
        isCurated: false,
        createdAt: DateTime(2026, 1, 1),
        steps: const [
          RitualSpellStep(
            id: 'step_custom_1',
            actionType: RitualActionType.sacredBreath,
            title: 'Pranayama Gateway',
            subtitle: 'Breathe the infinite void',
            glyph: '🫁',
            parameter: '4-7-8',
            durationSeconds: 15,
          ),
        ],
      );

      await notifier.saveCustomSpell(customSpell);
      var state = container.read(customRitualProvider);
      expect(state.allSpells.any((s) => s.id == customSpell.id), isTrue);

      await notifier.deleteCustomSpell(customSpell.id);
      state = container.read(customRitualProvider);
      expect(state.allSpells.any((s) => s.id == customSpell.id), isFalse);
    });
  });

  group('SanctumCatalog Registration Tests', () {
    test('sanctuary_ritual_forge is registered under SanctumCategory.inner', () {
      final item = SanctumCatalog.allSanctuaries.firstWhere(
        (s) => s.id == 'sanctuary_ritual_forge',
      );
      expect(item.title, 'Seeker Rituals & Consecration Spells');
      expect(item.category, SanctumCategory.inner);
      expect(item.badgeText, 'RITUAL FORGE');
      expect(item.iconGlyph, '📜');
      expect(item.searchKeywords, contains('consecration'));
    });
  });

  group('CustomRitualForgeModal Widget Tests', () {
    testWidgets('Renders curated presets list in modal bottom sheet', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => CustomRitualForgeModal.show(context),
                  child: const Text('OPEN FORGE'),
                ),
              ),
            ),
          ),
        ),
      );

      // Open the modal
      await tester.tap(find.text('OPEN FORGE'));
      await tester.pumpAndSettle();

      // Verify header and tabs exist
      expect(find.text('SACRED RITUAL SPELL FORGE'), findsOneWidget);
      expect(find.text('RITUAL SPELLS'), findsOneWidget);
      expect(find.text('FORGE NEW SPELL'), findsOneWidget);

      // Verify curated presets are displayed
      expect(find.text('Hermetic Solfeggio Attunement'), findsOneWidget);
      expect(find.text('Twin Flame Sol-Luna Consecration'), findsOneWidget);
      expect(find.text('Full Moon Shadow Dissolution'), findsOneWidget);
      expect(find.text('Morning Solar Ignition Spell'), findsOneWidget);
    });
  });
}
