import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/lunar_calculator.dart';

/// Altar banner presenting real-time lunar transit, illumination %, and cosmic timing.
class LunarTransitBanner extends StatelessWidget {
  const LunarTransitBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final lunar = LunarCalculator.getTodayLunarInfo();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundMidnight.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.glassBorderGlow.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Text(
            lunar.phase.symbol,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      '${lunar.phase.title.toUpperCase()} • ${lunar.illuminationPercent.toStringAsFixed(0)}% ILLUMINATED',
                      style: GoogleFonts.cinzel(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: AppColors.etherealLavender.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '☽ in ${lunar.moonZodiac}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.etherealLavender,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  lunar.transitGuidance,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
