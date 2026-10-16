import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/holographic_foil_card.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';
import '../../domain/card_back_design.dart';
import '../notifiers/card_back_notifier.dart';
import 'card_back_design_painter.dart';

/// Modal allowing seekers to inspect and bind collectible card back designs.
class CardBackSelectorModal extends ConsumerWidget {
  const CardBackSelectorModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CardBackSelectorModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeDesign = ref.watch(cardBackProvider);
    final isPro = ref.watch(isProUserProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0A14),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: AppColors.goldBright.withValues(alpha: 0.35),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.goldMuted.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.style, color: AppColors.goldBright, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'COLLECTIBLE CARD BACKS',
                      style: GoogleFonts.cinzel(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Select an authentic sacred geometry talisman to bind to the reverse of all 78 arcana cards.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Card Backs Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62,
                crossAxisSpacing: 14,
                mainAxisSpacing: 16,
              ),
              itemCount: CardBackDesign.values.length,
              itemBuilder: (context, index) {
                final design = CardBackDesign.values[index];
                final isSelected = design == activeDesign;
                final isLocked = design.isPro && !isPro;

                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    if (isLocked) {
                      OracleProModal.show(context);
                    } else {
                      ref.read(cardBackProvider.notifier).selectDesign(design);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: design.backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? design.primaryFoilColor
                            : design.primaryFoilColor.withValues(alpha: 0.3),
                        width: isSelected ? 2.0 : 1.0,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: design.primaryFoilColor.withValues(alpha: 0.35),
                                blurRadius: 16,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Miniature Card Back with Holographic Foil
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
                              child: HolographicFoilCard(
                                borderRadius: BorderRadius.circular(10),
                                enableSensorTilt: isSelected,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: design.backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: design.primaryFoilColor.withValues(alpha: 0.5),
                                      width: 0.8,
                                    ),
                                  ),
                                  child: CustomPaint(
                                    painter: CardBackDesignPainter(design: design),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Metadata Footer
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        design.title,
                                        style: GoogleFonts.cinzel(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? design.secondaryFoilColor
                                              : AppColors.textPrimary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (design.isPro) ...[
                                      const SizedBox(width: 4),
                                      Text(
                                        'PRO',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFFFD700),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  design.subtitle,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 9.5,
                                    color: design.primaryFoilColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                if (isSelected)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 3),
                                    decoration: BoxDecoration(
                                      color: design.primaryFoilColor.withValues(alpha: 0.25),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: design.primaryFoilColor,
                                        width: 0.8,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ACTIVE TALISMAN',
                                      style: GoogleFonts.cinzel(
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.bold,
                                        color: design.secondaryFoilColor,
                                      ),
                                    ),
                                  )
                                else if (isLocked)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: const Color(0xFFFFD700).withValues(alpha: 0.5),
                                        width: 0.8,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.lock, size: 9, color: Color(0xFFFFD700)),
                                        SizedBox(width: 4),
                                        Text(
                                          'UNLOCK PRO',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFFD700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'BIND TO DECK',
                                      style: GoogleFonts.cinzel(
                                        fontSize: 8.5,
                                        color: AppColors.textSecondary,
                                      ),
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
    );
  }
}
