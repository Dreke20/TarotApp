import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../tarot/presentation/notifiers/oracle_persona_notifier.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import 'breathing_orb_widget.dart';

/// Full-screen ritual modal guiding the seeker through the ancient 4-7-8 intention centering breath.
/// Calms autonomic nervous system, anchors the seeker's inquiry into the heart center,
/// and readies the tarot deck with consecrated presence.
class SacredBreathingModal extends ConsumerStatefulWidget {
  final String? initialQuestion;
  final ValueChanged<String>? onIntentionSet;

  const SacredBreathingModal({
    super.key,
    this.initialQuestion,
    this.onIntentionSet,
  });

  static Future<void> show(
    BuildContext context, {
    String? initialQuestion,
    ValueChanged<String>? onIntentionSet,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SacredBreathingModal(
        initialQuestion: initialQuestion,
        onIntentionSet: onIntentionSet,
      ),
    );
  }

  @override
  ConsumerState<SacredBreathingModal> createState() =>
      _SacredBreathingModalState();
}

class _SacredBreathingModalState extends ConsumerState<SacredBreathingModal>
    with TickerProviderStateMixin {
  late final TextEditingController _intentionController;
  late final AnimationController _scaleController;
  late final AnimationController _pulseController;

  Timer? _countdownTimer;
  BreathingPhase _phase = BreathingPhase.inhale;
  late int _secondsRemaining;
  int _completedCycles = 0;
  bool _isPaused = false;

  final List<String> _intentionPresets = const [
    '✦ Clarity on my next threshold',
    '✦ Guidance for inner healing & truth',
    '✦ What blessings are unfolding in love?',
    '✦ Alchemical willpower for my work',
    '✦ Shadow integration and courage',
  ];

  @override
  void initState() {
    super.initState();
    _intentionController =
        TextEditingController(text: widget.initialQuestion ?? '');
    _secondsRemaining = _phase.durationSeconds;

    // Scale animation driving radial expansion & contraction
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _phase.durationSeconds),
    );

    // Continuous heartbeat pulse controller
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _startPhase(_phase);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _scaleController.dispose();
    _pulseController.dispose();
    _intentionController.dispose();
    super.dispose();
  }

  void _startPhase(BreathingPhase newPhase) {
    _countdownTimer?.cancel();
    setState(() {
      _phase = newPhase;
      _secondsRemaining = newPhase.durationSeconds;
    });

    final sensory = ref.read(sensoryServiceProvider);
    sensory.breathPhaseHaptic();

    if (newPhase == BreathingPhase.inhale) {
      _scaleController.duration = Duration(seconds: newPhase.durationSeconds);
      _scaleController.forward(from: 0.0);
    } else if (newPhase == BreathingPhase.hold) {
      _scaleController.value = 1.0;
    } else if (newPhase == BreathingPhase.exhale) {
      _scaleController.duration = Duration(seconds: newPhase.durationSeconds);
      _scaleController.reverse(from: 1.0);
    }

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;

      if (_secondsRemaining > 1) {
        setState(() => _secondsRemaining--);
        if (_phase == BreathingPhase.hold) {
          sensory.sacredHeartbeatHaptic();
        } else {
          sensory.breathTickHaptic();
        }
      } else {
        _transitionToNextPhase();
      }
    });
  }

  void _transitionToNextPhase() {
    final sensory = ref.read(sensoryServiceProvider);

    if (_phase == BreathingPhase.inhale) {
      _startPhase(BreathingPhase.hold);
    } else if (_phase == BreathingPhase.hold) {
      _startPhase(BreathingPhase.exhale);
    } else if (_phase == BreathingPhase.exhale) {
      setState(() {
        _completedCycles++;
      });
      if (_completedCycles >= 3) {
        sensory.completionHaptic();
      }
      _startPhase(BreathingPhase.inhale);
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _scaleController.stop();
      } else {
        if (_phase == BreathingPhase.inhale) {
          _scaleController.forward();
        } else if (_phase == BreathingPhase.exhale) {
          _scaleController.reverse();
        }
      }
    });
    HapticFeedback.selectionClick();
  }

  void _completeAndBlessAltar() {
    final intention = _intentionController.text.trim();
    ref.read(sensoryServiceProvider).completionHaptic();
    widget.onIntentionSet?.call(intention);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final persona = ref.watch(oraclePersonaNotifierProvider);
    final accent = persona.accentColor;

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.94,
      ),
      margin: const EdgeInsets.only(top: 24),
      child: GlassContainer(
        borderRadius: 28,
        blur: 26,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.96),
        borderColor: accent.withValues(alpha: 0.8),
        borderWidth: 1.8,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Top Header: Title & Close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.air, color: accent, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'SACRED 4-7-8 CENTERING',
                      style: GoogleFonts.cinzel(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Text(
              'Ground your nervous system and anchor your intention before drawing',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 10),

            // Cycle Indicator Badge & Pause Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: accent.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.repeat, size: 13, color: accent),
                      const SizedBox(width: 6),
                      Text(
                        'SACRED CYCLE ${_completedCycles + 1} OF 3',
                        style: GoogleFonts.cinzel(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 1.2,
                        ),
                      ),
                      if (_completedCycles >= 3) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.check_circle,
                            size: 13, color: AppColors.goldBright),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: _togglePause,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.glassFillStrong,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isPaused ? Icons.play_arrow : Icons.pause,
                          size: 13,
                          color: AppColors.goldBright,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _isPaused ? 'RESUME' : 'PAUSE',
                          style: GoogleFonts.cinzel(
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Dynamic Guidance Text
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Column(
                        key: ValueKey(_phase),
                        children: [
                          Text(
                            _phase.guidance,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cinzel(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _phase.subGuidance,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Breathing Orb
                    AnimatedBuilder(
                      animation: Listenable.merge(
                          [_scaleController, _pulseController]),
                      builder: (context, child) {
                        return BreathingOrbWidget(
                          phase: _phase,
                          secondsRemaining: _secondsRemaining,
                          scale: _scaleController.value,
                          pulseValue: _pulseController.value,
                          persona: persona,
                          size: 240,
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Intention Anchor Input Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.glassFillStrong,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.35),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.psychology, size: 16, color: accent),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'ANCHOR YOUR INTENTION INTO THE BREATH',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.goldBright,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _intentionController,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'Speak or hold your intention in mind...',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: AppColors.textMuted,
                              ),
                              filled: true,
                              fillColor: AppColors.backgroundMidnight
                                  .withValues(alpha: 0.6),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: AppColors.glassBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: accent),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Quick Preset Intention Chips
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: _intentionPresets.map((preset) {
                              return InkWell(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  _intentionController.text =
                                      preset.replaceFirst('✦ ', '');
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.glassFill,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.goldMuted
                                          .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    preset,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Action: Consecrate & Draw
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppColors.goldButtonGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldMetallic.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: const Color(0xFF09080C),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _completeAndBlessAltar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('✦',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF09080C))),
                    const SizedBox(width: 8),
                    Text(
                      _completedCycles >= 3
                          ? 'MIND CENTERED · BLESS DECK & RETURN'
                          : 'CONSECRATE INTENTION & RETURN',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: const Color(0xFF09080C),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('✦',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF09080C))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
