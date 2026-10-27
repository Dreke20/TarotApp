import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Animated mystic multi-harmonic frequency visualizer wave.
/// Renders oscillating harmonic ribbons colored according to active sacred tones.
class FrequencyVisualizerWave extends StatefulWidget {
  final bool isPlaying;
  final double masterVolume;
  final double frequencyVolume;
  final double instrumentVolume;
  final double natureVolume;
  final double height;

  const FrequencyVisualizerWave({
    super.key,
    required this.isPlaying,
    required this.masterVolume,
    this.frequencyVolume = 0.7,
    this.instrumentVolume = 0.5,
    this.natureVolume = 0.35,
    this.height = 90.0,
  });

  @override
  State<FrequencyVisualizerWave> createState() => _FrequencyVisualizerWaveState();
}

class _FrequencyVisualizerWaveState extends State<FrequencyVisualizerWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant FrequencyVisualizerWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.stop();
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
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(double.infinity, widget.height),
          painter: _WavePainter(
            progress: _controller.value,
            isPlaying: widget.isPlaying,
            masterVolume: widget.masterVolume,
            freqVol: widget.frequencyVolume,
            instVol: widget.instrumentVolume,
            natVol: widget.natureVolume,
          ),
        );
      },
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress;
  final bool isPlaying;
  final double masterVolume;
  final double freqVol;
  final double instVol;
  final double natVol;

  _WavePainter({
    required this.progress,
    required this.isPlaying,
    required this.masterVolume,
    required this.freqVol,
    required this.instVol,
    required this.natVol,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height * 0.5;
    final double activeScale = isPlaying ? masterVolume.clamp(0.15, 1.0) : 0.05;

    // Background Subtle Cosmic Glow
    final Rect rect = Offset.zero & size;
    final Paint bgPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        colors: [
          const Color(0xFFD4AF37).withValues(alpha: isPlaying ? 0.08 : 0.02),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    // Wave 1: Frequency Layer (Gold / Amber Sine)
    _drawHarmonicWave(
      canvas: canvas,
      size: size,
      midY: midY,
      color: const Color(0xFFFFD700).withValues(alpha: 0.85),
      wavelength: size.width * 0.45,
      amplitude: size.height * 0.32 * activeScale * (freqVol > 0 ? freqVol : 0.2),
      phase: progress * 2 * math.pi,
      strokeWidth: 2.2,
    );

    // Wave 2: Instrument Layer (Cyan / Celestial Astral Pulse)
    _drawHarmonicWave(
      canvas: canvas,
      size: size,
      midY: midY,
      color: const Color(0xFF4EE2EC).withValues(alpha: 0.70),
      wavelength: size.width * 0.30,
      amplitude: size.height * 0.22 * activeScale * (instVol > 0 ? instVol : 0.2),
      phase: -progress * 3 * math.pi,
      strokeWidth: 1.8,
    );

    // Wave 3: Nature Layer (Emerald / Rose Temple Mist)
    _drawHarmonicWave(
      canvas: canvas,
      size: size,
      midY: midY,
      color: const Color(0xFF50C878).withValues(alpha: 0.60),
      wavelength: size.width * 0.65,
      amplitude: size.height * 0.18 * activeScale * (natVol > 0 ? natVol : 0.2),
      phase: progress * 1.5 * math.pi + 1.0,
      strokeWidth: 1.5,
    );

    // Center Baseline Glow
    final Paint centerLinePaint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.20)
      ..strokeWidth = 0.8;
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), centerLinePaint);
  }

  void _drawHarmonicWave({
    required Canvas canvas,
    required Size size,
    required double midY,
    required Color color,
    required double wavelength,
    required double amplitude,
    required double phase,
    required double strokeWidth,
  }) {
    final Path path = Path();
    final double step = 3.0;

    for (double x = 0; x <= size.width; x += step) {
      final double normalizedX = (x / wavelength) * 2 * math.pi;
      // Damping factor near edges for elegant feathering
      final double edgeDamping = math.sin((x / size.width) * math.pi);
      final double y = midY + math.sin(normalizedX + phase) * amplitude * edgeDamping;

      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isPlaying != isPlaying ||
        oldDelegate.masterVolume != masterVolume ||
        oldDelegate.freqVol != freqVol ||
        oldDelegate.instVol != instVol ||
        oldDelegate.natVol != natVol;
  }
}
