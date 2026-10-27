import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/holographic_foil_card.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../monetization/presentation/widgets/starlight_offering_modal.dart';
import '../../domain/archetypal_pathworking.dart';
import '../widgets/pathworking_player_modal.dart';

/// Screen allowing seekers to browse and embark upon guided Major Arcana audio meditations.
class PathworkingSanctuaryScreen extends ConsumerWidget {
  final ValueChanged<String>? onIntentionAnchored;

  const PathworkingSanctuaryScreen({
    super.key,
    this.onIntentionAnchored,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeys = ArchetypalPathworking.allPathworkings;

    return Scaffold(
      backgroundColor: const Color(0xFF090710),
      body: SafeArea(
        child: Column(
          children: [
            // Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: AppColors.goldBright, size: 18),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.self_improvement,
                                color: AppColors.goldBright, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'ARCHETYPAL PATHWORKINGS',
                              style: GoogleFonts.cinzel(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Guided audio visualizations into the Major Arcana',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Journey List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                physics: const BouncingScrollPhysics(),
                itemCount: journeys.length,
                separatorBuilder: (context, index) => const SizedBox(height: 18),
                itemBuilder: (context, index) {
                  final journey = journeys[index];
                  final totalMinutes = (journey.totalDurationSeconds / 60).round();

                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      final authProfile = ref.read(authNotifierProvider).profile;
                      final isPro = authProfile?.isPro ?? false;

                      void embark() {
                        PathworkingPlayerModal.show(
                          context,
                          pathworking: journey,
                          onRevelationAnchored: (intention) {
                            onIntentionAnchored?.call(intention);
                            Navigator.of(context).pop();
                          },
                        );
                      }

                      if (journey.isPremium && !isPro) {
                        StarlightOfferingModal.show(
                          context,
                          customFeatureTitle: 'ARCHETYPAL PATHWORKING',
                          customFeatureDescription:
                              'Unlock the deep guided visualization for ${journey.cardName} with 1 Starlight Pass, or upgrade to Oracle Pro for unlimited access to all pathworkings.',
                          onUnlocked: embark,
                        );
                        return;
                      }

                      embark();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF130E20),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: AppColors.goldBright.withValues(alpha: 0.35),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.goldBright.withValues(alpha: 0.12),
                            blurRadius: 16,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(21),
                        child: Stack(
                          children: [
                            // Soft radial backdrop
                            Positioned(
                              top: -40,
                              right: -40,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.goldBright
                                      .withValues(alpha: 0.08),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Card Artwork Swatch
                                  HolographicFoilCard(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: 72,
                                      height: 112,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColors.goldBright
                                              .withValues(alpha: 0.5),
                                          width: 0.8,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(11),
                                        child: Image.asset(
                                          'assets/cards/${journey.cardId}.webp',
                                          cacheWidth: 300,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                            color: const Color(0xFF1D1530),
                                            alignment: Alignment.center,
                                            child: Text(
                                              journey.cardName,
                                              style: GoogleFonts.cinzel(
                                                fontSize: 10,
                                                color: AppColors.goldBright,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Text & Metadata
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                journey.title,
                                                style: GoogleFonts.cinzel(
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.goldBright,
                                                ),
                                              ),
                                            ),
                                            if (journey.isPremium) ...[
                                              const SizedBox(width: 6),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.goldBright.withValues(alpha: 0.2),
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(color: AppColors.goldBright, width: 0.8),
                                                ),
                                                child: Text(
                                                  'PRO',
                                                  style: GoogleFonts.cinzel(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.goldBright,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          journey.archetype,
                                          style:
                                              GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.etherealLavender,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          journey.description,
                                          style:
                                              GoogleFonts.plusJakartaSans(
                                            fontSize: 10.5,
                                            height: 1.35,
                                            color: AppColors.textSecondary,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 10),

                                        // Badges (Soundscape & Duration)
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withValues(alpha: 0.06),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: AppColors.goldMuted
                                                      .withValues(alpha: 0.4),
                                                  width: 0.6,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                      Icons.music_note,
                                                      size: 10,
                                                      color:
                                                          AppColors.goldBright),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    journey.soundscapeName,
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontSize: 9.5,
                                                      color:
                                                          AppColors.goldBright,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withValues(alpha: 0.06),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '~${totalMinutes}m · ${journey.steps.length} Steps',
                                                style: GoogleFonts
                                                    .plusJakartaSans(
                                                  fontSize: 9.5,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
