import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';
import '../../domain/altar_cloth.dart';
import '../notifiers/altar_cloth_notifier.dart';
import 'altar_cloth_painter.dart';

/// Modal allowing seekers to select and consecrate luxury altar cloths.
class AltarClothSelectorModal extends ConsumerWidget {
  const AltarClothSelectorModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AltarClothSelectorModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCloth = ref.watch(altarClothProvider);
    final isPro = ref.watch(isProUserProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
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
                    const Icon(Icons.table_restaurant, color: AppColors.goldBright, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'CONSECRATED ALTAR CLOTHS',
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
              'Select a consecrated fabric weave to align your divination table surface with specific astrological & alchemical currents.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Cloths List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              physics: const BouncingScrollPhysics(),
              itemCount: AltarCloth.values.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final cloth = AltarCloth.values[index];
                final isSelected = cloth == activeCloth;
                final isLocked = cloth.isPro && !isPro;

                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    if (isLocked) {
                      OracleProModal.show(context);
                    } else {
                      ref.read(altarClothProvider.notifier).selectCloth(cloth);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected
                            ? cloth.accentColor
                            : cloth.accentColor.withValues(alpha: 0.25),
                        width: isSelected ? 2.0 : 1.0,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: cloth.accentColor.withValues(alpha: 0.25),
                                blurRadius: 16,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Stack(
                        children: [
                          // Miniature Altar Cloth Canvas Preview
                          Positioned.fill(
                            child: CustomPaint(
                              painter: AltarClothPainter(cloth: cloth),
                            ),
                          ),

                          // Dark subtle overlay for text readability
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.35),
                            ),
                          ),

                          // Card Content
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Glyph Badge
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cloth.primaryColor,
                                    border: Border.all(
                                      color: cloth.accentColor.withValues(alpha: 0.6),
                                      width: 1.2,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    cloth.glyph,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: cloth.trimColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Title & Lore
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              cloth.title,
                                              style: GoogleFonts.cinzel(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: isSelected
                                                    ? cloth.trimColor
                                                    : AppColors.textPrimary,
                                              ),
                                            ),
                                          ),
                                          if (cloth.isPro) ...[
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: isPro
                                                    ? cloth.accentColor.withValues(alpha: 0.25)
                                                    : const Color(0xFFFFD700).withValues(alpha: 0.2),
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(
                                                  color: isPro
                                                      ? cloth.accentColor
                                                      : const Color(0xFFFFD700),
                                                  width: 0.8,
                                                ),
                                              ),
                                              child: Text(
                                                isPro ? 'PRO UNLOCKED' : 'PRO',
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 8.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: isPro
                                                      ? cloth.trimColor
                                                      : const Color(0xFFFFD700),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        cloth.subtitle,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: cloth.accentColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        cloth.description,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10.5,
                                          color: AppColors.textSecondary,
                                          height: 1.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Active Checkmark or Lock
                                if (isLocked)
                                  const Icon(Icons.lock_outline, color: Color(0xFFFFD700), size: 20)
                                else if (isSelected)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: cloth.accentColor,
                                    ),
                                    child: const Icon(Icons.check, color: Colors.black, size: 14),
                                  )
                                else
                                  Icon(Icons.circle_outlined, color: cloth.accentColor.withValues(alpha: 0.4), size: 20),
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
