import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      onTap: () {
        HapticFeedback.selectionClick();
        onSpreadChanged(type);
      },
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 18,
      fillColor: isSelected
          ? AppColors.goldBright.withValues(alpha: 0.18)
          : const Color(0xFF161320),
      borderColor: isSelected
          ? AppColors.goldBright
          : AppColors.glassBorder.withValues(alpha: 0.65),
      borderWidth: isSelected ? 1.6 : 1.1,
      shadows: isSelected
          ? [
              BoxShadow(
                color: AppColors.goldBright.withValues(alpha: 0.35),
                blurRadius: 18,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ]
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? AppColors.goldBright.withValues(alpha: 0.25)
                  : AppColors.glassFillStrong,
              border: Border.all(
                color: isSelected
                    ? AppColors.goldBright
                    : AppColors.goldBright.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.goldBright : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    type.title,
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                      letterSpacing: 0.6,
                    ),
                  ),
                  if (isPro) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: AppColors.goldBright.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.goldBright, width: 0.9),
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
              const SizedBox(height: 2),
              Text(
                '${type.cardCount} ${type.cardCount == 1 ? "Card" : "Cards"}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
