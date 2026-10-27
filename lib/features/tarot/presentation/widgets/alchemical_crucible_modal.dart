import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarot_app/core/constants/app_colors.dart';
import '../../../../core/services/celestial_voice_service.dart';
import '../../data/card_synergy_service.dart';
import '../../domain/card_pair_synergy.dart';
import '../../domain/tarot_card.dart';
import 'glass_container.dart';

/// Interactive modal allowing seekers to drop any two drawn cards into the Alchemical Crucible,
/// computing elemental fusion, chemical dignity, and speaking the conjunction.
class AlchemicalCrucibleModal extends ConsumerStatefulWidget {
  final List<TarotCard> drawnCards;

  const AlchemicalCrucibleModal({
    super.key,
    required this.drawnCards,
  });

  static Future<void> show(BuildContext context, {required List<TarotCard> drawnCards}) {
    if (drawnCards.length < 2) return Future.value();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AlchemicalCrucibleModal(drawnCards: drawnCards),
    );
  }

  @override
  ConsumerState<AlchemicalCrucibleModal> createState() => _AlchemicalCrucibleModalState();
}

class _AlchemicalCrucibleModalState extends ConsumerState<AlchemicalCrucibleModal>
    with SingleTickerProviderStateMixin {
  late int _firstCardIndex;
  late int _secondCardIndex;
  late AnimationController _crucibleAnim;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _firstCardIndex = 0;
    _secondCardIndex = widget.drawnCards.length > 1 ? 1 : 0;
    _crucibleAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _crucibleAnim.dispose();
    CelestialVoiceService.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card1 = widget.drawnCards[_firstCardIndex];
    final card2 = widget.drawnCards[_secondCardIndex];
    final synergy = CardSynergyService.synthesize(card1, card2);

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F0B1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Color(0x99000000),
                blurRadius: 30,
                offset: Offset(0, -10),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
            children: [
              // Handle Drag Bar
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Title Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ALCHEMICAL CRUCIBLE',
                          style: GoogleFonts.cinzel(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 1.4,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Dual-Card Elemental Transmutation & Archetypal Synthesis',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Card Selector Pills (If more than 2 cards are drawn)
              if (widget.drawnCards.length > 2) ...[
                Text(
                  'SELECT CARDS TO TRANSMUTE',
                  style: GoogleFonts.cinzel(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.etherealLavender,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                _buildCardSelectorRow(),
                const SizedBox(height: 18),
              ],

              // Central Fusion Arena: Card 1 + Crucible + Card 2
              _buildFusionArena(card1, card2, synergy),

              const SizedBox(height: 20),

              // Synthesis Details Card
              _buildSynthesisDetails(synergy),

              const SizedBox(height: 22),

              // Hear Alchemical Conjunction Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E1B4E),
                  foregroundColor: AppColors.goldBright,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.goldBright, width: 1.2),
                  ),
                ),
                onPressed: () async {
                  HapticFeedback.heavyImpact();
                  if (_isSpeaking) {
                    await CelestialVoiceService.instance.stop();
                    setState(() => _isSpeaking = false);
                  } else {
                    setState(() => _isSpeaking = true);
                    await CelestialVoiceService.instance.speakDualCardSynergy(
                      cardAName: card1.name,
                      cardBName: card2.name,
                      title: synergy.alchemicalTitle,
                      synergyNarrative: synergy.synthesisInsight,
                    );
                    if (mounted) setState(() => _isSpeaking = false);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isSpeaking ? '⏹' : '⚡',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isSpeaking ? 'STOP SPOKEN TRANSMUTATION' : '✦ HEAR ALCHEMICAL CONJUNCTION ✦',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCardSelectorRow() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.drawnCards.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, idx) {
          final isFirst = idx == _firstCardIndex;
          final isSecond = idx == _secondCardIndex;
          final isSelected = isFirst || isSecond;

          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                if (isFirst) return;
                if (isSecond) {
                  _secondCardIndex = _firstCardIndex;
                  _firstCardIndex = idx;
                } else {
                  _secondCardIndex = idx;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isFirst ? const Color(0xFFFFD700) : const Color(0xFF8AB4F8)).withValues(alpha: 0.2)
                    : const Color(0xFF1E1638),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? (isFirst ? const Color(0xFFFFD700) : const Color(0xFF8AB4F8))
                      : AppColors.glassBorder,
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    isFirst ? '☀️ ' : (isSecond ? '🌙 ' : ''),
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    widget.drawnCards[idx].name,
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFusionArena(TarotCard card1, TarotCard card2, CardPairSynergy synergy) {
    return GlassContainer(
      borderRadius: 22,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      borderColor: AppColors.goldBright.withValues(alpha: 0.35),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Card 1 Pillar
              _buildCardMiniColumn(card1, '☀️ PRIMA', const Color(0xFFFFD700)),

              // Animated Crucible Cauldron
              AnimatedBuilder(
                animation: _crucibleAnim,
                builder: (context, _) {
                  final scale = 1.0 + 0.08 * sin(_crucibleAnim.value * 2 * pi);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.goldBright,
                            const Color(0xFF9B51E0),
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.goldBright.withValues(alpha: 0.3),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text('⚡', style: TextStyle(fontSize: 24)),
                    ),
                  );
                },
              ),

              // Card 2 Pillar
              _buildCardMiniColumn(card2, '🌙 SECUNDA', const Color(0xFF8AB4F8)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            synergy.alchemicalTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Phase: ${synergy.alchemicalPhase} · Harmony: ${synergy.harmonyScore}%',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: AppColors.etherealLavender,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardMiniColumn(TarotCard card, String role, Color accentColor) {
    final asset = card.assetPath ?? 'assets/cards/${card.id}.webp';
    return Column(
      children: [
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accentColor, width: 1.4),
            image: DecorationImage(
              image: AssetImage(asset),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.3),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          role,
          style: GoogleFonts.cinzel(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: accentColor,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 90,
          child: Text(
            card.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSynthesisDetails(CardPairSynergy synergy) {
    return GlassContainer(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      borderColor: AppColors.glassBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ELEMENTAL CONFLUENCE',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.etherealLavender,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.goldBright.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${synergy.element1} + ${synergy.element2}',
                  style: GoogleFonts.cinzel(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            synergy.synthesisInsight,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              height: 1.4,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.glassBorder, height: 1),
          const SizedBox(height: 12),
          Text(
            'ALCHEMICAL PRESCRIPTION',
            style: GoogleFonts.cinzel(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            synergy.actionableFormula,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: AppColors.goldMuted,
            ),
          ),
        ],
      ),
    );
  }
}
