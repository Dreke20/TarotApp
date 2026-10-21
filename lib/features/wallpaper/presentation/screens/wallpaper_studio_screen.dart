import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/lunar_calculator.dart';
import '../../../tarot/data/tarot_card_data.dart';
import '../../../tarot/domain/tarot_card.dart';
import '../../../tarot/presentation/widgets/tarot_card_widget.dart';
import '../../domain/wallpaper_config.dart';

/// The Sacred Lock Screen & Phone Wallpaper Studio:
/// Allows seekers to customize, preview, and forge ultra-high-resolution (4K)
/// lock screen & home screen wallpapers adorned with 24k gold sacred geometry,
/// live lunar ephemeris, and oracular affirmations.
class WallpaperStudioScreen extends ConsumerStatefulWidget {
  final TarotCard? initialCard;
  final bool isReversed;

  const WallpaperStudioScreen({
    super.key,
    this.initialCard,
    this.isReversed = false,
  });

  static Future<void> show(
    BuildContext context, {
    TarotCard? card,
    bool isReversed = false,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WallpaperStudioScreen(
          initialCard: card,
          isReversed: isReversed,
        ),
      ),
    );
  }

  @override
  ConsumerState<WallpaperStudioScreen> createState() =>
      _WallpaperStudioScreenState();
}

class _WallpaperStudioScreenState extends ConsumerState<WallpaperStudioScreen> {
  final GlobalKey _repaintKey = GlobalKey();

  late TarotCard _selectedCard;
  late bool _isReversed;
  WallpaperAspectRatio _aspectRatio = WallpaperAspectRatio.modern;
  WallpaperTheme _theme = WallpaperTheme.imperialGold;

  bool _showClockMock = false;
  bool _showLunarBadge = true;
  bool _showAffirmation = true;
  bool _showSacredGeometry = true;

  bool _isExporting = false;
  String? _customAffirmation;

  static const List<String> _sacredMantras = [
    'I align with infinite divine abundance and grounded clarity.',
    'I trust the unseen cosmic unfolding with unwavering peace.',
    'Ancient wisdom guides my every step through the threshold.',
    'My inner flame illuminates the darkest hidden truths.',
    'Every obstacle dissolves into spiritual mastery and grace.',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCard = widget.initialCard ??
        TarotCardData.allCards.firstWhere(
          (c) => c.id == 'major_17', // The Star
          orElse: () => TarotCardData.allCards.first,
        );
    _isReversed = widget.isReversed;
    _customAffirmation = _sacredMantras.first;
  }

