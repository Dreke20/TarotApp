import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/altar_crystal.dart';
import '../notifiers/altar_consecration_notifier.dart';
import 'crystal_grid_sheet.dart';
import 'smoke_purification_modal.dart';

/// Altar banner and 4-corner crystal grid nodes surrounding the divination board.
class CrystalGridOverlay extends ConsumerWidget {
  const CrystalGridOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(altarConsecrationNotifierProvider);
    final nw = state.crystalAt(GridCorner.topLeft) ?? AltarCrystal.clearQuartz;
    final ne = state.crystalAt(GridCorner.topRight) ?? AltarCrystal.amethyst;
    final sw = state.crystalAt(GridCorner.bottomLeft) ?? AltarCrystal.blackTourmaline;
    final se = state.crystalAt(GridCorner.bottomRight) ?? AltarCrystal.citrine;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Consecration Status & Quick Smudge Bar
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: state.isPurified
                ? const Color(0xFF161226).withValues(alpha: 0.95)
                : const Color(0xFF120E1C).withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: state.isPurified
                  ? AppColors.goldBright.withValues(alpha: 0.6)
                  : AppColors.glassBorder,
              width: state.isPurified ? 1.2 : 1.0,
            ),
            boxShadow: [
              if (state.isPurified)
                BoxShadow(
                  color: AppColors.goldBright.withValues(alpha: 0.15),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Row(
            children: [
              // Status Indicator Orb
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.isPurified
                      ? AppColors.goldBright.withValues(alpha: 0.2)
                      : AppColors.textMuted.withValues(alpha: 0.1),
                  border: Border.all(
                    color: state.isPurified ? AppColors.goldBright : AppColors.textMuted,
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: Text(
                    state.isPurified ? '✦' : '💨',
                    style: TextStyle(
                      fontSize: 11,
                      color: state.isPurified ? AppColors.goldBright : AppColors.textMuted,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Status Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.isPurified
                          ? 'ALTAR CONSECRATED · ${state.activeHerb.name.toUpperCase()}'
                          : 'ALTAR AWAITING PURIFICATION',
                      style: GoogleFonts.cinzel(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: state.isPurified ? AppColors.goldBright : AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      state.isPurified
                          ? 'Harmonized with 4 cardinal guardian crystals'
                          : 'Waft sacred smoke to clear lingering vibrations',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // Action: Open Smudge Modal
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.goldBright,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                ),
                icon: const Icon(Icons.flare, size: 14, color: AppColors.goldBright),
                label: Text(
                  state.isPurified ? 'RE-SMUDGE' : 'PURIFY',
                  style: GoogleFonts.cinzel(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                onPressed: () => SmokePurificationModal.show(context),
              ),
            ],
          ),
        ),

        // Cardinal Crystal Nodes Header & Footer Pill Row
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0B1C).withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.glassBorder.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCornerChip(context, corner: GridCorner.topLeft, crystal: nw),
              _buildCornerChip(context, corner: GridCorner.topRight, crystal: ne),
              _buildCornerChip(context, corner: GridCorner.bottomLeft, crystal: sw),
              _buildCornerChip(context, corner: GridCorner.bottomRight, crystal: se),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCornerChip(
    BuildContext context, {
    required GridCorner corner,
    required AltarCrystal crystal,
  }) {
    return GestureDetector(
      onTap: () => CrystalGridSheet.show(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: crystal.glowColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: crystal.glowColor.withValues(alpha: 0.4), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(crystal.glyph, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              corner.id == 'top_left'
                  ? 'NW'
                  : corner.id == 'top_right'
                      ? 'NE'
                      : corner.id == 'bottom_left'
                          ? 'SW'
                          : 'SE',
              style: GoogleFonts.cinzel(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: crystal.glowColor,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
