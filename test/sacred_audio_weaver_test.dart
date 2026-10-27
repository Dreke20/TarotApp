import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/audio_weaver/domain/sound_layer.dart';
import 'package:tarot_app/features/audio_weaver/presentation/notifiers/sound_weaver_state.dart';
import 'package:tarot_app/features/audio_weaver/presentation/widgets/frequency_visualizer_wave.dart';
import 'package:tarot_app/features/audio_weaver/presentation/widgets/layer_fader_card.dart';
import 'package:tarot_app/features/audio_weaver/presentation/widgets/sacred_audio_weaver_modal.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/ambient_audio_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Sacred Audio Weaver Domain & Models', () {
    test('SoundLayerTrack definitions and categorization', () {
      final freqs = SoundLayerTrack.forCategory(SoundLayerCategory.frequency);
      final insts = SoundLayerTrack.forCategory(SoundLayerCategory.instrument);
      final nats = SoundLayerTrack.forCategory(SoundLayerCategory.nature);

      expect(freqs.length, 4);
      expect(insts.length, 3);
      expect(nats.length, 3);
      expect(SoundLayerTrack.allTracks.length, 10);

      // Verify Solfeggio 432 Hz and 528 Hz
      final f432 = freqs.firstWhere((t) => t.id == 'freq_432');
      expect(f432.hz, '432 Hz');
      expect(f432.title, 'Cosmic Harmony');
      expect(f432.assetPath, contains('432'));

      final f528 = freqs.firstWhere((t) => t.id == 'freq_528');
      expect(f528.hz, '528 Hz');
      expect(f528.title, 'Miracles & Heart');
    });

    test('SoundPreset configurations are coherent and bounded', () {
      expect(SoundPreset.allPresets.length, 4);

      for (final preset in SoundPreset.allPresets) {
        expect(preset.frequencyVolume, inInclusiveRange(0.0, 1.0));
        expect(preset.instrumentVolume, inInclusiveRange(0.0, 1.0));
        expect(preset.natureVolume, inInclusiveRange(0.0, 1.0));
        expect(preset.frequencyTrack.category, SoundLayerCategory.frequency);
        expect(preset.instrumentTrack.category, SoundLayerCategory.instrument);
        expect(preset.natureTrack.category, SoundLayerCategory.nature);
      }

      final scrying = SoundPreset.astralScrying;
      expect(scrying.name, 'Astral Scrying Portal');
      expect(scrying.frequencyTrack.id, 'freq_432');
    });

    test('SoundWeaverState effectiveVolume and countdown formatting', () {
      const state = SoundWeaverState(
        isPlaying: true,
        masterVolume: 0.8,
        frequencyVolume: 0.5,
        isFrequencyMuted: false,
        instrumentVolume: 0.6,
        isInstrumentMuted: true,
        natureVolume: 0.25,
        isNatureMuted: false,
        remainingTimerSeconds: 899,
      );

      // Frequency layer: 0.8 * 0.5 = 0.40
      expect(state.effectiveVolume(SoundLayerCategory.frequency), closeTo(0.40, 0.001));

      // Instrument layer is muted -> 0.0
      expect(state.effectiveVolume(SoundLayerCategory.instrument), 0.0);

      // Nature layer: 0.8 * 0.25 = 0.20
      expect(state.effectiveVolume(SoundLayerCategory.nature), closeTo(0.20, 0.001));

      // Formatted remaining time: 899 seconds = 14:59
      expect(state.formattedRemainingTime, '14:59');

      // When stopped, effective volume is 0
      final stopped = state.copyWith(isPlaying: false);
      expect(stopped.effectiveVolume(SoundLayerCategory.frequency), 0.0);
    });
  });

  group('Sacred Audio Weaver Widgets', () {
    testWidgets('FrequencyVisualizerWave renders harmonic canvas', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrequencyVisualizerWave(
              isPlaying: true,
              masterVolume: 0.7,
              height: 100,
            ),
          ),
        ),
      );

      expect(find.byType(FrequencyVisualizerWave), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('LayerFaderCard displays track metadata and responds to interaction', (tester) async {
      double changedVol = 0.0;
      bool muteToggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LayerFaderCard(
              category: SoundLayerCategory.frequency,
              activeTrack: SoundLayerTrack.solfeggio528,
              availableTracks: SoundLayerTrack.forCategory(SoundLayerCategory.frequency),
              volume: 0.8,
              isMuted: false,
              onVolumeChanged: (v) => changedVol = v,
              onToggleMute: () => muteToggled = true,
              onTrackSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('SACRED FREQUENCIES'), findsOneWidget);
      expect(find.text('Miracles & Heart'), findsOneWidget);
      expect(find.text('528 Hz'), findsOneWidget);
      expect(find.text('80%'), findsOneWidget);

      // Tap mute button
      await tester.tap(find.byIcon(Icons.volume_up_rounded));
      expect(muteToggled, isTrue);

      // Drag volume slider
      await tester.drag(find.byType(Slider), const Offset(-50, 0));
      expect(changedVol, isNotNull);
    });

    testWidgets('SacredAudioWeaverModal renders complete console with presets & timer', (tester) async {
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
              body: SacredAudioWeaverModal(),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('SACRED AUDIO WEAVER'), findsOneWidget);
      expect(find.text('Multi-Layer Harmonic Soundscape Studio'), findsOneWidget);
      expect(find.text('MASTER HARMONIC LEVEL'), findsOneWidget);
      expect(find.text('SACRED PRESETS'), findsOneWidget);
      expect(find.text('MEDITATION & SLEEP TIMER'), findsOneWidget);
      expect(find.text('Astral Scrying Portal'), findsOneWidget);
      expect(find.text('Heart & Miracle Grace'), findsOneWidget);
      expect(find.byType(FrequencyVisualizerWave), findsOneWidget);
      expect(find.byType(LayerFaderCard), findsNWidgets(3));
    });

    testWidgets('AmbientAudioButton shows Audio Weaver option in popup', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(56),
                child: AmbientAudioButton(),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(AmbientAudioButton), findsOneWidget);

      // Tap to open popup
      await tester.tap(find.byType(AmbientAudioButton));
      await tester.pumpAndSettle();

      expect(find.text('✦ AUDIO WEAVER STUDIO'), findsOneWidget);
      expect(find.text('Multi-Layer 432/528Hz Soundscapes'), findsOneWidget);
    });
  });
}
