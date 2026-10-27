import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../domain/ar_altar_card.dart';

/// Glass panel revealing the meaning of the selected AR card.
class ArCardInsightPanel extends StatelessWidget {
  const ArCardInsightPanel({super.key, required this.altarCard, required this.onClose});

  final ArAltarCard altarCard;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final card = altarCard.card;
    final bool revealed = altarCard.isRevealed;
    return GlassContainer(
      key: const Key('ar_card_insight_panel'),
      borderRadius: 20,
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 14),
      fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.86),
      borderColor: AppColors.goldBright.withValues(alpha: 0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  altarCard.positionName.toUpperCase(),
                  style: GoogleFonts.cinzel(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: AppColors.goldMuted,
                  ),
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onClose,
                icon: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
                tooltip: 'Close',
              ),
            ],
          ),
          Text(
            revealed
                ? '${card.name}${card.isReversed ? ' • Reversed' : ''}'
                : 'Veiled card',
            style: GoogleFonts.cinzel(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              revealed
                  ? (card.isReversed ? card.meaningReversed : card.meaningUpright)
                  : 'Tap the card on your altar to turn it over.',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 16,
                height: 1.3,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (revealed && card.keywords.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: card.keywords
                  .take(4)
                  .map((String k) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Text(k,
                            style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 260.ms).slideY(begin: 0.2, end: 0);
  }
}
