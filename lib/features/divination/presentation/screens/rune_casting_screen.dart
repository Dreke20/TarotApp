import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../data/rune_data.dart';
import '../../domain/rune.dart';

enum RuneSpreadType {
  single('Odin\'s Eye', 1, ['The Single Rune']),
  threeNorns('The Three Norns', 3, ['I. Urd (Past / Origin)', 'II. Verdandi (Present / Flow)', 'III. Skuld (Future / Becoming)']);

  final String title;
  final int count;
  final List<String> positions;
  const RuneSpreadType(this.title, this.count, this.positions);
}

class RuneCastingScreen extends StatefulWidget {
  const RuneCastingScreen({super.key});

  @override
  State<RuneCastingScreen> createState() => _RuneCastingScreenState();
}

class _RuneCastingScreenState extends State<RuneCastingScreen> {
  RuneSpreadType _spreadType = RuneSpreadType.threeNorns;
  List<Rune> _castRunes = [];
  final Set<int> _revealed = {};
  bool _isCasting = false;
  final SensoryService _sensory = SensoryService();

  void _castRunesFromPouch() {
    _sensory.shuffleTremorHaptic();
    setState(() {
      _isCasting = true;
      _castRunes.clear();
      _revealed.clear();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      final random = Random();
      final pool = List<Rune>.from(RuneData.allRunes)..shuffle(random);
      final drawn = <Rune>[];

      for (int i = 0; i < _spreadType.count; i++) {
        final isReversed = random.nextBool();
        final rune = pool[i].copyWith(
          isReversed: isReversed,
          positionName: _spreadType.positions[i],
        );
        drawn.add(rune);
      }

      setState(() {
        _castRunes = drawn;
        _isCasting = false;
      });
      _sensory.cardFlipHaptic();
    });
  }

  void _revealRune(int index) {
    if (!_revealed.contains(index)) {
      _sensory.cardFlipHaptic();
      setState(() {
        _revealed.add(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.goldBright),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'ELDER FUTHARK RUNES',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.3),
            radius: 1.2,
            colors: [
              AppColors.backgroundViolet.withValues(alpha: 0.6),
              AppColors.backgroundDeep,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Column(
              children: [
                // Spread selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: RuneSpreadType.values.map((type) {
                  final isSelected = _spreadType == type;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _spreadType = type;
                          _castRunes.clear();
                          _revealed.clear();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.goldBright : AppColors.glassFill,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
                          ),
                        ),
                        child: Text(
                          type.title.toUpperCase(),
                          style: GoogleFonts.cinzel(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? AppColors.backgroundDeep : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // Rune casting stones altar area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (_castRunes.isEmpty) ...[
                      const SizedBox(height: 40),
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cosmicSurface.withValues(alpha: 0.5),
                          border: Border.all(color: AppColors.goldBright, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.goldBright.withValues(alpha: 0.25),
                              blurRadius: 30,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'ᚦ',
                            style: GoogleFonts.cinzel(
                              fontSize: 64,
                              color: AppColors.goldBright,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                          .scale(begin: const Offset(0.97, 0.97), end: const Offset(1.03, 1.03), duration: 2.seconds),
                      const SizedBox(height: 24),
                      Text(
                        'THE RUNIC ALTAR',
                        style: GoogleFonts.cinzel(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Reach into the sacred deerskin pouch and draw the carved stone wisdom of the Norse ancestors.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 10),
                      Text(
                        'TAP EACH STONE TO REVEAL ITS INSCRIPTION',
                        style: GoogleFonts.cinzel(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.etherealLavender,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Cast stones row
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: List.generate(_castRunes.length, (index) {
                          final rune = _castRunes[index];
                          final isFlipped = _revealed.contains(index);

                          return GestureDetector(
                            onTap: () => _revealRune(index),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.glassFillStrong,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.glassBorder),
                                  ),
                                  child: Text(
                                    rune.positionName ?? 'Position ${index + 1}',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 9,
                                      color: AppColors.goldBright,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildRuneStone(rune, isFlipped),
                              ],
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 24),

                      // Detailed revelation cards for revealed runes
                      ...List.generate(_castRunes.length, (index) {
                        if (!_revealed.contains(index)) return const SizedBox.shrink();
                        final rune = _castRunes[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: GlassContainer(
                            borderRadius: 18,
                            padding: const EdgeInsets.all(16),
                            fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.8),
                            borderColor: AppColors.goldBright.withValues(alpha: 0.5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rune.symbol,
                                  style: GoogleFonts.cinzel(
                                    fontSize: 38,
                                    color: AppColors.goldBright,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${rune.name.toUpperCase()} (${rune.isReversed ? "Merkstave" : "Upright"})',
                                            style: GoogleFonts.cinzel(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.goldBright,
                                            ),
                                          ),
                                          Text(
                                            rune.englishMeaning,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 10.5,
                                              color: AppColors.etherealLavender,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        rune.isReversed ? rune.reversedMeaning : rune.uprightMeaning,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          color: AppColors.textPrimary,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
                        );
                      }),
                    ],

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom cast button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 380),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.goldBright,
                          foregroundColor: AppColors.backgroundDeep,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 6,
                        ),
                        onPressed: _isCasting ? null : _castRunesFromPouch,
                        icon: const Icon(Icons.auto_awesome, size: 18),
                        label: Text(
                          _castRunes.isEmpty ? 'CAST THE RUNES' : 'CAST AGAIN',
                          style: GoogleFonts.cinzel(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
}

  Widget _buildRuneStone(Rune rune, bool isFlipped) {
    return Container(
      width: 95,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isFlipped
              ? [const Color(0xFF2A2B36), const Color(0xFF14151D)]
              : [const Color(0xFF1F202B), const Color(0xFF0D0E14)],
        ),
        border: Border.all(
          color: isFlipped ? AppColors.goldBright : AppColors.glassBorder,
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: isFlipped
                ? AppColors.goldBright.withValues(alpha: 0.35)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: isFlipped ? 18 : 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: isFlipped
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    rune.symbol,
                    style: GoogleFonts.cinzel(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                      shadows: [
                        Shadow(
                          color: AppColors.goldBright.withValues(alpha: 0.7),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rune.name.toUpperCase(),
                    style: GoogleFonts.cinzel(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              )
            : const Icon(
                Icons.shield,
                size: 28,
                color: AppColors.textMuted,
              ),
      ),
    );
  }
}
