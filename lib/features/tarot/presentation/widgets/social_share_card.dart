import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/reading.dart';
import 'glass_container.dart';
import 'social_story_export_modal.dart';
import 'tarot_card_widget.dart';

class SocialShareCardDialog extends StatelessWidget {
  final Reading reading;

  const SocialShareCardDialog({super.key, required this.reading});

  static Future<void> show(BuildContext context, {required Reading reading}) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (_) => SocialShareCardDialog(reading: reading),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 9:16 Card Canvas
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 340, maxHeight: 520),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: AppColors.cosmicBackgroundGradient,
              border: Border.all(color: AppColors.goldBright, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.goldBright.withValues(alpha: 0.25),
                  blurRadius: 28,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Brand
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome, color: AppColors.goldBright, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'ASTRAL GUIDANCE',
                          style: GoogleFonts.cinzel(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'AI TAROT SANCTUARY',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.etherealLavender,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),

                // Question
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.glassFillStrong,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Text(
                    '"${reading.question}"',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                // Cards Mini Spread
                SizedBox(
                  height: 140,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reading.cards.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, idx) {
                      return TarotCardWidget(
                        card: reading.cards[idx],
                        isFaceUp: true,
                        width: 75,
                        height: 130,
                        index: idx,
                      );
                    },
                  ),
                ),

                // Cosmic Summary Quote
                if (reading.summary != null)
                  GlassContainer(
                    padding: const EdgeInsets.all(12),
                    borderRadius: 14,
                    fillColor: AppColors.cosmicSurface.withValues(alpha: 0.6),
                    borderColor: AppColors.goldBright.withValues(alpha: 0.4),
                    child: Text(
                      '“${reading.summary!}”',
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.goldBright,
                        height: 1.4,
                      ),
                    ),
                  ),

                // Footer watermark
                Text(
                  'Channel your reading on Astral Guidance',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldBright,
                  foregroundColor: AppColors.backgroundDeep,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.share, size: 18),
                label: Text(
                  'SHARE TO STORY',
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (reading.cards.isNotEmpty) {
                    SocialStoryExportModal.show(
                      context,
                      card: reading.cards.first,
                      isReversed: reading.cards.first.isReversed,
                      customQuote: reading.summary ?? reading.advice ?? reading.cards.first.meaningUpright,
                    );
                  }
                },
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
