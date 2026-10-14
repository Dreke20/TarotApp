import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/spread_type.dart';
import '../../domain/tarot_card.dart';
import '../notifiers/reading_notifier.dart';
import '../notifiers/reading_state.dart';
import 'altar_cloth_widget.dart';
import 'tarot_card_widget.dart';

/// Renders the spread layout according to the active [SpreadType]
/// (Daily 1-card, Three Fates 3-cards, or Celtic Cross / Specialized 4-10 cards).
class SpreadBoardView extends StatelessWidget {
  final ReadingState state;
  final ReadingNotifier notifier;

  const SpreadBoardView({
    super.key,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    final List<TarotCard> drawnCards = state.drawnCards;
    final Set<int> revealed = state.revealedIndices;

    if (state.spreadType == SpreadType.dailyGuidance) {
      final card = drawnCards.first;
      final isFlipped = revealed.contains(0);

      return AltarClothWidget(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.glassFillStrong,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldBright.withValues(alpha: 0.25),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Text(
                'TODAY\'S SACRED GUIDANCE',
                style: GoogleFonts.cinzel(
                  fontSize: 10.5,
                  color: AppColors.goldBright,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TarotCardWidget(
              card: card,
              isFaceUp: isFlipped,
              width: 170,
              height: 275,
              index: 0,
              deckTheme: state.deckTheme,
              onTap: () => notifier.flipCard(0),
            ),
          ],
        ),
      );
    } else if (state.spreadType == SpreadType.threeFates) {
      // The Three Fates Spread
      return AltarClothWidget(
        minHeight: 340,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: drawnCards.asMap().entries.map((entry) {
              final index = entry.key;
              final card = entry.value;
              final isFlipped = revealed.contains(index);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.glassFillStrong,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.6)),
                      ),
                      child: Text(
                        index == 0
                            ? 'I. PAST'
                            : index == 1
                                ? 'II. PRESENT'
                                : 'III. FUTURE',
                        style: GoogleFonts.cinzel(
                          fontSize: 9.5,
                          color: AppColors.goldBright,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TarotCardWidget(
                      card: card,
                      isFaceUp: isFlipped,
                      width: 125,
                      height: 205,
                      index: index,
                      deckTheme: state.deckTheme,
                      onTap: () => notifier.flipCard(index),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
    } else {
      // --- THE CELTIC CROSS & EXPANDED SPREADS (4-10 Cards) ---
      return Column(
        children: [
          AltarClothWidget(
            minHeight: 330,
            child: SizedBox(
              height: 270,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: drawnCards.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final card = drawnCards[index];
                  final isFlipped = revealed.contains(index);
                  final isInspected = state.selectedInspectIndex == index;

                  return GestureDetector(
                    onTap: () {
                      notifier.selectInspectIndex(index);
                      notifier.flipCard(index);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isInspected
                                ? AppColors.goldBright
                                : AppColors.glassFillStrong,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isInspected
                                  ? AppColors.goldBright
                                  : AppColors.glassBorder,
                            ),
                          ),
                          child: Text(
                            '${index + 1}. ${_shortPositionName(state.spreadType, index)}',
                            style: GoogleFonts.cinzel(
                              fontSize: 8.5,
                              color: isInspected
                                  ? AppColors.backgroundDeep
                                  : AppColors.goldBright,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TarotCardWidget(
                          card: card,
                          isFaceUp: isFlipped,
                          width: 100,
                          height: 170,
                          index: index,
                          isSelected: isInspected,
                          deckTheme: state.deckTheme,
                          onTap: () => notifier.flipCard(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Active Card Inspector Pill
          if (state.selectedInspectIndex != null &&
              state.selectedInspectIndex! < drawnCards.length) ...[
            const SizedBox(height: 12),
            _buildInspectorPill(drawnCards[state.selectedInspectIndex!], state),
          ],
        ],
      );
    }
  }

  String _shortPositionName(SpreadType spread, int index) {
    if (spread == SpreadType.celticCross) {
      const names = [
        'Present', 'Cross', 'Root', 'Past', 'Crown',
        'Future', 'Self', 'World', 'Hopes', 'Outcome'
      ];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    } else if (spread == SpreadType.heartOfTwo) {
      const names = ['You', 'Them', 'Nexus', 'Lesson', 'Horizon'];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    } else if (spread == SpreadType.careerCrossroads) {
      const names = ['Station', 'Leverage', 'Obstacle', 'Action', 'Peak'];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    } else if (spread == SpreadType.shadowMirror) {
      const names = ['Persona', 'Shadow', 'Wound', 'Gateway'];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    } else if (spread == SpreadType.wheelOfTheYear) {
      const names = [
        '1st Aries', '2nd Taurus', '3rd Gemini', '4th Cancer',
        '5th Leo', '6th Virgo', '7th Libra', '8th Scorpio',
        '9th Sag', '10th Cap', '11th Aqua', '12th Pisces'
      ];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    }
    return 'Card ${index + 1}';
  }

  Widget _buildInspectorPill(TarotCard card, ReadingState state) {
    final isFlipped = state.revealedIndices.contains(state.selectedInspectIndex);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cosmicSurface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(
            isFlipped ? Icons.auto_awesome : Icons.lock_outline,
            color: AppColors.goldBright,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.positionName ?? 'Card Position',
                  style: GoogleFonts.cinzel(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                  ),
                ),
                Text(
                  isFlipped
                      ? '${card.name} (${card.isReversed ? "Reversed" : "Upright"}) — ${card.keywords.take(2).join(", ")}'
                      : 'Tap to unveil this position\'s message',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.textPrimary,
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
