import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../domain/spread_type.dart';
import '../../domain/tarot_card.dart';

/// Modal dialog providing an intuitive, tactile "Cut the Deck" ritual where
/// seekers manually pick their cards from a sacred fanned deck of 78 cards.
class ManualCardPickerDialog extends StatefulWidget {
  final SpreadType spreadType;
  final List<TarotCard> fullDeck;
  final Function(List<TarotCard>) onCardsSelected;

  const ManualCardPickerDialog({
    super.key,
    required this.spreadType,
    required this.fullDeck,
    required this.onCardsSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required SpreadType spreadType,
    required List<TarotCard> fullDeck,
    required Function(List<TarotCard>) onCardsSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ManualCardPickerDialog(
        spreadType: spreadType,
        fullDeck: fullDeck,
        onCardsSelected: onCardsSelected,
      ),
    );
  }

  @override
  State<ManualCardPickerDialog> createState() => _ManualCardPickerDialogState();
}

class _ManualCardPickerDialogState extends State<ManualCardPickerDialog> {
  final Set<int> _selectedCardIndices = {};
  final SensoryService _sensory = SensoryService();

  @override
  Widget build(BuildContext context) {
    final neededCount = widget.spreadType.cardCount;
    final remainingCount = neededCount - _selectedCardIndices.length;

    return Container(
      height: 480,
      decoration: BoxDecoration(
        color: AppColors.backgroundMidnight.withValues(alpha: 0.96),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: const Border(
          top: BorderSide(color: AppColors.goldBright, width: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Drag handle
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textMuted.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Text(
            'SACRED SELECTION RITUAL',
            style: GoogleFonts.cinzel(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            remainingCount > 0
                ? 'Trust your intuition. Select $remainingCount more ${remainingCount == 1 ? "card" : "cards"}.'
                : 'All sacred archetypes chosen. Tap below to seal your spread.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),

          // Horizontally scrollable fanned card ribbon
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              itemCount: widget.fullDeck.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCardIndices.contains(index);

                return GestureDetector(
                  onTap: () {
                    _sensory.cardFlipHaptic();
                    _sensory.playCardFlipSound();
                    setState(() {
                      if (isSelected) {
                        _selectedCardIndices.remove(index);
                      } else if (_selectedCardIndices.length < neededCount) {
                        _selectedCardIndices.add(index);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutBack,
                    width: 76,
                    margin: EdgeInsets.only(
                      right: 10,
                      top: isSelected ? 0 : 25,
                      bottom: isSelected ? 25 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cosmicSurface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.goldBright
                            : AppColors.goldMuted.withValues(alpha: 0.5),
                        width: isSelected ? 2.2 : 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? AppColors.goldBright.withValues(alpha: 0.5)
                              : Colors.black.withValues(alpha: 0.5),
                          blurRadius: isSelected ? 18 : 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Inner ornamental border
                        Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.goldMuted.withValues(alpha: 0.3),
                              width: 0.8,
                            ),
                          ),
                        ),
                        Icon(
                          isSelected ? Icons.check_circle : Icons.auto_awesome,
                          color: isSelected
                              ? AppColors.goldBright
                              : AppColors.textMuted.withValues(alpha: 0.6),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Confirm button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedCardIndices.length == neededCount
                      ? AppColors.goldBright
                      : AppColors.glassFillStrong,
                  foregroundColor: _selectedCardIndices.length == neededCount
                      ? AppColors.backgroundDeep
                      : AppColors.textMuted,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: _selectedCardIndices.length == neededCount
                          ? AppColors.goldBright
                          : AppColors.glassBorder,
                    ),
                  ),
                ),
                onPressed: _selectedCardIndices.length == neededCount
                    ? () {
                        _sensory.completionHaptic();
                        _sensory.playRevelationSound();
                        final selectedCards = _selectedCardIndices
                            .map((i) => widget.fullDeck[i])
                            .toList();
                        widget.onCardsSelected(selectedCards);
                        Navigator.pop(context);
                      }
                    : null,
                child: Text(
                  _selectedCardIndices.length == neededCount
                      ? 'PLACE CHOSEN CARDS ON ALTAR'
                      : 'SELECT ${neededCount - _selectedCardIndices.length} MORE',
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
