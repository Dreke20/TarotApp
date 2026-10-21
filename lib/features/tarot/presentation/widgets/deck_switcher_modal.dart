import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/tarot_card_data.dart';
import '../../domain/card_deck_style.dart';
import '../../domain/tarot_card.dart';
import '../notifiers/deck_style_notifier.dart';
import 'tarot_card_widget.dart';

/// Interactive modal allowing seekers to preview and switch between
/// 5 distinct card aesthetic decks across the entire altar and codex.
class DeckSwitcherModal extends ConsumerStatefulWidget {
  const DeckSwitcherModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DeckSwitcherModal(),
    );
  }

  @override
  ConsumerState<DeckSwitcherModal> createState() => _DeckSwitcherModalState();
}

class _DeckSwitcherModalState extends ConsumerState<DeckSwitcherModal> {
  late CardDeckStyle _previewStyle;
  late final TarotCard _sampleCard;

  @override
  void initState() {
    super.initState();
    _previewStyle = ref.read(deckStyleProvider);
    // Find The Magician or The Star for the sacred preview
    _sampleCard = TarotCardData.allCards.firstWhere(
      (c) => c.id == 'major_01',
      orElse: () => TarotCardData.allCards.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentActiveStyle = ref.watch(deckStyleProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFF0F0E13),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: Color(0xFFD4AF37), width: 1.2),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DECK SANCTUARY',
                      style: GoogleFonts.cinzel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Select the visual aura of your 78 cards',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Live Card Preview in Selected Aesthetic
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Card Centerpiece with dynamic deck styling
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _previewStyle.primaryAccent.withValues(alpha: 0.25),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: TarotCardWidget(
                        card: _sampleCard,
                        isFaceUp: true,
                        width: 150,
                        height: 245,
                        deckStyleOverride: _previewStyle,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Active / Preview Deck Title & Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          _previewStyle.name,
                          style: GoogleFonts.cinzel(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: _previewStyle.primaryAccent,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _previewStyle.tagline,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _previewStyle.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Horizontal Deck Selector Carousel
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: CardDeckStyle.values.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final style = CardDeckStyle.values[index];
                        final isSelected = style == _previewStyle;
                        final isCurrentActive = style == currentActiveStyle;

                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() => _previewStyle = style);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 140,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? style.primaryAccent.withValues(alpha: 0.15)
                                  : AppColors.cosmicSurface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? style.primaryAccent
                                    : Colors.white12,
                                width: isSelected ? 1.6 : 0.8,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: style.primaryAccent,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (isCurrentActive)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1.5),
                                        decoration: BoxDecoration(
                                          color: AppColors.goldMuted.withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'ACTIVE',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 7.5,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.goldBright,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  style.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cinzel(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? style.primaryAccent
                                        : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  style.tagline,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 9.5,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom Action Bar: Consecrate Deck Button
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              12,
              20,
              MediaQuery.of(context).padding.bottom + 16,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  ref.read(deckStyleProvider.notifier).selectStyle(_previewStyle);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF1E1A25),
                      content: Row(
                        children: [
                          Icon(Icons.auto_awesome, color: _previewStyle.primaryAccent, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Consecrated ${_previewStyle.name} across the sanctuary',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: _previewStyle.primaryAccent.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _previewStyle.primaryAccent,
                  foregroundColor: Colors.black,
                  elevation: 6,
                  shadowColor: _previewStyle.primaryAccent.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  currentActiveStyle == _previewStyle
                      ? 'DECK IS ACTIVE'
                      : 'CONSECRATE DECK STYLE',
                  style: GoogleFonts.cinzel(
                    fontSize: 14,
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