  Future<void> _exportWallpaper() async {
    setState(() => _isExporting = true);
    HapticFeedback.heavyImpact();

    try {
      final boundary =
          _repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        throw Exception('Render boundary unavailable');
      }

      // Generate ultra-high-resolution 4K wallpaper with pixelRatio 3.5
      final ui.Image image = await boundary.toImage(pixelRatio: 3.5);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to convert image to bytes');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              pngBytes,
              mimeType: 'image/png',
              name: 'oraculum_wallpaper_${_selectedCard.id}.png',
            ),
          ],
          text: '✦ Sacred Wallpaper consecrated with Oraculum • ${_selectedCard.name} ✦',
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF1E1A25),
            content: Row(
              children: [
                Icon(Icons.check_circle, color: _theme.accentColor, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Sacred 4K wallpaper generated successfully!',
                    style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  ),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: _theme.accentColor.withValues(alpha: 0.5)),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade900,
            content: Text('Export error: $e'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09080E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.goldBright, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'SACRED WALLPAPER STUDIO',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Export 4K Wallpaper',
            icon: _isExporting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.goldBright),
                  )
                : const Icon(Icons.download_rounded, color: AppColors.goldBright),
            onPressed: _isExporting ? null : _exportWallpaper,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Centered Live Wallpaper Interactive Preview
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: AspectRatio(
                    aspectRatio: _aspectRatio.ratio,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _theme.accentColor.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _theme.accentColor.withValues(alpha: 0.2),
                            blurRadius: 30,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: RepaintBoundary(
                          key: _repaintKey,
                          child: _buildWallpaperCanvas(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Customization Control Deck
            _buildControlDeck(),
          ],
        ),
      ),
    );
  }

  Widget _buildWallpaperCanvas() {
    final lunar = LunarCalculator.getTodayLunarInfo();
    final now = DateTime.now();
    final timeStr = DateFormat('HH:mm').format(now);
    final dateStr = DateFormat('EEEE, MMMM d').format(now);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _theme.gradientColors,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Custom Sacred Geometry Canvas
          if (_showSacredGeometry)
            CustomPaint(
              painter: _SacredGeometryPainter(
                accentColor: _theme.accentColor,
                secondaryAccent: _theme.secondaryAccent,
              ),
            ),

          // 2. Ambient Radial Glow behind Card
          Center(
            child: Container(
              width: 220,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _theme.accentColor.withValues(alpha: 0.3),
                    blurRadius: 70,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // 3. Optional Clock Mockup (Preview lock screen overlay)
          if (_showClockMock)
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Icon(Icons.lock_outline, color: Colors.white.withValues(alpha: 0.6), size: 16),
                  const SizedBox(height: 6),
                  Text(
                    timeStr,
                    style: GoogleFonts.cinzel(
                      fontSize: 48,
                      fontWeight: FontWeight.w200,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    dateStr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.7),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),

          // 4. Centerpiece Tarot Card
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: _showClockMock ? 40 : 0,
                bottom: _showAffirmation ? 40 : 0,
              ),
              child: TarotCardWidget(
                card: _selectedCard.copyWith(isReversed: _isReversed),
                isFaceUp: true,
                width: 145,
                height: 235,
              ),
            ),
          ),

          // 5. Lunar Phase Badge
          if (_showLunarBadge)
            Positioned(
              top: _showClockMock ? 145 : 32,
              left: 20,
              right: 20,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _theme.accentColor.withValues(alpha: 0.4),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lunar.phase.symbol,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${lunar.phase.title.toUpperCase()} • ${lunar.moonZodiac.toUpperCase()}',
                        style: GoogleFonts.cinzel(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: _theme.accentColor,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 6. Bottom Affirmation Plaque
          if (_showAffirmation && _customAffirmation != null)
            Positioned(
              bottom: 32,
              left: 24,
              right: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedCard.name.toUpperCase(),
                    style: GoogleFonts.cinzel(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _theme.accentColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _theme.accentColor.withValues(alpha: 0.3),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      '“$_customAffirmation”',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '✦ ORACULUM ASTRAL GUIDANCE ✦',
                    style: GoogleFonts.cinzel(
                      fontSize: 7.5,
                      fontWeight: FontWeight.w600,
                      color: _theme.accentColor.withValues(alpha: 0.6),
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControlDeck() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Color(0xFF110F18),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(top: BorderSide(color: Color(0xFF2A2338), width: 1.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: Aspect Ratio Tabs
          Row(
            children: [
              Text(
                'RATIO',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 10),
              ...WallpaperAspectRatio.values.map((ratio) {
                final isSelected = _aspectRatio == ratio;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      ratio.label,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.black : Colors.white70,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: _theme.accentColor,
                    backgroundColor: AppColors.cosmicSurface,
                    onSelected: (_) => setState(() => _aspectRatio = ratio),
                  ),
                );
              }),
            ],
          ),

          const SizedBox(height: 8),

          // Row 2: Theme Selector & Toggles
          Row(
            children: [
              Text(
                'THEME',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: WallpaperTheme.values.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 6),
                    itemBuilder: (context, index) {
                      final theme = WallpaperTheme.values[index];
                      final isSelected = _theme == theme;
                      return GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() => _theme = theme);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.accentColor.withValues(alpha: 0.2)
                                : AppColors.cosmicSurface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ? theme.accentColor : Colors.white12,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.accentColor,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                theme.name,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10.5,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? theme.accentColor : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Row 3: Toggle Overlays & Export Button
          Row(
            children: [
              _buildIconButton(
                icon: Icons.schedule,
                label: 'Clock',
                isActive: _showClockMock,
                onTap: () => setState(() => _showClockMock = !_showClockMock),
              ),
              const SizedBox(width: 6),
              _buildIconButton(
                icon: Icons.nightlight_round,
                label: 'Lunar',
                isActive: _showLunarBadge,
                onTap: () => setState(() => _showLunarBadge = !_showLunarBadge),
              ),
              const SizedBox(width: 6),
              _buildIconButton(
                icon: Icons.format_quote,
                label: 'Mantra',
                isActive: _showAffirmation,
                onTap: () => setState(() => _showAffirmation = !_showAffirmation),
              ),
              const SizedBox(width: 6),
              _buildIconButton(
                icon: Icons.grain,
                label: 'Sacred',
                isActive: _showSacredGeometry,
                onTap: () => setState(() => _showSacredGeometry = !_showSacredGeometry),
              ),
              const Spacer(),
              // Big Export Action Button
              ElevatedButton.icon(
                onPressed: _isExporting ? null : _exportWallpaper,
                icon: const Icon(Icons.share, size: 16, color: Colors.black),
                label: Text(
                  'EXPORT 4K',
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _theme.accentColor,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? _theme.accentColor.withValues(alpha: 0.2)
              : AppColors.cosmicSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? _theme.accentColor : Colors.white12,
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: isActive ? _theme.accentColor : Colors.white54,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: isActive ? _theme.accentColor : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom Painter rendering delicate sacred geometry concentric circles,
/// octagram rays, and Metatron-inspired harmonic rings.
class _SacredGeometryPainter extends CustomPainter {
  final Color accentColor;
  final Color secondaryAccent;

  _SacredGeometryPainter({
    required this.accentColor,
    required this.secondaryAccent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) * 0.48;

    final ringPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final delicatePaint = Paint()
      ..color = secondaryAccent.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    // Outer concentric rings
    canvas.drawCircle(center, maxRadius, ringPaint);
    canvas.drawCircle(center, maxRadius * 0.85, delicatePaint);
    canvas.drawCircle(center, maxRadius * 0.70, ringPaint);
    canvas.drawCircle(center, maxRadius * 0.50, delicatePaint);

    // 8-Point Octagram Geometric Rays
    final rayPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.08)
      ..strokeWidth = 0.8;

    for (int i = 0; i < 8; i++) {
      final angle = (i * pi) / 4;
      final p1 = Offset(
        center.dx + cos(angle) * maxRadius,
        center.dy + sin(angle) * maxRadius,
      );
      final p2 = Offset(
        center.dx - cos(angle) * maxRadius,
        center.dy - sin(angle) * maxRadius,
      );
      canvas.drawLine(p1, p2, rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SacredGeometryPainter oldDelegate) =>
      oldDelegate.accentColor != accentColor ||
      oldDelegate.secondaryAccent != secondaryAccent;
}
