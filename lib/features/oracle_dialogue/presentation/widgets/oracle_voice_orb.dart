import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/oracle_dialogue_message.dart';

/// Living orb that breathes when idle, ripples with the seeker's voice while
/// listening, swirls while the Oracle thinks, and pulses as it speaks.
class OracleVoiceOrb extends StatefulWidget {
  const OracleVoiceOrb({
    super.key,
    required this.phase,
    required this.soundLevel,
    required this.accent,
    required this.onTap,
    this.size = 200,
  });

  final DialogueState phase;
  final double soundLevel;
  final Color accent;
  final VoidCallback onTap;
  final double size;

  @override
  State<OracleVoiceOrb> createState() => _OracleVoiceOrbState();
}

class _OracleVoiceOrbState extends State<OracleVoiceOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _semanticLabel => switch (widget.phase) {
        DialogueState.listening => 'Listening. Tap to send.',
        DialogueState.synthesizing => 'The Oracle is contemplating.',
        DialogueState.speaking => 'The Oracle is speaking. Tap to interrupt.',
        DialogueState.idle || DialogueState.complete => 'Tap to speak to the Oracle.',
      };

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: _semanticLabel,
      child: GestureDetector(
        key: const Key('oracle_voice_orb'),
        onTap: widget.onTap,
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? _) => CustomPaint(
              painter: _OrbPainter(
                t: _controller.value,
                phase: widget.phase,
                level: widget.soundLevel,
                accent: widget.accent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter({
    required this.t,
    required this.phase,
    required this.level,
    required this.accent,
  });

  final double t;
  final DialogueState phase;
  final double level;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = size.shortestSide * 0.30;
    final double wave = sin(t * 2 * pi);

    final double energy = switch (phase) {
      DialogueState.listening => 0.35 + level * 0.65,
      DialogueState.speaking => 0.55 + 0.25 * (sin(t * 2 * pi * 9).abs()),
      DialogueState.synthesizing => 0.45,
      DialogueState.idle || DialogueState.complete => 0.18 + 0.06 * wave,
    };

    // Outer aura.
    final Paint aura = Paint()
      ..shader = RadialGradient(colors: <Color>[
        accent.withValues(alpha: 0.35 * energy + 0.1),
        accent.withValues(alpha: 0.0),
      ]).createShader(Rect.fromCircle(center: c, radius: r * (1.9 + energy * 0.4)));
    canvas.drawCircle(c, r * (1.9 + energy * 0.4), aura);

    // Ripple rings.
    final int rings = phase == DialogueState.listening ? 4 : 3;
    for (int i = 0; i < rings; i++) {
      final double p = (t * (phase == DialogueState.listening ? 3 : 1.2) + i / rings) % 1.0;
      final Paint ring = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = AppColors.goldBright.withValues(alpha: (1 - p) * 0.45 * (0.4 + energy));
      canvas.drawCircle(c, r * (1.0 + p * (0.7 + energy * 0.6)), ring);
    }

    // Thinking swirl: orbiting gold motes.
    if (phase == DialogueState.synthesizing) {
      final Paint mote = Paint()..color = AppColors.goldBright;
      for (int i = 0; i < 8; i++) {
        final double a = t * 2 * pi * 2 + i * pi / 4;
        final double rr = r * 1.25;
        canvas.drawCircle(
          c + Offset(cos(a) * rr, sin(a) * rr),
          2.4 + (i % 3).toDouble(),
          mote..color = AppColors.goldBright.withValues(alpha: 0.4 + 0.07 * i),
        );
      }
    }

    // Core sphere.
    final double coreR = r * (1.0 + energy * 0.12);
    final Paint core = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.35, -0.4),
        colors: <Color>[
          Color.lerp(AppColors.goldBright, Colors.white, 0.35)!,
          accent,
          AppColors.backgroundDeep,
        ],
        stops: const <double>[0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: c, radius: coreR));
    canvas.drawCircle(c, coreR, core);

    // Sacred geometry inside the core (rotating hexagram).
    final Paint geo = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color = AppColors.goldBright.withValues(alpha: 0.55);
    for (int tri = 0; tri < 2; tri++) {
      final Path path = Path();
      for (int k = 0; k < 3; k++) {
        final double a = t * 2 * pi * (tri == 0 ? 1 : -1) + tri * pi / 3 + k * 2 * pi / 3;
        final Offset p = c + Offset(cos(a), sin(a)) * coreR * 0.62;
        k == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
      }
      path.close();
      canvas.drawPath(path, geo);
    }
    canvas.drawCircle(
      c,
      coreR,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..color = AppColors.goldMetallic.withValues(alpha: 0.8),
    );
  }

  @override
  bool shouldRepaint(covariant _OrbPainter old) =>
      old.t != t || old.phase != phase || old.level != level || old.accent != accent;
}
