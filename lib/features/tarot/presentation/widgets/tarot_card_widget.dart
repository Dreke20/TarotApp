import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/holographic_foil_card.dart';
import '../../domain/tarot_card.dart';
import '../../domain/tarot_deck_theme.dart';
import '../notifiers/card_back_notifier.dart';
import 'card_back_design_painter.dart';

/// Interactive 3D Flippable Tarot Card with sacred geometry styling,
/// gold foil borders, and dynamic orientation handling.
class TarotCardWidget extends StatefulWidget {
  final TarotCard card;
  final bool isFaceUp;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final int index;
  final bool isSelected;
  final TarotDeckTheme deckTheme;

  const TarotCardWidget({
    super.key,
    required this.card,
    this.isFaceUp = false,
    this.onTap,
    this.width = 110,
    this.height = 180,
    this.index = 0,
    this.isSelected = false,
    this.deckTheme = TarotDeckTheme.classic,
  });

  @override
  State<TarotCardWidget> createState() => _TarotCardWidgetState();
}

class _TarotCardWidgetState extends State<TarotCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.easeInOutBack,
      ),
    );

    if (widget.isFaceUp) {
      _flipController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(TarotCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFaceUp != oldWidget.isFaceUp) {
      if (widget.isFaceUp) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isFrontFacing = angle >= (pi / 2);

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0016) // Perspective depth
              ..rotateY(angle),
            child: isFrontFacing
                // The front of the card is rotated by 180 degrees so it faces the user correctly
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: _buildCardFront(),
                  )
                : _buildCardBack(),
          );
        },
      ),
    )
        .animate()
        .fadeIn(
          duration: 450.ms,
          delay: (widget.index * 120).ms,
          curve: Curves.easeOutQuad,
        )
        .slideY(
          begin: 0.25,
          end: 0,
          duration: 500.ms,
          delay: (widget.index * 120).ms,
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildCardBack() {
    return Consumer(
      builder: (context, ref, child) {
        final cardBack = ref.watch(cardBackProvider);
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: widget.deckTheme.backGradient,
            border: Border.all(
              color: widget.isSelected
                  ? widget.deckTheme.accentColor
                  : widget.deckTheme.accentColor.withValues(alpha: 0.6),
              width: widget.isSelected ? 2.0 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isSelected
                    ? widget.deckTheme.accentColor.withValues(alpha: 0.4)
                    : Colors.black.withValues(alpha: 0.45),
                blurRadius: widget.isSelected ? 18 : 12,
                spreadRadius: widget.isSelected ? 2 : 0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Inner ornamental border
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: widget.deckTheme.accentColor.withValues(alpha: 0.35),
                    width: 0.8,
                  ),
                ),
              ),

              // Celestial center geometry
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: CustomPaint(
                    painter: CardBackDesignPainter(
                      design: cardBack,
                      customAccent: widget.deckTheme.accentColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCardFront() {
    final card = widget.card;
    final isReversed = card.isReversed;
    final cardAsset = card.assetPath ?? 'assets/cards/${card.id}.jpg';

    return HolographicFoilCard(
      borderRadius: BorderRadius.circular(14),
      enableSensorTilt: true,
      enableTouchTilt: false,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: AppColors.cardFaceGradient,
        border: Border.all(
          color: widget.isSelected
              ? AppColors.goldBright
              : widget.deckTheme.accentColor.withValues(alpha: 0.7),
          width: widget.isSelected ? 2.0 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.isSelected
                ? widget.deckTheme.accentColor.withValues(alpha: 0.45)
                : AppColors.cosmicSurface.withValues(alpha: 0.6),
            blurRadius: widget.isSelected ? 20 : 16,
            spreadRadius: widget.isSelected ? 2 : 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Transform.rotate(
          angle: isReversed ? pi : 0,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. High-resolution card artwork with seamless procedural fallback
              Image.asset(
                cardAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildProceduralCardFront(card, isReversed);
                },
              ),

              // 2. Subtle glass rim over artwork
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: AppColors.goldMuted.withValues(alpha: 0.35),
                      width: 0.8,
                    ),
                  ),
                ),
              ),

              // 3. Reversed badge if orientation is reversed
              if (isReversed)
                Positioned(
                  bottom: 8,
                  left: 6,
                  right: 6,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFFFF8B8B).withValues(alpha: 0.8),
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        'REVERSED',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 7.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFF8B8B),
                          letterSpacing: 0.8,
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

  Widget _buildProceduralCardFront(TarotCard card, bool isReversed) {
    return Stack(
      children: [
        // Inner golden filigree boundary
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.goldMuted.withValues(alpha: 0.5),
                width: 0.8,
              ),
            ),
          ),
        ),

        // Card content layout
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Header: Number / Arcana badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card.number != null ? _toRoman(card.number!) : '★',
                    style: GoogleFonts.cinzel(
                      color: AppColors.goldBright,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: AppColors.glassFillStrong,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _getElementColor(card.element).withValues(alpha: 0.5),
                        width: 0.6,
                      ),
                    ),
                    child: Text(
                      card.element ?? (card.arcana == 'major' ? 'MAJOR' : 'MINOR'),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 7.5,
                        color: _getElementColor(card.element),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // Center Archetype Icon & Illustration Frame
              Expanded(
                child: Center(
                  child: Container(
                    width: widget.width * 0.7,
                    height: widget.height * 0.44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cosmicSurface.withValues(alpha: 0.5),
                      border: Border.all(
                        color: AppColors.goldMuted.withValues(alpha: 0.4),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _getElementColor(card.element).withValues(alpha: 0.15),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(
                      _getCardIcon(card),
                      color: AppColors.goldBright,
                      size: widget.width * 0.35,
                    ),
                  ),
                ),
              ),

              // Bottom Title & Orientation Info
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    card.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cinzel(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  if (isReversed)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'REVERSED',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFF8B8B),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getElementColor(String? element) {
    switch (element?.toLowerCase()) {
      case 'fire':
        return AppColors.fireAccent;
      case 'water':
        return AppColors.waterAccent;
      case 'air':
        return AppColors.airAccent;
      case 'earth':
        return AppColors.earthAccent;
      default:
        return AppColors.goldBright;
    }
  }

  IconData _getCardIcon(TarotCard card) {
    if (card.arcana == 'major') {
      switch (card.number) {
        case 0:
          return Icons.hiking;
        case 1:
          return Icons.auto_fix_high;
        case 2:
          return Icons.brightness_3;
        case 3:
          return Icons.nature_people;
        case 4:
          return Icons.shield;
        case 5:
          return Icons.temple_buddhist;
        case 6:
          return Icons.favorite;
        case 7:
          return Icons.sports_motorsports;
        case 8:
          return Icons.pets;
        case 9:
          return Icons.light_mode_outlined;
        case 10:
          return Icons.album;
        case 11:
          return Icons.balance;
        case 12:
          return Icons.hourglass_empty;
        case 13:
          return Icons.change_circle;
        case 14:
          return Icons.opacity;
        case 15:
          return Icons.whatshot;
        case 16:
          return Icons.flash_on;
        case 17:
          return Icons.star;
        case 18:
          return Icons.nightlight_round;
        case 19:
          return Icons.wb_sunny;
        case 20:
          return Icons.campaign;
        case 21:
          return Icons.public;
        default:
          return Icons.auto_awesome;
      }
    }

    switch (card.suit) {
      case 'wands':
        return Icons.local_fire_department;
      case 'cups':
        return Icons.water_drop;
      case 'swords':
        return Icons.navigation;
      case 'pentacles':
        return Icons.circle_outlined;
      default:
        return Icons.auto_awesome;
    }
  }

  String _toRoman(int number) {
    if (number == 0) return '0';
    const romans = [
      'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X',
      'XI', 'XII', 'XIII', 'XIV', 'XV', 'XVI', 'XVII', 'XVIII', 'XIX', 'XX', 'XXI'
    ];
    if (number > 0 && number <= romans.length) {
      return romans[number - 1];
    }
    return number.toString();
  }
}

/// Custom painter rendering sacred celestial geometry on the back of each card
class CardBackPatternPainter extends CustomPainter {
  final Color? accentColor;

  const CardBackPatternPainter({this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final goldColor = accentColor ?? AppColors.goldBright;
    final center = Offset(size.width / 2, size.height / 2);
    final minDim = min(size.width, size.height);
    final radius = minDim * 0.44;

    final primaryGold = Paint()
      ..color = goldColor.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final hairlineGold = Paint()
      ..color = goldColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final dotPaint = Paint()
      ..color = goldColor.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    // 1. Four Corner Filigree Accents
    const cornerMargin = 4.0;
    const cornerSize = 10.0;
    final corners = [
      Offset(cornerMargin, cornerMargin), // Top-Left
      Offset(size.width - cornerMargin, cornerMargin), // Top-Right
      Offset(size.width - cornerMargin, size.height - cornerMargin), // Bottom-Right
      Offset(cornerMargin, size.height - cornerMargin), // Bottom-Left
    ];

    for (int i = 0; i < 4; i++) {
      final c = corners[i];
      final dx = (i == 0 || i == 3) ? cornerSize : -cornerSize;
      final dy = (i == 0 || i == 1) ? cornerSize : -cornerSize;
      
      canvas.drawLine(c, Offset(c.dx + dx, c.dy), hairlineGold);
      canvas.drawLine(c, Offset(c.dx, c.dy + dy), hairlineGold);
      canvas.drawCircle(Offset(c.dx + dx * 0.6, c.dy + dy * 0.6), 1.2, dotPaint);
    }

    // 2. Central Mystic Diamond
    final pathDiamond = Path()
      ..moveTo(center.dx, center.dy - radius * 1.08)
      ..lineTo(center.dx + radius * 0.75, center.dy)
      ..lineTo(center.dx, center.dy + radius * 1.08)
      ..lineTo(center.dx - radius * 0.75, center.dy)
      ..close();
    canvas.drawPath(pathDiamond, hairlineGold);

    // 3. Dual Concentric Sacred Rings
    canvas.drawCircle(center, radius, primaryGold);
    canvas.drawCircle(center, radius * 0.72, hairlineGold);
    canvas.drawCircle(center, radius * 0.38, hairlineGold);

    // 4. 12 Zodiac Astral Nodes on middle ring
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (pi / 180);
      final node = Offset(
        center.dx + cos(angle) * (radius * 0.72),
        center.dy + sin(angle) * (radius * 0.72),
      );
      canvas.drawCircle(node, (i % 3 == 0) ? 2.0 : 1.2, dotPaint);
    }

    // 5. Eight-Pointed Sacred Celestial Star
    final starPath = Path();
    const int points = 8;
    for (int i = 0; i < points * 2; i++) {
      final isTip = i % 2 == 0;
      final isMajor = i % 4 == 0;
      final r = isTip
          ? (isMajor ? radius * 0.95 : radius * 0.7)
          : (radius * 0.22);
      final angle = (i * pi / points) - (pi / 2);
      final pt = Offset(center.dx + cos(angle) * r, center.dy + sin(angle) * r);
      if (i == 0) {
        starPath.moveTo(pt.dx, pt.dy);
      } else {
        starPath.lineTo(pt.dx, pt.dy);
      }
    }
    starPath.close();
    canvas.drawPath(starPath, primaryGold);

    // 6. Center Sun Node
    canvas.drawCircle(center, radius * 0.14, dotPaint);
    canvas.drawCircle(center, radius * 0.08, Paint()..color = const Color(0xFF0F0E17)..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CardBackPatternPainter oldDelegate) =>
      oldDelegate.accentColor != accentColor;
}
