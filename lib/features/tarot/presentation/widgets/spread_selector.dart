import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/spread_type.dart';
import 'glass_container.dart';

/// Glassmorphic spread switcher enabling users to select between
/// Daily Guidance (1 Card), The Three Fates (3 Cards), and The Celtic Cross (10 Cards).
class SpreadSelector extends StatelessWidget {
  final SpreadType selectedSpread;
  final ValueChanged<SpreadType> onSpreadChanged;

  const SpreadSelector({
    super.key,
    required this.selectedSpread,
    required this.onSpreadChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildSpreadOption(
            type: SpreadType.dailyGuidance,
            icon: Icons.brightness_auto,
          ),
          const SizedBox(width: 10),
          _buildSpreadOption(
            type: SpreadType.threeFates,
            icon: Icons.all_inclusive,
          ),
          const SizedBox(width: 10),
          _buildSpreadOption(
            type: SpreadType.celticCross,
            icon: Icons.auto_awesome_motion,
            isPro: true,
          ),
          const SizedBox(width: 10),
          _buildSpreadOption(
            type: SpreadType.heartOfTwo,
            icon: Icons.favorite,
            isPro: true,
          ),
          const SizedBox(width: 10),
          _buildSpreadOption(
            type: SpreadType.careerCrossroads,
            icon: Icons.explore,
            isPro: true,
          ),
          const SizedBox(width: 10),
          _buildSpreadOption(
            type: SpreadType.shadowMirror,
            icon: Icons.visibility,
            isPro: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSpreadOption({
    required SpreadType type,
    required IconData icon,
    bool isPro = false,
  }) {
    final isSelected = selectedSpread == type;

    return GlassContainer(
      onTap: () => onSpreadChanged(type),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      borderRadius: 16,
      fillColor: isSelected
          ? AppColors.glassFillStrong
          : AppColors.glassFill.withValues(alpha: 0.05),
      borderColor: isSelected
          ? AppColors.goldBright
          : AppColors.glassBorder.withValues(alpha: 0.4),
      borderWidth: isSelected ? 1.5 : 1.0,
      shadows: isSelected
          ? [
              BoxShadow(
                color: AppColors.goldBright.withValues(alpha: 0.25),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ]
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? AppColors.goldBright : AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    type.title,
                    style: GoogleFonts.cinzel(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                    ),
                  ),
                  if (isPro) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.goldBright.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.goldBright, width: 0.8),
                      ),
                      child: Text(
                        'PRO',
                        style: GoogleFonts.cinzel(
                          fontSize: 7.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                '${type.cardCount} ${type.cardCount == 1 ? "Card" : "Cards"}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.5,
                  color: isSelected
                      ? AppColors.etherealLavender
                      : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
