import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Animated celestial harmony gauge showing the compatibility percentage
/// with a glowing golden-cyan orbital arc and harmonic bond title.
class SynastryHarmonyGauge extends StatefulWidget {
  final int score; // 0 to 100
  final String bondTitle;
  final String relationshipArchetype;

  const SynastryHarmonyGauge({
    super.key,
    required this.score,
    required this.bondTitle,
    required this.relationshipArchetype,
  });

  @override
  State<SynastryHarmonyGauge> createState() => _SynastryHarmonyGaugeState();
}

class _SynastryHarmonyGaugeState extends State<SynastryHarmonyGauge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant SynastryHarmonyGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double currentPercent = (widget.score / 100.0) * _animation.value;
        final int displayScore = (widget.score * _animation.value).round();

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.0,
              colors: [
                const Color(0xFF261D3D),
                const Color(0xFF140E26),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.4), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circular Orbital Arc
              SizedBox(
                width: 170,
                height: 170,
                child: CustomPaint(
                  painter: _OrbitalArcPainter(percent: currentPercent),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('✨', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 2),
                        Text(
                          '$displayScore%',
                          style: const TextStyle(
                            fontFamily: 'Cinzel',
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFD700),
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'HARMONY',
                          style: TextStyle(
                            color: const Color(0xFFD4AF37).withValues(alpha: 0.8),
                            fontSize: 10,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Bond Title
              Text(
                widget.bondTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 4),

              // Archetype Chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  widget.relationshipArchetype.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrbitalArcPainter extends CustomPainter {
  final double percent;

  _OrbitalArcPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width / 2) - 10;

    // Track Background Circle
    final Paint trackPaint = Paint()
      ..color = const Color(0xFF2E244B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;
    canvas.drawCircle(center, radius, trackPaint);

    // Active Arc Gradient
    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    final SweepGradient gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: const [
        Color(0xFFFFD700),
        Color(0xFFE5A93C),
        Color(0xFF4EE2EC),
        Color(0xFFFFD700),
      ],
      stops: const [0.0, 0.45, 0.85, 1.0],
    );

    final Paint arcPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7.5;

    final double sweepAngle = 2 * math.pi * percent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      arcPaint,
    );

    // Orbital Sparkle Dot at End of Arc
    if (percent > 0.02) {
      final double endAngle = -math.pi / 2 + sweepAngle;
      final Offset dotPos = Offset(
        center.dx + radius * math.cos(endAngle),
        center.dy + radius * math.sin(endAngle),
      );

      final Paint glowPaint = Paint()
        ..color = const Color(0xFFFFD700).withValues(alpha: 0.6)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0);
      canvas.drawCircle(dotPos, 6.0, glowPaint);

      final Paint dotPaint = Paint()..color = Colors.white;
      canvas.drawCircle(dotPos, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitalArcPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}
