import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/celestial_voice_service.dart';
import '../../data/card_synergy_service.dart';
import '../../domain/card_pair_synergy.dart';
import '../../domain/tarot_card.dart';
import 'glass_container.dart';
import 'tarot_card_widget.dart';

/// Modal dialog displaying the deep alchemical synergy and elemental tension
/// between two tarot cards from the seeker's spread.
class CardSynergyModal extends StatefulWidget {
  final List<TarotCard> spreadCards;
  final TarotCard initialCard1;
  final TarotCard initialCard2;

  const CardSynergyModal({
    super.key,
    required this.spreadCards,
    required this.initialCard1,
    required this.initialCard2,
  });

  static Future<void> show(
    BuildContext context, {
    required List<TarotCard> spreadCards,
    required TarotCard card1,
    required TarotCard card2,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CardSynergyModal(
        spreadCards: spreadCards,
        initialCard1: card1,
        initialCard2: card2,
      ),
    );
  }

  @override
  State<CardSynergyModal> createState() => _CardSynergyModalState();
}

class _CardSynergyModalState extends State<CardSynergyModal> {
  late TarotCard _card1;
  late TarotCard _card2;
  late List<CardPairSynergy> _allPairs;
  int _selectedPairIndex = 0;
  bool _isPlayingVoice = false;

  @override
  void initState() {
    super.initState();
    _card1 = widget.initialCard1;
    _card2 = widget.initialCard2;
    _allPairs = CardSynergyService.generateAllPairs(widget.spreadCards);

    CelestialVoiceService.instance.init();
    CelestialVoiceService.instance.onStarted = () {
      if (mounted) setState(() => _isPlayingVoice = true);
    };
    CelestialVoiceService.instance.onStopped = () {
      if (mounted) setState(() => _isPlayingVoice = false);
    };

    // Find if the initial pair matches any generated pair
    for (int i = 0; i < _allPairs.length; i++) {
      final p = _allPairs[i];
      if ((p.firstCard.id == _card1.id && p.secondCard.id == _card2.id) ||
          (p.firstCard.id == _card2.id && p.secondCard.id == _card1.id)) {
        _selectedPairIndex = i;
        _card1 = p.firstCard;
        _card2 = p.secondCard;
        break;
      }
    }
  }

  @override
  void dispose() {
    CelestialVoiceService.instance.stop();
    super.dispose();
  }

