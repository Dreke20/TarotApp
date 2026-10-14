import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../data/iching_data.dart';
import '../../domain/hexagram.dart';

class IChingScreen extends StatefulWidget {
  const IChingScreen({super.key});

  @override
  State<IChingScreen> createState() => _IChingScreenState();
}

class _IChingScreenState extends State<IChingScreen> {
  final List<int> _lines = []; // 6 binary lines: 1 (Yang), 0 (Yin)
  List<int> _currentCoins = [3, 3, 3]; // 3 coins: 3 = heads (Yang), 2 = tails (Yin)
  bool _isFlipping = false;
  Hexagram? _revealedHexagram;
  final SensoryService _sensory = SensoryService();

  void _tossCoins() {
    if (_lines.length >= 6 || _isFlipping) return;

    _sensory.shuffleTremorHaptic();
    setState(() => _isFlipping = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      final random = Random();
      // Toss 3 coins: heads = 3, tails = 2
      final c1 = random.nextBool() ? 3 : 2;
      final c2 = random.nextBool() ? 3 : 2;
      final c3 = random.nextBool() ? 3 : 2;
      final sum = c1 + c2 + c3; // Sum is 6 (old Yin), 7 (young Yang), 8 (young Yin), 9 (old Yang)

      // 7 or 9 = Yang (1), 6 or 8 = Yin (0)
      final line = (sum % 2 == 1) ? 1 : 0;
      final updatedLines = [..._lines, line];

      Hexagram? finalHex;
      if (updatedLines.length == 6) {
        finalHex = IChingData.resolveHexagram(updatedLines);
        _sensory.cardFlipHaptic();
      } else {
        _sensory.cardSelectionHaptic();
      }

      setState(() {
        _currentCoins = [c1, c2, c3];
        _lines.add(line);
        _isFlipping = false;
        _revealedHexagram = finalHex;
      });
    });
  }

  void _resetToss() {
    _sensory.cardSelectionHaptic();
    setState(() {
      _lines.clear();
      _currentCoins = [3, 3, 3];
      _revealedHexagram = null;
      _isFlipping = false;
    });
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
          'I CHING • BOOK OF CHANGES',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
        actions: [
          if (_lines.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
              tooltip: 'New Toss',
              onPressed: _resetToss,
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.2),
            radius: 1.2,
            colors: [
              const Color(0xFF20162A),
              AppColors.backgroundDeep,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // Coin visualization
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _currentCoins.map((coinVal) {
                        final isHeads = coinVal == 3;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [Color(0xFFE5C158), Color(0xFF8B6508)],
                              ),
                              border: Border.all(color: AppColors.goldBright, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.goldBright.withValues(alpha: 0.3),
                                  blurRadius: 16,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF4A3403), width: 1.5),
                                  color: const Color(0xFF684903),
                                ),
                                child: Center(
                                  child: Text(
                                    isHeads ? '陽' : '陰',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldBright,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ).animate(target: _isFlipping ? 1 : 0).shake(duration: 400.ms),

                    const SizedBox(height: 18),

                    Text(
                      _lines.length < 6
                          ? 'TOSS ${_lines.length + 1} OF 6'
                          : 'HEXAGRAM ${_revealedHexagram?.number ?? ""} COMPLETE',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _lines.length < 6
                          ? 'Three bronze coins are cast to divine the changing lines from earth to heaven'
                          : 'The Tao has spoken through the ancient King Wen sequence',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Hexagram 6-Lines building container (rendered top line [5] to bottom line [0])
                    GlassContainer(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                      borderRadius: 20,
                      child: Column(
                        children: List.generate(6, (visualIndex) {
                          // Visual order: line 6 (top) down to line 1 (bottom)
                          final lineIndex = 5 - visualIndex;
                          final hasDrawn = lineIndex < _lines.length;
                          final isYang = hasDrawn && _lines[lineIndex] == 1;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 28,
                                  child: Text(
                                    '${lineIndex + 1}',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 10,
                                      color: hasDrawn ? AppColors.goldBright : AppColors.textMuted,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (!hasDrawn) ...[
                                  Container(
                                    width: 160,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppColors.glassFillStrong,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: AppColors.glassBorder),
                                    ),
                                  ),
                                ] else if (isYang) ...[
                                  // Yang: Solid line
                                  Container(
                                    width: 160,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppColors.goldBright,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.goldBright.withValues(alpha: 0.5),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                  ).animate().fadeIn(duration: 300.ms).scaleX(begin: 0.2, end: 1.0),
                                ] else ...[
                                  // Yin: Broken line
                                  Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: AppColors.etherealLavender,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                        width: 70,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: AppColors.etherealLavender,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ],
                                  ).animate().fadeIn(duration: 300.ms),
                                ],
                              ],
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Revealed Hexagram Information Card
                    if (_revealedHexagram != null) ...[
                      GlassContainer(
                        padding: const EdgeInsets.all(20),
                        borderRadius: 22,
                        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.85),
                        borderColor: AppColors.goldBright,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _revealedHexagram!.chineseCharacter,
                                      style: GoogleFonts.cinzel(
                                        fontSize: 34,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.goldBright,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'HEXAGRAM ${_revealedHexagram!.number}',
                                          style: GoogleFonts.cinzel(
                                            fontSize: 10,
                                            color: AppColors.goldBright,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          _revealedHexagram!.englishTitle.toUpperCase(),
                                          style: GoogleFonts.cinzel(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.glassFill,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.glassBorder),
                                  ),
                                  child: Text(
                                    '${_revealedHexagram!.upperTrigram} / ${_revealedHexagram!.lowerTrigram}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      color: AppColors.etherealLavender,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: AppColors.glassBorder, height: 24),
                            Text(
                              'THE JUDGMENT',
                              style: GoogleFonts.cinzel(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _revealedHexagram!.judgment,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.5,
                                color: AppColors.textPrimary,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'THE IMAGE',
                              style: GoogleFonts.cinzel(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _revealedHexagram!.image,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontStyle: FontStyle.italic,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'COSMIC GUIDANCE',
                              style: GoogleFonts.cinzel(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _revealedHexagram!.guidance,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.5,
                                color: AppColors.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom Toss Button
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
                        onPressed: _isFlipping
                            ? null
                            : (_lines.length < 6 ? _tossCoins : _resetToss),
                        icon: const Icon(Icons.change_circle_outlined, size: 18),
                        label: Text(
                          _lines.length < 6 ? 'TOSS THREE BRONZE COINS' : 'COMMENCE NEW TOSS',
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
}
