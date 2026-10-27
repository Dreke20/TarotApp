import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/ambient_soundscape_service.dart';
import '../../../audio_weaver/presentation/notifiers/sound_weaver_notifier.dart';
import '../../../audio_weaver/presentation/widgets/sacred_audio_weaver_modal.dart';

class AmbientAudioButton extends ConsumerWidget {
  const AmbientAudioButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(ambientAudioProvider);
    final weaverState = ref.watch(soundWeaverProvider);
    final notifier = ref.read(ambientAudioProvider.notifier);

    final bool isAnyPlaying = audioState.isPlaying || weaverState.isPlaying;

    return PopupMenuButton<SoundscapeTrack>(
      tooltip: 'Ambient Soundscape & Audio Weaver',
      color: AppColors.backgroundMidnight.withValues(alpha: 0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.glassBorderGlow, width: 1.2),
      ),
      icon: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: isAnyPlaying
              ? AppColors.goldBright.withValues(alpha: 0.18)
              : AppColors.glassFill,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isAnyPlaying
                ? AppColors.goldBright
                : AppColors.glassBorder,
          ),
          boxShadow: [
            if (isAnyPlaying)
              BoxShadow(
                color: AppColors.goldBright.withValues(alpha: 0.35),
                blurRadius: 8,
              ),
          ],
        ),
        child: Icon(
          isAnyPlaying ? Icons.music_note : Icons.music_off,
          color: isAnyPlaying ? AppColors.goldBright : AppColors.textSecondary,
          size: 16,
        ),
      ),
      onSelected: (track) {
        notifier.selectTrack(track);
      },
      itemBuilder: (context) => [
        PopupMenuItem<SoundscapeTrack>(
          enabled: true,
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SacredAudioWeaverModal.show(context);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF382B57), Color(0xFF22173B)],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD4AF37), width: 1.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.waves_rounded, color: Color(0xFFFFD700), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '✦ AUDIO WEAVER STUDIO',
                        style: GoogleFonts.cinzel(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFD700),
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        'Multi-Layer 432/528Hz Soundscapes',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFD4AF37), size: 12),
              ],
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<SoundscapeTrack>(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SACRED AMBIENCE',
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.2,
                ),
              ),
              IconButton(
                icon: Icon(
                  audioState.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: AppColors.goldBright,
                  size: 22,
                ),
                onPressed: () {
                  notifier.togglePlay();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        PopupMenuItem<SoundscapeTrack>(
          enabled: false,
          child: Row(
            children: [
              const Icon(Icons.volume_down, size: 15, color: AppColors.goldMuted),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.goldBright,
                    inactiveTrackColor: AppColors.glassBorder,
                    thumbColor: AppColors.goldBright,
                    trackHeight: 2,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  ),
                  child: Slider(
                    value: audioState.volume,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (val) {
                      notifier.setVolume(val);
                    },
                  ),
                ),
              ),
              const Icon(Icons.volume_up, size: 15, color: AppColors.goldBright),
            ],
          ),
        ),
        const PopupMenuDivider(),
        ...SoundscapeTrack.values.map(
          (track) => PopupMenuItem<SoundscapeTrack>(
            value: track,
            child: Row(
              children: [
                Icon(
                  audioState.track == track ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: 15,
                  color: audioState.track == track ? AppColors.goldBright : AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    track.title,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      color: audioState.track == track ? AppColors.goldBright : AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
