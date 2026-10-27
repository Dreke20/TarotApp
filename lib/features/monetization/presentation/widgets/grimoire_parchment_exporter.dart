import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../tarot/domain/reading.dart';

/// Modal dialog presenting a high-fidelity ancient parchment manuscript
/// ready for physical printing or social sharing via system share sheet.
class GrimoireParchmentExporter extends StatelessWidget {
  final Reading reading;

  const GrimoireParchmentExporter({super.key, required this.reading});

  static Future<void> show(BuildContext context, {required Reading reading}) {
    HapticFeedback.lightImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GrimoireParchmentExporter(reading: reading),
    );
  }

  String _generateParchmentText() {
    final buffer = StringBuffer();
    buffer.writeln('✦ SACRED GRIMOIRE TRANSCRIPT · ORACULUM TAROT ✦');
    buffer.writeln('═════════════════════════════════════════════════');
    buffer.writeln('Seeker Question: "${reading.question}"');
    buffer.writeln('Spread: ${reading.spreadType.toUpperCase()}');
    buffer.writeln('Inscribed: ${reading.createdAt.toLocal().toString().split('.').first}');
    buffer.writeln('─────────────────────────────────────────────────');
    buffer.writeln('DIVINED CARDS:');
    for (int i = 0; i < reading.cards.length; i++) {
      final card = reading.cards[i];
      final orientation = card.isReversed ? 'Reversed' : 'Upright';
      buffer.writeln('${i + 1}. ${card.name} ($orientation · ${card.arcana.toUpperCase()})');
    }
    buffer.writeln('─────────────────────────────────────────────────');
    buffer.writeln('AI ORACLE PROPHECY:');
    buffer.writeln(reading.interpretation);
    buffer.writeln('═════════════════════════════════════════════════');
    buffer.writeln('Channeled via Oraculum: Sacred AI Tarot');
    return buffer.toString();
  }

  void _shareParchment(BuildContext context) {
    HapticFeedback.mediumImpact();
    final text = _generateParchmentText();
    SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: 'My Sacred Tarot Grimoire: "${reading.question}"',
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    HapticFeedback.selectionClick();
    final text = _generateParchmentText();
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '📜 Sacred Grimoire copied to clipboard.',
          style: GoogleFonts.plusJakartaSans(color: AppColors.goldBright),
        ),
        backgroundColor: const Color(0xFF160E26),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFF13101C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: Color(0xFFD4AF37), width: 1.5),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              children: [
                const Text('📜', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SACRED GRIMOIRE MANUSCRIPT',
                        style: GoogleFonts.cinzel(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: AppColors.goldBright,
                        ),
                      ),
                      Text(
                        'Parchment export for printing & eternal remembrance',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white60),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white12, height: 1),

          // Parchment Paper Preview
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      // Antique aged parchment parchment paper aesthetic
                      color: const Color(0xFFF7F1E1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFB8860B), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Ornate top seal
                        Text(
                          '✧ ✦ ✧',
                          style: GoogleFonts.cinzel(
                            fontSize: 18,
                            color: const Color(0xFF6B4423),
                            letterSpacing: 4.0,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'ORACULUM SANCTUM',
                          style: GoogleFonts.cinzel(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                            color: const Color(0xFF3E2723),
                          ),
                        ),
                        Text(
                          'BOOK OF VISIONS & SHADOWS',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            letterSpacing: 1.5,
                            color: const Color(0xFF6D4C41),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Divider(color: Color(0xFFBCAAA4), thickness: 1.2),
                        const SizedBox(height: 14),

                        // Query
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'SEEKER INVOCATION:',
                            style: GoogleFonts.cinzel(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: const Color(0xFF5D4037),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '"${reading.question}"',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1B1B1B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Cards Drawn
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'DIVINED CARDS & POSITIONS:',
                            style: GoogleFonts.cinzel(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: const Color(0xFF5D4037),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...reading.cards.asMap().entries.map((entry) {
                          final idx = entry.key + 1;
                          final card = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Text(
                                  '• Card $idx: ',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF4E342E),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${card.name} — ${card.isReversed ? "Reversed" : "Upright"} (${card.arcana.toUpperCase()})',
                                    style: GoogleFonts.cormorantGaramond(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2E1C14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 16),
                        const Divider(color: Color(0xFFBCAAA4), thickness: 1),
                        const SizedBox(height: 14),

                        // AI Interpretation
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'CHANNELED AI PROPHECY:',
                            style: GoogleFonts.cinzel(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: const Color(0xFF5D4037),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          reading.interpretation,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 15,
                            height: 1.5,
                            color: const Color(0xFF261815),
                          ),
                          textAlign: TextAlign.justify,
                        ),

                        const SizedBox(height: 20),
                        // Bottom wax seal stamp
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF8D6E63)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'CONSECRATED & SEALED IN ORACULUM',
                            style: GoogleFonts.cinzel(
                              fontSize: 9,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF5D4037),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Actions Bar
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + mediaQuery.padding.bottom),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.goldMuted,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: const Icon(Icons.copy, size: 18),
                    label: Text(
                      'COPY TRANSCRIPT',
                      style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _copyToClipboard(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.goldBright,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: const Icon(Icons.share, size: 18),
                    label: Text(
                      'SHARE GRIMOIRE',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    onPressed: () => _shareParchment(context),
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
