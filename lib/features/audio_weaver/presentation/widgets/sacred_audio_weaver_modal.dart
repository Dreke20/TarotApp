import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/sound_layer.dart';
import '../notifiers/sound_weaver_notifier.dart';
import '../notifiers/sound_weaver_state.dart';
import 'frequency_visualizer_wave.dart';
import 'layer_fader_card.dart';

/// Modal bottom sheet console for the Sacred Audio Weaver & Binaural Mixer studio.
class SacredAudioWeaverModal extends ConsumerWidget {
  const SacredAudioWeaverModal({super.key});

  /// Presents the Audio Weaver modal studio.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const SacredAudioWeaverModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SoundWeaverState state = ref.watch(soundWeaverProvider);
    final SoundWeaverNotifier notifier = ref.read(soundWeaverProvider.notifier);

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.50,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F0C1B),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              top: BorderSide(color: Color(0xFFD4AF37), width: 1.2),
              left: BorderSide(color: Color(0xFFD4AF37), width: 0.4),
              right: BorderSide(color: Color(0xFFD4AF37), width: 0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 30,
                spreadRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              // Top Drag Handle & Close Bar
              _buildTopBar(context, state),

              // Scrollable Body
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  children: [
                    // Dynamic Harmonic Wave Visualizer
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF151024),
                          border: Border.all(color: const Color(0xFF2C2245), width: 0.8),
                        ),
                        child: FrequencyVisualizerWave(
                          isPlaying: state.isPlaying,
                          masterVolume: state.masterVolume,
                          frequencyVolume: state.isFrequencyMuted ? 0.0 : state.frequencyVolume,
                          instrumentVolume: state.isInstrumentMuted ? 0.0 : state.instrumentVolume,
                          natureVolume: state.isNatureMuted ? 0.0 : state.natureVolume,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Master Control Orb & Master Fader
                    _buildMasterControlCard(state, notifier),
                    const SizedBox(height: 18),

                    // Curated Presets
                    _buildPresetsSection(state, notifier),
                    const SizedBox(height: 18),

                    // Meditation / Sleep Timer Section
                    _buildSleepTimerSection(state, notifier),
                    const SizedBox(height: 20),

                    // Layer 1: Sacred Frequency
                    LayerFaderCard(
                      category: SoundLayerCategory.frequency,
                      activeTrack: state.frequencyTrack,
                      availableTracks: SoundLayerTrack.forCategory(SoundLayerCategory.frequency),
                      volume: state.frequencyVolume,
                      isMuted: state.isFrequencyMuted,
                      onVolumeChanged: (val) =>
                          notifier.setLayerVolume(SoundLayerCategory.frequency, val),
                      onToggleMute: () =>
                          notifier.toggleLayerMute(SoundLayerCategory.frequency),
                      onTrackSelected: (t) =>
                          notifier.setLayerTrack(SoundLayerCategory.frequency, t),
                    ),

                    // Layer 2: Temple Instruments
                    LayerFaderCard(
                      category: SoundLayerCategory.instrument,
                      activeTrack: state.instrumentTrack,
                      availableTracks: SoundLayerTrack.forCategory(SoundLayerCategory.instrument),
                      volume: state.instrumentVolume,
                      isMuted: state.isInstrumentMuted,
                      onVolumeChanged: (val) =>
                          notifier.setLayerVolume(SoundLayerCategory.instrument, val),
                      onToggleMute: () =>
                          notifier.toggleLayerMute(SoundLayerCategory.instrument),
                      onTrackSelected: (t) =>
                          notifier.setLayerTrack(SoundLayerCategory.instrument, t),
                    ),

                    // Layer 3: Elemental Atmospheres
                    LayerFaderCard(
                      category: SoundLayerCategory.nature,
                      activeTrack: state.natureTrack,
                      availableTracks: SoundLayerTrack.forCategory(SoundLayerCategory.nature),
                      volume: state.natureVolume,
                      isMuted: state.isNatureMuted,
                      onVolumeChanged: (val) =>
                          notifier.setLayerVolume(SoundLayerCategory.nature, val),
                      onToggleMute: () =>
                          notifier.toggleLayerMute(SoundLayerCategory.nature),
                      onTrackSelected: (t) =>
                          notifier.setLayerTrack(SoundLayerCategory.nature, t),
                    ),

                    const SizedBox(height: 20),

                    // Alchemical Wisdom Footnote
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161224),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('✨', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Solfeggio frequencies (432Hz, 528Hz, 741Hz) harmonize cellular resonance and scrying clarity. Layer with Tibetan singing bowls and astral wind for deep meditative divinations.',
                              style: TextStyle(
                                color: const Color(0xFFD4AF37).withValues(alpha: 0.85),
                                fontSize: 11,
                                height: 1.4,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context, SoundWeaverState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 10),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.waves_rounded, color: Color(0xFFD4AF37), size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SACRED AUDIO WEAVER',
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        color: Color(0xFFD4AF37),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      'Multi-Layer Harmonic Soundscape Studio',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white70),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMasterControlCard(SoundWeaverState state, SoundWeaverNotifier notifier) {
    final int masterPercent = (state.masterVolume * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF231B39),
            Color(0xFF1B152D),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          // Play / Pause Orb
          GestureDetector(
            onTap: () => notifier.togglePlay(),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: state.isPlaying
                      ? [const Color(0xFFFFD700), const Color(0xFFD4AF37), const Color(0xFF996515)]
                      : [const Color(0xFF3B2E5C), const Color(0xFF251B3B)],
                ),
                boxShadow: [
                  if (state.isPlaying)
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: Icon(
                state.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: state.isPlaying ? const Color(0xFF0F0C1B) : const Color(0xFFD4AF37),
                size: 32,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Master Volume Slider
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'MASTER HARMONIC LEVEL',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Text(
                      '$masterPercent%',
                      style: const TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: const Color(0xFFFFD700),
                    inactiveTrackColor: const Color(0xFF33274E),
                    thumbColor: const Color(0xFFFFD700),
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                    overlayColor: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                  ),
                  child: Slider(
                    value: state.masterVolume,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (val) => notifier.setMasterVolume(val),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetsSection(SoundWeaverState state, SoundWeaverNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'SACRED PRESETS',
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            if (state.activePreset != null)
              Text(
                '✦ ${state.activePreset!.name}',
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              Text(
                'Custom Mix',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: SoundPreset.allPresets.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final SoundPreset preset = SoundPreset.allPresets[index];
              final bool isSelected = state.activePreset?.id == preset.id;

              return InkWell(
                onTap: () => notifier.applyPreset(preset),
                borderRadius: BorderRadius.circular(19),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFD4AF37)
                        : const Color(0xFF1B152C),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFFFD700)
                          : const Color(0xFF382B57),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(preset.glyph, style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        preset.name,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF0F0C1B) : Colors.white,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSleepTimerSection(SoundWeaverState state, SoundWeaverNotifier notifier) {
    final List<int?> timerOptions = [null, 15, 30, 45, 60];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF151024),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2D234A), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.timer_outlined, color: Color(0xFFD4AF37), size: 16),
                  SizedBox(width: 6),
                  Text(
                    'MEDITATION & SLEEP TIMER',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              if (state.formattedRemainingTime != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFD4AF37), width: 0.8),
                  ),
                  child: Text(
                    '⏳ ${state.formattedRemainingTime} remaining',
                    style: const TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: timerOptions.map((mins) {
              final bool isSelected = (mins == null && state.timerDurationSeconds == null) ||
                  (mins != null && state.timerDurationSeconds == mins * 60);

              final String label = mins == null ? 'Off' : '${mins}m';

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: InkWell(
                    onTap: () => notifier.setTimerMinutes(mins),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFD4AF37).withValues(alpha: 0.25)
                            : const Color(0xFF1F1834),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFD4AF37)
                              : const Color(0xFF33274E),
                          width: isSelected ? 1.0 : 0.6,
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFFFFD700) : Colors.white70,
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
