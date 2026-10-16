import 'dart:math';
import 'package:flutter/material.dart';

/// Single simulated curling smoke particle with alpha decay and billow physics.
class SmokeWisp {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  final double maxRadius;
  double alpha;
  final Color baseColor;
  final double curlSpeed;
  final double curlOffset;
  final double maxAge;
  double age;
  final bool isEmber;

  SmokeWisp({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.maxRadius,
    required this.alpha,
    required this.baseColor,
    required this.curlSpeed,
    required this.curlOffset,
    required this.maxAge,
    this.age = 0.0,
    this.isEmber = false,
  });

  bool update(double dt) {
    age += dt;
    final progress = (age / maxAge).clamp(0.0, 1.0);

    // Billowing upward physics with curling lateral draft
    final curl = sin(age * curlSpeed + curlOffset) * (isEmber ? 8.0 : 22.0);
    x += (vx + curl) * dt;
    y += vy * dt;

    if (isEmber) {
      // Embers rise rapidly and shrink
      vy -= 12.0 * dt;
      alpha = (1.0 - progress) * 0.95;
      radius = maxRadius * (1.0 - progress * 0.7);
    } else {
      // Smoke wisps expand and fade into the ether
      vy -= 6.0 * dt;
      radius = radius + (maxRadius - radius) * (dt * 1.5);
      alpha = (1.0 - progress) * (progress < 0.2 ? (progress / 0.2) * 0.45 : 0.45);
    }

    return age < maxAge;
  }
}

/// A high-performance GPU canvas rendering realistic curling incense smoke
/// ribbons and glowing ember sparks reacting to touch and drag gestures.
class SmokeParticleCanvas extends StatefulWidget {
  final Color smokeColor;
  final Color glowColor;
  final bool isInteractive;
  final Offset? ambientOrigin;
  final ValueChanged<double>? onWaftProgress;
  final Widget? child;

  const SmokeParticleCanvas({
    super.key,
    required this.smokeColor,
    required this.glowColor,
    this.isInteractive = true,
    this.ambientOrigin,
    this.onWaftProgress,
    this.child,
  });

  @override
  State<SmokeParticleCanvas> createState() => SmokeParticleCanvasState();
}

class SmokeParticleCanvasState extends State<SmokeParticleCanvas>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ticker;
  final List<SmokeWisp> _wisps = [];
  final Random _rng = Random();
  DateTime _lastTick = DateTime.now();
  double _ambientTimer = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_processFrame);
    _ticker.repeat();
  }

  @override
  void dispose() {
    _ticker.removeListener(_processFrame);
    _ticker.dispose();
    super.dispose();
  }

  void _processFrame() {
    final now = DateTime.now();
    final dt = (now.difference(_lastTick).inMicroseconds / 1000000.0)
        .clamp(0.001, 0.05);
    _lastTick = now;

    // Ambient emission from incense source if provided
    _ambientTimer += dt;
    if (_ambientTimer > 0.08 && widget.ambientOrigin != null) {
      _ambientTimer = 0.0;
      _spawnWisps(widget.ambientOrigin!, count: 2, isAmbient: true);
    }

    // Update existing particles
    _wisps.removeWhere((wisp) => !wisp.update(dt));

    if (mounted) setState(() {});
  }

  /// Public method to spawn smoke at a given coordinate
  void emitAt(Offset position, {int count = 4}) {
    _spawnWisps(position, count: count, isAmbient: false);
  }

  void _spawnWisps(Offset origin, {required int count, required bool isAmbient}) {
    for (int i = 0; i < count; i++) {
      if (_wisps.length > 250) break;

      final isEmber = !isAmbient && _rng.nextDouble() < 0.25;
      final angle = _rng.nextDouble() * 2 * pi;
      final speed = isEmber ? 20.0 + _rng.nextDouble() * 35.0 : 8.0 + _rng.nextDouble() * 18.0;

      final startRadius = isEmber ? 1.5 + _rng.nextDouble() * 1.5 : 8.0 + _rng.nextDouble() * 6.0;
      final maxRadius = isEmber ? 1.0 : 36.0 + _rng.nextDouble() * 28.0;

      _wisps.add(
        SmokeWisp(
          x: origin.dx + (_rng.nextDouble() - 0.5) * 12,
          y: origin.dy + (_rng.nextDouble() - 0.5) * 12,
          vx: cos(angle) * speed * 0.4,
          vy: -speed - (_rng.nextDouble() * 25.0),
          radius: startRadius,
          maxRadius: maxRadius,
          alpha: isEmber ? 0.9 : 0.4,
          baseColor: isEmber ? const Color(0xFFFFB300) : widget.smokeColor,
          curlSpeed: 1.8 + _rng.nextDouble() * 2.5,
          curlOffset: _rng.nextDouble() * pi * 2,
          maxAge: isEmber ? 1.2 + _rng.nextDouble() * 0.8 : 2.0 + _rng.nextDouble() * 1.4,
          isEmber: isEmber,
        ),
      );
    }
  }

  void _handleTouch(Offset localPos) {
    emitAt(localPos, count: 5);
    widget.onWaftProgress?.call(0.008);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CustomPaint(
      painter: _SmokePainter(
        wisps: _wisps,
        glowColor: widget.glowColor,
      ),
      size: Size.infinite,
      child: widget.child,
    );

    if (!widget.isInteractive) return content;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (d) => _handleTouch(d.localPosition),
      onPanUpdate: (d) => _handleTouch(d.localPosition),
      child: content,
    );
  }
}

class _SmokePainter extends CustomPainter {
  final List<SmokeWisp> wisps;
  final Color glowColor;

  _SmokePainter({
    required this.wisps,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (wisps.isEmpty) return;

    for (final w in wisps) {
      if (w.alpha <= 0.001) continue;

      if (w.isEmber) {
        // Glowing ember spark
        final emberPaint = Paint()
          ..color = w.baseColor.withValues(alpha: w.alpha)
          ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2.0);
        canvas.drawCircle(Offset(w.x, w.y), w.radius, emberPaint);

        // Core white-hot spark
        final corePaint = Paint()
          ..color = Colors.white.withValues(alpha: w.alpha.clamp(0.0, 1.0));
        canvas.drawCircle(Offset(w.x, w.y), w.radius * 0.4, corePaint);
      } else {
        // Soft billowy incense smoke wisp
        final smokePaint = Paint()
          ..shader = RadialGradient(
            colors: [
              w.baseColor.withValues(alpha: w.alpha),
              glowColor.withValues(alpha: w.alpha * 0.5),
              Colors.transparent,
            ],
            stops: const [0.0, 0.45, 1.0],
          ).createShader(
            Rect.fromCircle(center: Offset(w.x, w.y), radius: w.radius),
          )
          ..blendMode = BlendMode.screen;

        canvas.drawCircle(Offset(w.x, w.y), w.radius, smokePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SmokePainter oldDelegate) => true;
}
