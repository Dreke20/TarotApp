import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

/// Shimmering channeling view displayed while the AI Oracle is computing the prophecy.
class OracleChannelingView extends StatelessWidget {
  const OracleChannelingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cosmicSurface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.etherealLavender.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.goldBright),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'CHANNELING THE STARS...',
            style: GoogleFonts.cinzel(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'The Oracle is connecting with Vertex AI to weave your reading',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.5,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).shimmer(duration: 1500.ms);
  }
}
