import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/card_back_design.dart';

/// GPU CustomPainter rendering the active collectible card back geometry.
class CardBackDesignPainter extends CustomPainter {
  final CardBackDesign design;
  final Color? customAccent;

  const CardBackDesignPainter({
    required this.design,
    this.customAccent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final primary = customAccent ?? design.primaryFoilColor;
    final secondary = design.secondaryFoilColor;
    final center = Offset(size.width / 2, size.height / 2);
    final minDim = min(size.width, size.height);
    final radius = minDim * 0.44;

    // Corner Filigree (Universal sacred frame)
    _drawCorners(canvas, size, primary, secondary);

    switch (design) {
      case CardBackDesign.eyeOfProvidence:
        _drawEyeOfProvidence(canvas, center, radius, primary, secondary);
        break;
      case CardBackDesign.metatronsCube:
        _drawMetatronsCube(canvas, center, radius, primary, secondary);
        break;
      case CardBackDesign.ouroborosMoon:
        _drawOuroborosMoon(canvas, center, radius, primary, secondary);
        break;
      case CardBackDesign.celestialAstrolabe:
        _drawCelestialAstrolabe(canvas, center, radius, primary, secondary);
        break;
    }
  }

  void _drawCorners(Canvas canvas, Size size, Color primary, Color secondary) {
    const margin = 5.0;
    const len = 9.0;
    final p = Paint()
      ..color = primary.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;
    final dot = Paint()
      ..color = secondary.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    final corners = [
      const Offset(margin, margin),
      Offset(size.width - margin, margin),
      Offset(size.width - margin, size.height - margin),
      Offset(margin, size.height - margin),
    ];

    for (int i = 0; i < 4; i++) {
      final c = corners[i];
      final dx = (i == 0 || i == 3) ? len : -len;
      final dy = (i == 0 || i == 1) ? len : -len;
      canvas.drawLine(c, Offset(c.dx + dx, c.dy), p);
      canvas.drawLine(c, Offset(c.dx, c.dy + dy), p);
      canvas.drawCircle(Offset(c.dx + dx * 0.5, c.dy + dy * 0.5), 1.0, dot);
    }
  }

  /// 1. The Eye of Providence: Radiating Solar Rays & Sacred Vesica Eye
  void _drawEyeOfProvidence(Canvas canvas, Offset center, double radius, Color primary, Color secondary) {
    final gold = Paint()
      ..color = primary.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    final rayPaint = Paint()
      ..color = secondary.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Rings
    canvas.drawCircle(center, radius, gold);
    canvas.drawCircle(center, radius * 0.72, rayPaint);

    // 16 Radiating Solar Rays
    for (int i = 0; i < 16; i++) {
      final angle = (i * 22.5) * pi / 180;
      final r1 = radius * 0.42;
      final r2 = (i % 2 == 0) ? radius * 0.95 : radius * 0.80;
      canvas.drawLine(
        Offset(center.dx + cos(angle) * r1, center.dy + sin(angle) * r1),
        Offset(center.dx + cos(angle) * r2, center.dy + sin(angle) * r2),
        rayPaint,
      );
    }

    // Sacred Vesica Piscis (Eye outline)
    final eyeWidth = radius * 0.68;
    final eyeHeight = radius * 0.34;
    final path = Path()
      ..moveTo(center.dx - eyeWidth / 2, center.dy)
      ..quadraticBezierTo(center.dx, center.dy - eyeHeight, center.dx + eyeWidth / 2, center.dy)
      ..quadraticBezierTo(center.dx, center.dy + eyeHeight, center.dx - eyeWidth / 2, center.dy)
      ..close();
    canvas.drawPath(path, gold);

    // Iris & Luminous Pupil
    canvas.drawCircle(center, eyeHeight * 0.65, Paint()..color = secondary.withValues(alpha: 0.4)..style = PaintingStyle.stroke..strokeWidth = 1.0);
    canvas.drawCircle(center, eyeHeight * 0.32, Paint()..color = primary.withValues(alpha: 0.85)..style = PaintingStyle.fill);
    canvas.drawCircle(Offset(center.dx - 1.5, center.dy - 1.5), 1.2, Paint()..color = Colors.white..style = PaintingStyle.fill);
  }

  /// 2. Metatron's Cube: 13 Sacred Spheres & Connecting Platonic Lines
  void _drawMetatronsCube(Canvas canvas, Offset center, double radius, Color primary, Color secondary) {
    final linePaint = Paint()
      ..color = primary.withValues(alpha: 0.38)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.75;
    final circlePaint = Paint()
      ..color = secondary.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;
    final nodePaint = Paint()
      ..color = secondary.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    // 13 Center Points
    final List<Offset> points = [center];
    final nodeRadius = radius * 0.16;

    // Inner 6 (Radius * 0.45)
    for (int i = 0; i < 6; i++) {
      final a = (i * 60) * pi / 180;
      points.add(Offset(center.dx + cos(a) * (radius * 0.45), center.dy + sin(a) * (radius * 0.45)));
    }

    // Outer 6 (Radius * 0.85)
    for (int i = 0; i < 6; i++) {
      final a = (i * 60) * pi / 180;
      points.add(Offset(center.dx + cos(a) * (radius * 0.85), center.dy + sin(a) * (radius * 0.85)));
    }

    // Connect all points to form Platonic Solids
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        canvas.drawLine(points[i], points[j], linePaint);
      }
    }

