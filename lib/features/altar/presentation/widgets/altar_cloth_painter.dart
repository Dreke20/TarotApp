import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/altar_cloth.dart';

/// GPU Canvas CustomPainter rendering authentic consecrated altar cloth
/// textures, braided borders, and sacred central embroidery.
class AltarClothPainter extends CustomPainter {
  final AltarCloth cloth;
  final double animationProgress;

  const AltarClothPainter({
    required this.cloth,
    this.animationProgress = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = Offset(size.width / 2, size.height * 0.44);

    // 1. Rich velvet / silk radial background gradient
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.2),
        radius: 1.1,
        colors: [
          cloth.secondaryColor,
          cloth.primaryColor,
          Colors.black,
        ],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    // 2. Braided Outer Border Stitching
    final borderPaint = Paint()
      ..color = cloth.accentColor.withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final innerBorderPaint = Paint()
      ..color = cloth.trimColor.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    const margin = 12.0;
    final outerRect = Rect.fromLTRB(margin, margin, size.width - margin, size.height - margin);
    final innerRect = Rect.fromLTRB(margin + 5, margin + 5, size.width - margin - 5, size.height - margin - 5);
    final rOuter = RRect.fromRectAndRadius(outerRect, const Radius.circular(22));
    final rInner = RRect.fromRectAndRadius(innerRect, const Radius.circular(18));

    canvas.drawRRect(rOuter, borderPaint);
    canvas.drawRRect(rInner, innerBorderPaint);

    // 3. Four Corner Emblems
    _drawCornerEmblem(canvas, const Offset(margin + 6, margin + 6), cloth.trimColor);
    _drawCornerEmblem(canvas, Offset(size.width - margin - 6, margin + 6), cloth.trimColor);
    _drawCornerEmblem(canvas, Offset(size.width - margin - 6, size.height - margin - 6), cloth.trimColor);
    _drawCornerEmblem(canvas, Offset(margin + 6, size.height - margin - 6), cloth.trimColor);

    // 4. Consecrated Centerpiece Embroidery
    switch (cloth) {
      case AltarCloth.midnightObsidian:
        _drawZodiacWheel(canvas, center, min(size.width, size.height) * 0.38);
        break;
      case AltarCloth.amethystSilk:
        _drawSriYantra(canvas, center, min(size.width, size.height) * 0.36);
        break;
      case AltarCloth.emeraldHermetic:
        _drawHermeticSeal(canvas, center, min(size.width, size.height) * 0.36);
        break;
      case AltarCloth.celestialStarlight:
        _drawConstellationMap(canvas, center, min(size.width, size.height) * 0.38);
        break;
    }
  }

  void _drawCornerEmblem(Canvas canvas, Offset pos, Color color) {
    final p = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(pos, 5, p);
    canvas.drawCircle(pos, 2, Paint()..color = color.withValues(alpha: 0.5));
  }

