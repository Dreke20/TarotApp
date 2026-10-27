import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mystic_performance_service.dart';

/// Interactive celestial stardust particle model.
class StardustParticle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double maxRadius;
  double alpha;
  final Color color;
  final double maxAge;
  double age;

  StardustParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.maxRadius,
    required this.alpha,
    required this.color,
    required this.maxAge,
    this.age = 0.0,
  });

  bool update(double dt) {
    age += dt;
    x += vx * dt;
    y += vy * dt;
    // Gentle upward celestial drift
    vy -= 4.0 * dt;
    // Fade out over lifetime
    final progress = (age / maxAge).clamp(0.0, 1.0);
    alpha = (1.0 - progress) * 0.9;
    radius = maxRadius * (1.0 - progress * 0.5);
    return age < maxAge;
  }
}

/// A responsive, GPU-accelerated celestial stardust particle field
/// that emits interactive gold and amethyst spark trails on touch/drag.
class StardustParticleField extends ConsumerStatefulWidget {
  final Widget? child;
  final bool enableTouchTrails;
  final bool enableAmbientDrift;

  const StardustParticleField({
    super.key,
    this.child,
    this.enableTouchTrails = true,
    this.enableAmbientDrift = true,
  });

  @override
  ConsumerState<StardustParticleField> createState() => _StardustParticleFieldState();
}

class _StardustParticleFieldState extends ConsumerState<StardustParticleField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<StardustParticle> _particles = [];
  final Random _random = Random();
  DateTime _lastFrameTime = DateTime.now();

  static const List<Color> _celestialPalette = [
    Color(0xFFFFD700), // Pure Gold
    Color(0xFFF3E5AB), // Champagne Starlight
    Color(0xFFE0B0FF), // Ethereal Amethyst
    Color(0xFF80E5FF), // Celestial Cyan
    Color(0xFFFFF8DC), // Cornsilk White
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_tick);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.removeListener(_tick);
    _controller.dispose();
    super.dispose();
  }

  void _tick() {
    final now = DateTime.now();
    final dt = (now.difference(_lastFrameTime).inMicroseconds / 1000000.0)
        .clamp(0.001, 0.05);
    _lastFrameTime = now;

    final perf = ref.read(mysticPerformanceProvider);
    final maxCount = perf.isBatterySaverEnabled ? 16 : 80;
    final spawnChance = perf.isBatterySaverEnabled ? 0.08 : 0.25;

    // Ambient background drift spawning
    if (widget.enableAmbientDrift && _random.nextDouble() < spawnChance && _particles.length < maxCount) {
      final size = MediaQuery.maybeOf(context)?.size ?? const Size(400, 800);
      _spawnParticle(
        x: _random.nextDouble() * size.width,
        y: size.height * (0.3 + _random.nextDouble() * 0.7),
        isBurst: false,
      );
    }

    // Update existing particles
    _particles.removeWhere((p) => !p.update(dt));
    if (mounted) {
      setState(() {});
    }
  }

  void _spawnParticle({
    required double x,
    required double y,
    bool isBurst = false,
  }) {
    final speed = isBurst ? 40.0 + _random.nextDouble() * 120.0 : 8.0 + _random.nextDouble() * 25.0;
    final angle = _random.nextDouble() * 2 * pi;
    final maxRadius = isBurst ? 2.5 + _random.nextDouble() * 3.5 : 1.2 + _random.nextDouble() * 2.2;
    final color = _celestialPalette[_random.nextInt(_celestialPalette.length)];

    _particles.add(
      StardustParticle(
        x: x + (_random.nextDouble() - 0.5) * (isBurst ? 16.0 : 8.0),
        y: y + (_random.nextDouble() - 0.5) * (isBurst ? 16.0 : 8.0),
        vx: cos(angle) * speed,
        vy: sin(angle) * speed - (isBurst ? 20.0 : 5.0),
        radius: maxRadius,
        maxRadius: maxRadius,
        alpha: 0.85,
        color: color,
        maxAge: isBurst ? 0.7 + _random.nextDouble() * 0.8 : 2.0 + _random.nextDouble() * 3.0,
      ),
    );
  }

  void _handlePointerEvent(PointerEvent event) {
    if (!widget.enableTouchTrails) return;
    // Spawn a burst of stardust sparks along the drag path
    final count = event is PointerDownEvent ? 10 : 3;
    for (int i = 0; i < count; i++) {
      if (_particles.length < 150) {
        _spawnParticle(x: event.localPosition.dx, y: event.localPosition.dy, isBurst: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handlePointerEvent,
      onPointerMove: _handlePointerEvent,
      child: CustomPaint(
        foregroundPainter: _StardustPainter(particles: _particles),
        child: widget.child,
      ),
    );
  }
}

class _StardustPainter extends CustomPainter {
  final List<StardustParticle> particles;

  _StardustPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    if (particles.isEmpty) return;

    final paint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = const Color(0x22FFD700)
      ..strokeWidth = 0.5;

    // Draw faint constellation linkages between nearby particles
    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      for (int j = i + 1; j < min(particles.length, i + 6); j++) {
        final p2 = particles[j];
        final dx = p1.x - p2.x;
        final dy = p1.y - p2.y;
        final distSq = dx * dx + dy * dy;
        if (distSq < 3600) { // < 60dp distance
          final lineAlpha = (1.0 - (distSq / 3600)) * min(p1.alpha, p2.alpha) * 0.4;
          linePaint.color = const Color(0xFFFFD700).withValues(alpha: lineAlpha);
          canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), linePaint);
        }
      }
    }

    // Draw particle orbs with soft glowing halos
    for (final p in particles) {
      if (p.x < -10 || p.x > size.width + 10 || p.y < -10 || p.y > size.height + 10) {
        continue;
      }
      paint.color = p.color.withValues(alpha: p.alpha);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);

      // Outer soft aura
      if (p.radius > 1.8) {
        paint.color = p.color.withValues(alpha: p.alpha * 0.3);
        canvas.drawCircle(Offset(p.x, p.y), p.radius * 2.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StardustPainter oldDelegate) => true;
}
