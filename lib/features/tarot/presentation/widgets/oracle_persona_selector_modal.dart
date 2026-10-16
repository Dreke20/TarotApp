import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/oracle_persona.dart';
import '../notifiers/oracle_persona_notifier.dart';
import 'glass_container.dart';

/// Modal bottom sheet allowing seekers to select their divine Oracle Guide persona.
class OraclePersonaSelectorModal extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final activePersona = ref.watch(oraclePersonaNotifierProvider);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.85,
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
                    const Icon(Icons.psychology_outlined, color: AppColors.goldBright, size: 22),
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
              'Select the sacred voice that channels your divination',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const Divider(color: AppColors.glassBorder, height: 22),

            // List of personas
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: OraclePersona.values.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final persona = OraclePersona.values[index];
                  final isSelected = persona == activePersona;

                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      ref.read(oraclePersonaNotifierProvider.notifier).selectPersona(persona);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.cosmicSurface : AppColors.glassFill,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? persona.accentColor : AppColors.glassBorder,
                          width: isSelected ? 2.0 : 1.0,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: persona.accentColor.withValues(alpha: 0.25),
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
                                  color: persona.accentColor.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: persona.accentColor.withValues(alpha: 0.5),
                                  ),
                                ),
                                child: Icon(persona.icon, color: persona.accentColor, size: 20),
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
                                        color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
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
                                    color: isSelected ? persona.accentColor : AppColors.textMuted,
                                    width: 2,
                                  ),
                                  color: isSelected ? persona.accentColor : Colors.transparent,
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check, size: 14, color: Color(0xFF09080C))
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.glassFill,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.glassBorder.withValues(alpha: 0.5)),
                            ),
                            child: Text(
                              persona.sampleQuote,
                              style: GoogleFonts.cinzel(
                                fontSize: 10.5,
                                fontStyle: FontStyle.italic,
                                color: AppColors.textPrimary.withValues(alpha: 0.9),
                              ),
                            ),
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