    // Draw the 13 Spheres
    for (final pt in points) {
      canvas.drawCircle(pt, nodeRadius, circlePaint);
      canvas.drawCircle(pt, 1.8, nodePaint);
    }
  }

  /// 3. Ouroboros & Crescent Moon: Serpent of Eternity & Rose Gold Moon
  void _drawOuroborosMoon(Canvas canvas, Offset center, double radius, Color primary, Color secondary) {
    final serpentPaint = Paint()
      ..color = primary.withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    final moonPaint = Paint()
      ..color = secondary.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;
    final thinPaint = Paint()
      ..color = primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Outer Ouroboros Ring
    canvas.drawCircle(center, radius * 0.88, serpentPaint);
    canvas.drawCircle(center, radius * 0.96, thinPaint);
    canvas.drawCircle(center, radius * 0.80, thinPaint);

    // Scale Ticks on serpent body
    for (int i = 0; i < 36; i++) {
      final a = (i * 10) * pi / 180;
      final p1 = Offset(center.dx + cos(a) * (radius * 0.83), center.dy + sin(a) * (radius * 0.83));
      final p2 = Offset(center.dx + cos(a) * (radius * 0.93), center.dy + sin(a) * (radius * 0.93));
      canvas.drawLine(p1, p2, thinPaint);
    }

    // Central Crescent Moon
    final moonR = radius * 0.45;
    final moonPath = Path()
      ..addArc(Rect.fromCircle(center: center, radius: moonR), -pi / 2, pi)
      ..arcTo(
        Rect.fromCircle(center: Offset(center.dx + moonR * 0.38, center.dy), radius: moonR * 0.82),
        pi / 2,
        -pi,
        false,
      );
    canvas.drawPath(moonPath, moonPaint);

    // North Star in cradle of moon
    final starCenter = Offset(center.dx + moonR * 0.22, center.dy);
    canvas.drawCircle(starCenter, 2.2, Paint()..color = secondary.withValues(alpha: 0.9));
  }

  /// 4. Celestial Astrolabe: Antique Brass Astrolabe & Coordinate Projection
  void _drawCelestialAstrolabe(Canvas canvas, Offset center, double radius, Color primary, Color secondary) {
    final brass = Paint()
      ..color = primary.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    final thin = Paint()
      ..color = secondary.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.75;
    final dot = Paint()
      ..color = secondary.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    // Concentric Astrolabe Coordinate Rings
    canvas.drawCircle(center, radius, brass);
    canvas.drawCircle(center, radius * 0.82, thin);
    canvas.drawCircle(center, radius * 0.64, brass);
    canvas.drawCircle(center, radius * 0.40, thin);
    canvas.drawCircle(center, radius * 0.18, brass);

    // Crosshairs & Horizon lines
    canvas.drawLine(Offset(center.dx - radius, center.dy), Offset(center.dx + radius, center.dy), brass);
    canvas.drawLine(Offset(center.dx, center.dy - radius), Offset(center.dx, center.dy + radius), brass);

    // 24 Hour Ticks on Outer Limb
    for (int i = 0; i < 24; i++) {
      final a = (i * 15) * pi / 180;
      final len = (i % 6 == 0) ? radius * 0.12 : radius * 0.06;
      final p1 = Offset(center.dx + cos(a) * (radius - len), center.dy + sin(a) * (radius - len));
      final p2 = Offset(center.dx + cos(a) * radius, center.dy + sin(a) * radius);
      canvas.drawLine(p1, p2, (i % 6 == 0) ? brass : thin);
      if (i % 6 == 0) {
        canvas.drawCircle(p1, 1.6, dot);
      }
    }

    // Offset Ecliptic Ring
    final eclipticCenter = Offset(center.dx, center.dy + radius * 0.18);
    canvas.drawCircle(eclipticCenter, radius * 0.46, thin);
  }

  @override
  bool shouldRepaint(covariant CardBackDesignPainter oldDelegate) =>
      oldDelegate.design != design || oldDelegate.customAccent != customAccent;
}
