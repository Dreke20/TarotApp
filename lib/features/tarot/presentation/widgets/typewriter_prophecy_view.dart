import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

/// Immersive real-time typewriter prophecy view featuring animated stardust particles,
/// tactile haptic cadence, and instant skip / replay controls.
class TypewriterProphecyView extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Duration tokenCadence;
  final bool autoStart;
  final VoidCallback? onCompleted;

  const TypewriterProphecyView({
    super.key,
    required this.text,
    this.textStyle,
    this.tokenCadence = const Duration(milliseconds: 24),
    this.autoStart = true,
    this.onCompleted,
  });

  @override
  State<TypewriterProphecyView> createState() => _TypewriterProphecyViewState();
}

class _TypewriterProphecyViewState extends State<TypewriterProphecyView> {
  Timer? _streamTimer;
  int _displayedLength = 0;
  bool _isComplete = false;
  int _hapticCounter = 0;

  @override
  void initState() {
    super.initState();
    if (widget.autoStart && widget.text.isNotEmpty) {
      _startStreaming();
    } else {
      _displayedLength = widget.text.length;
      _isComplete = true;
    }
  }

  @override
  void didUpdateWidget(covariant TypewriterProphecyView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _resetAndStream();
    }
  }

  @override
  void dispose() {
    _streamTimer?.cancel();
    super.dispose();
  }

  void _resetAndStream() {
    _streamTimer?.cancel();
    setState(() {
      _displayedLength = 0;
      _isComplete = false;
      _hapticCounter = 0;
    });
    _startStreaming();
  }

  void _startStreaming() {
    _streamTimer?.cancel();
    if (widget.text.isEmpty) {
      setState(() => _isComplete = true);
      widget.onCompleted?.call();
      return;
    }

    _streamTimer = Timer.periodic(widget.tokenCadence, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        // Stream 2-3 characters at a time for smooth reading rhythm
        _displayedLength = (_displayedLength + 2).clamp(0, widget.text.length);

        _hapticCounter++;
        if (_hapticCounter % 12 == 0) {
          HapticFeedback.selectionClick();
        }

        if (_displayedLength >= widget.text.length) {
          timer.cancel();
          _isComplete = true;
          widget.onCompleted?.call();
        }
      });
    });
  }

  void _skipToComplete() {
    _streamTimer?.cancel();
    setState(() {
      _displayedLength = widget.text.length;
      _isComplete = true;
    });
    HapticFeedback.mediumImpact();
    widget.onCompleted?.call();
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = GoogleFonts.plusJakartaSans(
      fontSize: 14,
      color: AppColors.textPrimary,
      height: 1.65,
    );
    final effectiveStyle = widget.textStyle ?? defaultStyle;
    final visibleText = widget.text.substring(0, _displayedLength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Action Bar (Skip / Replay / Channeling Indicator)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (!_isComplete) ...[
                  const SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      valueColor: AlwaysStoppedAnimation(AppColors.goldBright),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SCRYING STREAM ACTIVE...',
                    style: GoogleFonts.cinzel(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                      letterSpacing: 1.1,
                    ),
                  ),
                ] else ...[
                  const Icon(Icons.check_circle_outline, size: 12, color: AppColors.etherealLavender),
                  const SizedBox(width: 6),
                  Text(
                    'PROPHECY MANIFESTED',
                    style: GoogleFonts.cinzel(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.etherealLavender,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ],
            ),
            if (!_isComplete)
              GestureDetector(
                onTap: _skipToComplete,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.goldBright.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.fast_forward, size: 12, color: AppColors.goldBright),
                      const SizedBox(width: 4),
                      Text(
                        'REVEAL ALL',
                        style: GoogleFonts.cinzel(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: _resetAndStream,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.glassFill,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.replay, size: 11, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        'REPLAY',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),

        // Text with trailing glowing celestial stardust glyph
        Text.rich(
          TextSpan(
            style: effectiveStyle,
            children: [
              TextSpan(text: visibleText),
              if (!_isComplete)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: Text(
                      '✦',
                      style: TextStyle(
                        fontSize: (effectiveStyle.fontSize ?? 14) * 0.9,
                        color: AppColors.goldBright,
                        shadows: [
                          Shadow(
                            color: AppColors.goldBright.withValues(alpha: 0.8),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.3, 1.3), duration: 400.ms),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