  void _onSelectPair(int index) {
    if (index >= 0 && index < _allPairs.length) {
      setState(() {
        _selectedPairIndex = index;
        _card1 = _allPairs[index].firstCard;
        _card2 = _allPairs[index].secondCard;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final synergy = _allPairs.isNotEmpty
        ? _allPairs[_selectedPairIndex]
        : CardSynergyService.synthesize(_card1, _card2);

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.90,
      ),
      margin: const EdgeInsets.only(top: 24),
      child: GlassContainer(
        borderRadius: 28,
        blur: 24,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.96),
        borderColor: AppColors.goldBright.withValues(alpha: 0.4),
        borderWidth: 1.5,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Header title & close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: AppColors.goldBright,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ALCHEMICAL SYNERGY',
                          style: GoogleFonts.cinzel(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'DUAL-CARD RESONANCE & POLARITY',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.etherealLavender,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: AppColors.glassBorder, height: 20),

            // Pair switch carousel if more than 1 pair exists
            if (_allPairs.length > 1) ...[
              SizedBox(
                height: 34,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _allPairs.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final pair = _allPairs[index];
                    final isSelected = index == _selectedPairIndex;
                    return GestureDetector(
                      onTap: () => _onSelectPair(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.goldBright.withValues(alpha: 0.2)
                              : AppColors.glassFill,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Text(
                          '${pair.firstCard.name} + ${pair.secondCard.name}',
                          style: GoogleFonts.cinzel(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppColors.goldBright : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Dual Cards Visual Arena
                    _buildDualCardVisualArena(synergy),
                    const SizedBox(height: 18),

                    // Alchemical Phase Banner
                    _buildPhaseBanner(synergy),
                    const SizedBox(height: 16),

                    // Title & Tension Matrix
                    Text(
                      synergy.alchemicalTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        height: 1.3,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Reaction & Harmony score
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.cosmicSurface.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            synergy.elementalReaction,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${synergy.tensionType.toUpperCase()}: ',
                                style: GoogleFonts.cinzel(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.etherealLavender,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (i) => Icon(
                                    i < synergy.harmonyScore ? Icons.star : Icons.star_border,
                                    size: 13,
                                    color: AppColors.goldBright,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Synthesis Insight Narrative
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.glassFill,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.hub, size: 16, color: AppColors.goldBright),
                              const SizedBox(width: 8),
                              Text(
                                'ARCHETYPAL SYNTHESIS',
                                style: GoogleFonts.cinzel(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.goldBright,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            synergy.synthesisInsight,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5,
                              color: AppColors.textPrimary,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Dual-Card Voice Narration
                    GestureDetector(
                      onTap: () async {
                        final voice = CelestialVoiceService.instance;
                        if (_isPlayingVoice) {
                          await voice.stop();
                        } else {
                          await voice.speakDualCardSynergy(
                            cardAName: synergy.firstCard.name,
                            cardBName: synergy.secondCard.name,
                            title: synergy.alchemicalTitle,
                            synergyNarrative: synergy.synthesisInsight,
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isPlayingVoice
                              ? const Color(0xFFD4AF37).withValues(alpha: 0.2)
                              : AppColors.glassFill,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isPlayingVoice
                                ? const Color(0xFFFFD700)
                                : AppColors.glassBorder,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isPlayingVoice ? Icons.waves_rounded : Icons.record_voice_over,
                              color: const Color(0xFFFFD700),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isPlayingVoice
                                  ? 'NARRATING ALCHEMICAL CONJUNCTION...'
                                  : '✦ HEAR ALCHEMICAL CONJUNCTION ✦',
                              style: GoogleFonts.cinzel(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFD700),
                                letterSpacing: 0.8,
                              ),
                            ),
                            if (_isPlayingVoice) ...[
                              const SizedBox(width: 8),
                              const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(Color(0xFFFFD700)),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sacred Alchemical Formula
                    GlassContainer(
                      padding: const EdgeInsets.all(14),
                      borderRadius: 16,
                      fillColor: AppColors.purpleDeep.withValues(alpha: 0.4),
                      borderColor: AppColors.etherealLavender.withValues(alpha: 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.science, size: 16, color: AppColors.etherealLavender),
                              const SizedBox(width: 8),
                              Text(
                                'ALCHEMICAL INTEGRATION PROTOCOL',
                                style: GoogleFonts.cinzel(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.etherealLavender,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            synergy.actionableFormula,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontStyle: FontStyle.italic,
                              color: AppColors.goldBright,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDualCardVisualArena(CardPairSynergy synergy) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.glassFillStrong,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBorderGlow.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Card 1
          _buildCardColumn(synergy.firstCard, synergy.element1),

          // Central Energetic Thread Beam
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundMidnight,
                  border: Border.all(color: AppColors.goldBright, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldBright.withValues(alpha: 0.35),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '∞',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                    ),
                  ),
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 1200.ms),
              const SizedBox(height: 6),
              Text(
                'RESONANCE',
                style: GoogleFonts.cinzel(
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.etherealLavender,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),

          // Card 2
          _buildCardColumn(synergy.secondCard, synergy.element2),
        ],
      ),
    );
  }

  Widget _buildCardColumn(TarotCard card, String element) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TarotCardWidget(
          card: card,
          isFaceUp: true,
          width: 82,
          height: 122,
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 90,
          child: Text(
            card.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cinzel(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getElementColor(element).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _getElementColor(element).withValues(alpha: 0.5)),
          ),
          child: Text(
            element.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: _getElementColor(element),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhaseBanner(CardPairSynergy synergy) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1735),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.brightness_medium, size: 14, color: AppColors.goldBright),
          const SizedBox(width: 8),
          Text(
            synergy.alchemicalPhase.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Color _getElementColor(String element) {
    switch (element.toLowerCase()) {
      case 'fire':
        return const Color(0xFFFF6B6B);
      case 'water':
        return const Color(0xFF4D96FF);
      case 'air':
        return const Color(0xFF6BCB77);
      case 'earth':
        return const Color(0xFFFFD93D);
      default:
        return AppColors.goldBright;
    }
  }
}
