import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/celestial_voice_service.dart';
import '../../domain/oracle_persona.dart';
import '../notifiers/oracle_persona_notifier.dart';
import 'glass_container.dart';

/// Modal bottom sheet allowing seekers to select their divine Oracle Guide persona
/// with real-time acoustic vocal tuning, cadence inspection, and spoken auditions.
class OraclePersonaSelectorModal extends ConsumerStatefulWidget {
  const OraclePersonaSelectorModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const OraclePersonaSelectorModal(),
    );
  }

  @override
  ConsumerState<OraclePersonaSelectorModal> createState() =>
      _OraclePersonaSelectorModalState();
}

class _OraclePersonaSelectorModalState
    extends ConsumerState<OraclePersonaSelectorModal> {
  final CelestialVoiceService _voice = CelestialVoiceService.instance;

  @override
  void initState() {
    super.initState();
    _voice.init();
    _voice.onStarted = () {
      if (mounted) setState(() {});
    };
    _voice.onStopped = () {
      if (mounted) setState(() {});
    };
  }

  @override
  void dispose() {
    _voice.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activePersona = ref.watch(oraclePersonaNotifierProvider);
    final mediaQuery = MediaQuery.of(context);
    final isAuditioning = _voice.isPlaying;
    final auditioningId = _voice.currentlyAuditioningId;

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.88,
      ),
      margin: const EdgeInsets.only(top: 24),
      child: GlassContainer(
        borderRadius: 28,
        blur: 26,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.96),
        borderColor: AppColors.goldBright,
        borderWidth: 1.6,
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
            const SizedBox(height: 16),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.psychology_outlined,
                        color: AppColors.goldBright, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'ORACLE ARCHETYPE',
                      style: GoogleFonts.cinzel(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 2.0,
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
              'Select and audition the sacred voice that channels your readings',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const Divider(color: AppColors.glassBorder, height: 20),

            // List of personas
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: OraclePersona.values.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final persona = OraclePersona.values[index];
                  final isSelected = persona == activePersona;
                  final isThisAuditioning =
                      isAuditioning && auditioningId == persona.id;

                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      ref
                          .read(oraclePersonaNotifierProvider.notifier)
                          .selectPersona(persona);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.cosmicSurface
                            : AppColors.glassFill,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? persona.accentColor
                              : AppColors.glassBorder,
                          width: isSelected ? 2.0 : 1.0,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: persona.accentColor
                                      .withValues(alpha: 0.25),
                                  blurRadius: 14,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: persona.accentColor
                                      .withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: persona.accentColor
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                                child: Icon(persona.icon,
                                    color: persona.accentColor, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      persona.title,
                                      style: GoogleFonts.cinzel(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? AppColors.goldBright
                                            : AppColors.textPrimary,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    Text(
                                      persona.subtitle,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: persona.accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? persona.accentColor
                                        : AppColors.textMuted,
                                    width: 2,
                                  ),
                                  color: isSelected
                                      ? persona.accentColor
                                      : Colors.transparent,
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check,
                                        size: 14, color: Color(0xFF09080C))
                                    : null,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            persona.description,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.5,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Sample Quote
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.glassFill,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.glassBorder
                                      .withValues(alpha: 0.5)),
                            ),
                            child: Text(
                              persona.sampleQuote,
                              style: GoogleFonts.cinzel(
                                fontSize: 10.5,
                                fontStyle: FontStyle.italic,
                                color:
                                    AppColors.textPrimary.withValues(alpha: 0.9),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Acoustic Vocal Tuning & Audition Strip
                          Row(
                            children: [
                              // Acoustic Timbre Badge
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: persona.accentColor
                                        .withValues(alpha: 0.10),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: persona.accentColor
                                          .withValues(alpha: 0.35),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.graphic_eq,
                                          size: 13,
                                          color: persona.accentColor),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          '${persona.timbreTitle} • ${persona.speechRate}x • ${persona.solfeggioFrequency}',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 9.5,
                                            fontWeight: FontWeight.w600,
                                            color: persona.accentColor,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Audition Voice Button
                              InkWell(
                                onTap: () async {
                                  HapticFeedback.selectionClick();
                                  if (isThisAuditioning) {
                                    await _voice.stop();
                                  } else {
                                    await _voice.auditionPersona(persona);
                                  }
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isThisAuditioning
                                        ? persona.accentColor
                                        : AppColors.glassFillStrong,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isThisAuditioning
                                          ? persona.accentColor
                                          : AppColors.goldMuted
                                              .withValues(alpha: 0.5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        isThisAuditioning
                                            ? Icons.stop
                                            : Icons.volume_up_outlined,
                                        size: 13,
                                        color: isThisAuditioning
                                            ? const Color(0xFF09080C)
                                            : AppColors.goldBright,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        isThisAuditioning
                                            ? 'STOP'
                                            : 'AUDITION',
                                        style: GoogleFonts.cinzel(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                          color: isThisAuditioning
                                              ? const Color(0xFF09080C)
                                              : AppColors.goldBright,
                                          letterSpacing: 0.6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
