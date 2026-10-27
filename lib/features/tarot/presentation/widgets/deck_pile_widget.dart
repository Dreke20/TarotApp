import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import 'tarot_card_widget.dart';

/// Layered 3D deck stack on the mystical table with interactive shuffle feedback.
class DeckPileWidget extends StatelessWidget {
  final bool isShuffling;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final int cardsRemaining;

  const DeckPileWidget({
    super.key,
    required this.isShuffling,
    required this.onTap,
    this.onLongPress,
    this.cardsRemaining = 78,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isShuffling ? null : onTap,
      onLongPress: isShuffling ? null : onLongPress,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Underlying aura glow
          Container(
            width: 180,
            height: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: AppColors.goldBright.withValues(alpha: 0.22),
                  blurRadius: 36,
                  spreadRadius: 6,
                ),
                BoxShadow(
                  color: AppColors.backgroundViolet.withValues(alpha: 0.65),
                  blurRadius: 48,
                  spreadRadius: 12,
                ),
              ],
            ),
          ),

          // Layer 4 (deepest gilded edge)
          Transform.translate(
            offset: const Offset(-7, -8),
            child: Transform.rotate(
              angle: -0.05,
              child: _buildCardBackLayer(136, 218),
            ),
          ),

          // Layer 3 (gilded side edge)
          Transform.translate(
            offset: const Offset(6, -5),
            child: Transform.rotate(
              angle: 0.04,
              child: _buildCardBackLayer(137, 220),
            ),
          ),

          // Layer 2 (middle gilded card)
          Transform.translate(
            offset: const Offset(-3, 4),
            child: Transform.rotate(
              angle: -0.02,
              child: _buildCardBackLayer(139, 222),
            ),
          ),

          // Layer 1 (top interactive card)
          _buildTopCard(context),
        ],
      ),
    );
  }

  Widget _buildCardBackLayer(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: AppColors.cardBackGradient,
        border: Border.all(
          color: AppColors.goldBright.withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCard(BuildContext context) {
    Widget topCard = Container(
      width: 140,
      height: 224,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: AppColors.cardBackGradient,
        border: Border.all(
          color: AppColors.goldBright,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldBright.withValues(alpha: 0.35),
            blurRadius: 22,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Inner ornamental border
          Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.goldBright.withValues(alpha: 0.4),
                width: 0.9,
              ),
            ),
          ),

          // Sacred Geometry Center Pattern
          const Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomPaint(
                painter: CardBackPatternPainter(),
              ),
            ),
          ),

          // Central mystic badge with card count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.backgroundMidnight.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.goldBright.withValues(alpha: 0.7),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: AppColors.goldBright,
                  size: 20,
                ),
                const SizedBox(height: 2),
                Text(
                  '$cardsRemaining',
                  style: GoogleFonts.cinzel(
                    fontSize: 15,
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
