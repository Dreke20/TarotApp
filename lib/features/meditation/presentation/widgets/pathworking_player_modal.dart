import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/holographic_foil_card.dart';
import '../../../tarot/presentation/notifiers/oracle_persona_notifier.dart';
import '../../domain/archetypal_pathworking.dart';
import '../../services/pathworking_engine_service.dart';

/// Full-screen immersive audio player for guided archetypal pathworkings.
class PathworkingPlayerModal extends ConsumerStatefulWidget {
  final ArchetypalPathworking pathworking;
  final ValueChanged<String>? onRevelationAnchored;

  const PathworkingPlayerModal({
    super.key,
    required this.pathworking,
    this.onRevelationAnchored,
  });

  static Future<void> show(
    BuildContext context, {
    required ArchetypalPathworking pathworking,
    ValueChanged<String>? onRevelationAnchored,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PathworkingPlayerModal(
        pathworking: pathworking,
        onRevelationAnchored: onRevelationAnchored,
      ),
    );
  }

  @override
  ConsumerState<PathworkingPlayerModal> createState() =>
      _PathworkingPlayerModalState();
}

class _PathworkingPlayerModalState
    extends ConsumerState<PathworkingPlayerModal> {
  final PathworkingEngineService _engine = PathworkingEngineService.instance;

  @override
  void initState() {
    super.initState();
    _engine.onStateChanged = () {
      if (mounted) setState(() {});
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final persona = ref.read(oraclePersonaProvider);
      _engine.startPathworking(widget.pathworking, persona: persona);
    });
  }

  @override
  void dispose() {
    _engine.stop();
    _engine.onStateChanged = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final persona = ref.watch(oraclePersonaProvider);
    final currentStep = widget.pathworking.steps[_engine.currentStepIndex];
    final totalSteps = widget.pathworking.steps.length;

    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: BoxDecoration(
        color: const Color(0xFF090710),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(
          color: AppColors.goldBright.withValues(alpha: 0.35),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.9),
            blurRadius: 36,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.goldMuted.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),

          // Header Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.self_improvement,
                            color: AppColors.goldBright, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'ARCHETYPAL PATHWORKING',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.pathworking.title,
                      style: GoogleFonts.cinzel(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close,
                      color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Scrollable Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Floating Card Archetype with Holographic Foil
                  Center(
                    child: HolographicFoilCard(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 130,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.goldBright.withValues(alpha: 0.6),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.goldBright.withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/cards/${widget.pathworking.cardId}.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFF130E20),
                              alignment: Alignment.center,
                              child: Text(
                                widget.pathworking.cardName,
                                style: GoogleFonts.cinzel(
                                  color: AppColors.goldBright,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Soundscape & Persona Pills
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.glassFillStrong,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.goldBright.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.music_note,
                                size: 12, color: AppColors.goldBright),
                            const SizedBox(width: 5),
                            Text(
                              widget.pathworking.soundscapeName,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.goldBright,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: persona.accentColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: persona.accentColor.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.record_voice_over,
                                size: 12, color: persona.accentColor),
                            const SizedBox(width: 5),
                            Text(
                              persona.title,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: persona.accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Step Progress Tracker
                  Row(
                    children: [
                      Text(
                        'STEP ${_engine.currentStepIndex + 1} OF $totalSteps',
                        style: GoogleFonts.cinzel(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_engine.secondsRemainingInStep}s',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: (_engine.currentStepIndex + 1) / totalSteps,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.goldBright),
                    borderRadius: BorderRadius.circular(3),
                    minHeight: 4,
                  ),
                  const SizedBox(height: 14),

                  // Current Step Guidance Subtitles Box
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF140F22),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.goldBright.withValues(alpha: 0.25),
                          width: 1.0,
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentStep.title,
                              style: GoogleFonts.cinzel(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              currentStep.guidanceText,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.5,
                                height: 1.6,
                                color: AppColors.textPrimary
                                    .withValues(alpha: 0.95),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Player Controls Footer
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Play / Pause Button
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.goldButtonGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldBright.withValues(alpha: 0.35),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: IconButton(
                    iconSize: 28,
                    icon: Icon(
                      _engine.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: const Color(0xFF0C0A14),
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      if (_engine.isPlaying) {
                        _engine.pause();
                      } else {
                        _engine.resume(persona: persona);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 18),

                // Anchor Revelation to Altar Button
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.goldBright,
                      side: BorderSide(
                        color: AppColors.goldBright.withValues(alpha: 0.6),
                        width: 1.2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      final intention =
                          'What wisdom does ${widget.pathworking.cardName} reveal for my journey?';
                      widget.onRevelationAnchored?.call(intention);
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.anchor, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'ANCHOR TO ALTAR',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
