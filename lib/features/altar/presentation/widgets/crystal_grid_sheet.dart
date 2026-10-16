import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/altar_crystal.dart';
import '../notifiers/altar_consecration_notifier.dart';

/// Interactive modal sheet to configure guardian crystals on the 4 altar corners.
class CrystalGridSheet extends ConsumerWidget {
  const CrystalGridSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CrystalGridSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(altarConsecrationNotifierProvider);
    final notifier = ref.read(altarConsecrationNotifierProvider.notifier);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0A18),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: AppColors.goldBright.withValues(alpha: 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.goldBright.withValues(alpha: 0.15),
                blurRadius: 36,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
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

              // Title Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SACRED CRYSTAL GRID',
                        style: GoogleFonts.cinzel(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 2.0,
                        ),
                      ),
                      Text(
                        'Anchor cardinal elemental guardians around the altar',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: AppColors.textMuted,
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

              const SizedBox(height: 14),

              // Grid Corner Cards
              ...GridCorner.values.map((corner) {
                final crystal = state.crystalAt(corner) ?? AltarCrystal.clearQuartz;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151024),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: crystal.glowColor.withValues(alpha: 0.4),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Glyph Avatar
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: crystal.glowColor.withValues(alpha: 0.15),
                            border: Border.all(color: crystal.glowColor.withValues(alpha: 0.6)),
                          ),
                          child: Center(
                            child: Text(
                              crystal.glyph,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Corner & Crystal Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${corner.directionGlyph} ${corner.cardinalLabel.toUpperCase()}',
                                style: GoogleFonts.cinzel(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.goldBright,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                crystal.name,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                '${crystal.element} · ${crystal.chakra} Chakra — "${crystal.affirmation}"',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Change Button
                        TextButton(
                          onPressed: () => _showCrystalPicker(context, corner, notifier),
                          child: Text(
                            'CHANGE',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 8),

              // Done Button
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.goldButtonGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: const Color(0xFF09080C),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'CONSECRATE GUARDIAN MATRIX',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: const Color(0xFF09080C),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCrystalPicker(
    BuildContext context,
    GridCorner corner,
    AltarConsecrationNotifier notifier,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF100D1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.goldBright, width: 1.2),
        ),
        title: Text(
          'SELECT ${corner.title.toUpperCase()} GUARDIAN',
          style: GoogleFonts.cinzel(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 1.5,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: AltarCrystal.values.length,
            separatorBuilder: (context, index) => const Divider(color: AppColors.glassBorder, height: 1),
            itemBuilder: (context, i) {
              final c = AltarCrystal.values[i];
              return ListTile(
                leading: Text(c.glyph, style: const TextStyle(fontSize: 22)),
                title: Text(
                  c.name,
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  '${c.element} · ${c.chakra} Chakra',
                  style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: AppColors.textMuted),
                ),
                onTap: () {
                  notifier.placeCrystal(corner, c);
                  Navigator.of(ctx).pop();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
