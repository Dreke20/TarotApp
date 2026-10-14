import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

/// Layered 3D deck stack on the mystical table with interactive shuffle feedback.
class DeckPileWidget extends StatelessWidget {
  final bool isShuffling;
  final VoidCallback onTap;
  final int cardsRemaining;

  const DeckPileWidget({
    super.key,
    required this.isShuffling,
    required this.onTap,
    this.cardsRemaining = 78,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isShuffling ? null : onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Underlying aura glow
          Container(
            width: 120,
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.goldBright.withValues(alpha: 0.18),
                  blurRadius: 30,
                  spreadRadius: 4,
                ),
                BoxShadow(
                  color: AppColors.backgroundViolet.withValues(alpha: 0.6),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),

          // Layer 3 (deepest card)
          Transform.translate(
            offset: const Offset(-5, -6),
            child: Transform.rotate(
              angle: -0.04,
              child: _buildCardBackLayer(),
            ),
          ),

          // Layer 2 (middle card)
          Transform.translate(
            offset: const Offset(3, -3),
            child: Transform.rotate(
              angle: 0.03,
              child: _buildCardBackLayer(),
            ),
          ),

          // Layer 1 (top interactive card)
          _buildTopCard(context),
        ],
      ),
    );
  }

  Widget _buildCardBackLayer() {
    return Container(
      width: 104,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: AppColors.cardBackGradient,
        border: Border.all(
          color: AppColors.goldMuted.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
    );
  }

  Widget _buildTopCard(BuildContext context) {
    Widget topCard = Container(
      width: 106,
      height: 172,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: AppColors.cardBackGradient,
        border: Border.all(
          color: AppColors.goldBright.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.goldMuted.withValues(alpha: 0.5),
                width: 0.8,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.goldBright,
                size: 26,
              ),
              const SizedBox(height: 6),
              Text(
                '78',
                style: GoogleFonts.cinzel(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'CARDS',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: AppColors.etherealLavender,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (isShuffling) {
      return topCard
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .shake(
            hz: 6,
            rotation: 0.08,
            offset: const Offset(4, 0),
            duration: 250.ms,
          )
          .shimmer(
            color: AppColors.goldBright.withValues(alpha: 0.6),
            duration: 800.ms,
          );
    }

    return topCard
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(
          color: AppColors.etherealLavender.withValues(alpha: 0.2),
          duration: 2500.ms,
        );
  }
}
