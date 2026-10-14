import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/ambient_soundscape_service.dart';

class AmbientAudioButton extends ConsumerWidget {
  const AmbientAudioButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(ambientAudioProvider);
    final notifier = ref.read(ambientAudioProvider.notifier);

    return PopupMenuButton<SoundscapeTrack>(
      tooltip: 'Ambient Soundscape',
      color: AppColors.backgroundMidnight.withValues(alpha: 0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.glassBorderGlow, width: 1.2),
      ),
      icon: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: audioState.isPlaying
              ? AppColors.goldBright.withValues(alpha: 0.18)
              : AppColors.glassFill,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: audioState.isPlaying
                ? AppColors.goldBright
                : AppColors.glassBorder,
          ),
        ),
        child: Icon(
          audioState.isPlaying ? Icons.music_note : Icons.music_off,
          color: audioState.isPlaying ? AppColors.goldBright : AppColors.textSecondary,
          size: 16,
        ),
      ),
      onSelected: (track) {
        notifier.selectTrack(track);
      },
      itemBuilder: (context) => [
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
                Text(
                  track.title,
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    color: audioState.track == track ? AppColors.goldBright : AppColors.textPrimary,
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