  /// Midnight Obsidian: 12-Spoke Zodiac Celestial Wheel
  void _drawZodiacWheel(Canvas canvas, Offset center, double radius) {
    final gold = Paint()
      ..color = cloth.accentColor.withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final thin = Paint()
      ..color = cloth.trimColor.withValues(alpha: 0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;
    final dot = Paint()
      ..color = cloth.trimColor.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, gold);
    canvas.drawCircle(center, radius * 0.82, thin);
    canvas.drawCircle(center, radius * 0.52, gold);
    canvas.drawCircle(center, radius * 0.22, thin);

    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * pi / 180;
      final p1 = Offset(center.dx + cos(angle) * (radius * 0.22), center.dy + sin(angle) * (radius * 0.22));
      final p2 = Offset(center.dx + cos(angle) * radius, center.dy + sin(angle) * radius);
      canvas.drawLine(p1, p2, (i % 3 == 0) ? gold : thin);

      // Node
      final node = Offset(center.dx + cos(angle) * (radius * 0.82), center.dy + sin(angle) * (radius * 0.82));
      canvas.drawCircle(node, (i % 3 == 0) ? 2.5 : 1.5, dot);
    }
  }

  /// Amethyst Silk: Sacred Sri Yantra Sacred Geometry
  void _drawSriYantra(Canvas canvas, Offset center, double radius) {
    final lilac = Paint()
      ..color = cloth.accentColor.withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    final soft = Paint()
      ..color = cloth.trimColor.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    canvas.drawCircle(center, radius, lilac);
    canvas.drawCircle(center, radius * 0.85, soft);

    // 16 Lotus Petals
    for (int i = 0; i < 16; i++) {
      final angle = (i * 22.5) * pi / 180;
      final petalPt = Offset(center.dx + cos(angle) * (radius * 0.85), center.dy + sin(angle) * (radius * 0.85));
      canvas.drawCircle(petalPt, 3.5, soft);
    }

    // Interlocking Shiva-Shakti Triangles
    const scales = <double>[0.72, 0.56, 0.42, 0.28];
    for (int i = 0; i < scales.length; i++) {
      final s = scales[i];
      final isUp = i % 2 == 0;
      final path = Path();
      final r = radius * s;
      if (isUp) {
        path.moveTo(center.dx, center.dy - r);
        path.lineTo(center.dx + r * 0.866, center.dy + r * 0.5);
        path.lineTo(center.dx - r * 0.866, center.dy + r * 0.5);
      } else {
        path.moveTo(center.dx, center.dy + r);
        path.lineTo(center.dx + r * 0.866, center.dy - r * 0.5);
        path.lineTo(center.dx - r * 0.866, center.dy - r * 0.5);
      }
      path.close();
      canvas.drawPath(path, i == 0 ? lilac : soft);
    }

    // Bindu Point
    canvas.drawCircle(center, 3.0, Paint()..color = cloth.trimColor.withValues(alpha: 0.6));
  }

  /// Emerald Hermetic: The Seal of Hermes & Alchemical Caduceus
  void _drawHermeticSeal(Canvas canvas, Offset center, double radius) {
    final emerald = Paint()
      ..color = cloth.accentColor.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    final gold = Paint()
      ..color = cloth.trimColor.withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    canvas.drawCircle(center, radius, emerald);
    canvas.drawCircle(center, radius * 0.76, gold);
    canvas.drawCircle(center, radius * 0.38, emerald);

    // Hexagram of Solomon
    final p1 = Path()
      ..moveTo(center.dx, center.dy - radius * 0.76)
      ..lineTo(center.dx + radius * 0.658, center.dy + radius * 0.38)
      ..lineTo(center.dx - radius * 0.658, center.dy + radius * 0.38)
      ..close();
    final p2 = Path()
      ..moveTo(center.dx, center.dy + radius * 0.76)
      ..lineTo(center.dx + radius * 0.658, center.dy - radius * 0.38)
      ..lineTo(center.dx - radius * 0.658, center.dy - radius * 0.38)
      ..close();

    canvas.drawPath(p1, emerald);
    canvas.drawPath(p2, emerald);

    // Central Caduceus Staff
    canvas.drawLine(
      Offset(center.dx, center.dy - radius * 0.35),
      Offset(center.dx, center.dy + radius * 0.35),
      gold,
    );
    canvas.drawCircle(Offset(center.dx, center.dy - radius * 0.35), 4.0, Paint()..color = cloth.trimColor.withValues(alpha: 0.4));
  }

  /// Celestial Starlight: Circumpolar Constellation Sky Map
  void _drawConstellationMap(Canvas canvas, Offset center, double radius) {
    final cyan = Paint()
      ..color = cloth.accentColor.withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;
    final star = Paint()
      ..color = cloth.trimColor.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, cyan);
    canvas.drawCircle(center, radius * 0.68, cyan);
    canvas.drawCircle(center, radius * 0.36, cyan);

    // Constellation Vector Points (North Star Polaris, Cassiopeia, Big Dipper)
    final points = [
      Offset(center.dx, center.dy - radius * 0.05), // Polaris
      Offset(center.dx + radius * 0.35, center.dy - radius * 0.45),
      Offset(center.dx + radius * 0.52, center.dy - radius * 0.25),
      Offset(center.dx + radius * 0.28, center.dy - radius * 0.15),
      Offset(center.dx - radius * 0.42, center.dy + radius * 0.25),
      Offset(center.dx - radius * 0.28, center.dy + radius * 0.48),
      Offset(center.dx - radius * 0.12, center.dy + radius * 0.32),
      Offset(center.dx + radius * 0.18, center.dy + radius * 0.40),
    ];

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], (i == 0) ? 3.5 : 2.0, star);
      if (i > 0 && i < 4) {
        canvas.drawLine(points[i - 1], points[i], cyan);
      } else if (i > 4) {
        canvas.drawLine(points[i - 1], points[i], cyan);
      }
    }
  }

  @override
  bool shouldRepaint(covariant AltarClothPainter oldDelegate) =>
      oldDelegate.cloth != cloth || oldDelegate.animationProgress != animationProgress;
}
