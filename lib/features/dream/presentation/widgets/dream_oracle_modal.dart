import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../tarot/data/tarot_repository.dart';
import '../../../tarot/domain/spread_type.dart';
import '../../../tarot/presentation/screens/tarot_table_screen.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../domain/dream_entry.dart';

/// Modal bottom sheet synthesizing a Dream narrative with Jungian Depth Scrying
/// and preparing a dedicated 3-card Altar Spread.
class DreamOracleModal extends ConsumerWidget {
  final DreamEntry dream;

  const DreamOracleModal({
    super.key,
    required this.dream,
  });

  static Future<void> show(BuildContext context, {required DreamEntry dream}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DreamOracleModal(dream: dream),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final repository = ref.read(tarotRepositoryProvider);
    final authProfile = ref.watch(authNotifierProvider).profile;

    final scryResult = repository.scryDreamVision(
      dreamTitle: dream.title,
      dreamDescription: dream.narrative,
      astrologyInfo: authProfile?.zodiacSign != null ? {'sun': authProfile!.zodiacSign!} : null,
    );

    final archetypes = (scryResult['archetypes'] as List<dynamic>?)?.cast<String>() ?? [];
    final spreadPositions = (scryResult['spread_positions'] as List<dynamic>?)?.cast<String>() ?? [];
    final analysis = scryResult['analysis'] as String? ?? '';
    final consecrationQuestion = scryResult['consecration_question'] as String? ?? 'Dream Altar Consecration';

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.88,
      ),
      margin: const EdgeInsets.only(top: 24),
      child: GlassContainer(
        borderRadius: 28,
        blur: 24,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.96),
        borderColor: AppColors.glassBorderGlow,
        borderWidth: 1.5,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          children: [
            // Drag Indicator
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Header Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.nightlight_round, color: AppColors.goldBright, size: 20),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'DREAM ALTAR SYNTHESIS',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cinzel(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              'JUNGIAN SUBCONSCIOUS SCRYING',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.etherealLavender,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: AppColors.glassBorder),
            const SizedBox(height: 8),

            // Content Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dream Title Reference
                    Text(
                      'VISION: "${dream.title}"',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Detected Archetypes
                    if (archetypes.isNotEmpty) ...[
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: archetypes.map((arch) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.purpleDeep.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.etherealLavender.withValues(alpha: 0.4)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.psychology, size: 12, color: AppColors.etherealLavender),
                                const SizedBox(width: 5),
                                Text(
                                  arch,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.etherealLavender,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Jungian Analysis Narrative
                    Text(
                      'PSYCHE ARCHITECTURE',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassContainer(
                      padding: const EdgeInsets.all(14),
                      borderRadius: 16,
                      fillColor: AppColors.glassFillStrong,
                      child: Text(
                        analysis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                          height: 1.55,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3-Card Sacred Dream Altar Spread
                    Text(
                      'CONSECRATION SPREAD (3-CARD ALTAR)',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...spreadPositions.asMap().entries.map((entry) {
                      final idx = entry.key + 1;
                      final pos = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GlassContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          borderRadius: 12,
                          fillColor: AppColors.glassFill,
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.goldBright.withValues(alpha: 0.15),
                                  border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                                ),
                                child: Center(
                                  child: Text(
                                    '$idx',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldBright,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  pos,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Consecrate Altar CTA Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldBright,
                  foregroundColor: AppColors.backgroundDeep,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
                icon: const Icon(Icons.auto_awesome, size: 18),
                label: Text(
                  'CONSECRATE UPON SACRED ALTAR',
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TarotTableScreen(
                        initialQuestion: consecrationQuestion,
                        initialSpread: SpreadType.threeFates,
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
