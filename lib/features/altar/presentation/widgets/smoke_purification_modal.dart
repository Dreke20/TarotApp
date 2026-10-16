import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/sacred_herb.dart';
import '../notifiers/altar_consecration_notifier.dart';
import 'smoke_particle_canvas.dart';

/// Modal dialog providing an interactive ritual for wafting sacred smoke
/// (Palo Santo, White Sage, Copal, etc.) across the altar to consecrate the cards.
class SmokePurificationModal extends ConsumerStatefulWidget {
  const SmokePurificationModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SmokePurificationModal(),
    );
  }

  @override
  ConsumerState<SmokePurificationModal> createState() => _SmokePurificationModalState();
}

class _SmokePurificationModalState extends ConsumerState<SmokePurificationModal> {
  final GlobalKey<SmokeParticleCanvasState> _canvasKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(altarConsecrationNotifierProvider);
    final notifier = ref.read(altarConsecrationNotifierProvider.notifier);
    final activeHerb = state.activeHerb;
    final progress = state.purificationProgress;
    final isDone = state.isPurified;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.88,
          decoration: BoxDecoration(
            color: const Color(0xFF0C0914),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: AppColors.goldBright.withValues(alpha: 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: activeHerb.glowColor.withValues(alpha: 0.2),
                blurRadius: 36,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              // Modal Drag Handle
              const SizedBox(height: 12),
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SACRED ALTAR SMUDGE',
                          style: GoogleFonts.cinzel(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          'Purify energy before consulting the Oracle',
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
              ),

              const SizedBox(height: 12),

              // Herb Selection Ribbon
              SizedBox(
                height: 52,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: SacredHerb.values.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final herb = SacredHerb.values[index];
                    final isSelected = herb == activeHerb;
                    return GestureDetector(
                      onTap: () => notifier.selectHerb(herb),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? herb.glowColor.withValues(alpha: 0.18)
                              : const Color(0xFF161224),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? herb.glowColor
                                : AppColors.glassBorder.withValues(alpha: 0.5),
                            width: isSelected ? 1.4 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(herb.iconText, style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 6),
                            Text(
                              herb.name,
                              style: GoogleFonts.cinzel(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Herb Botanical Detail & Mantra
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF130F1E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: activeHerb.smokeColor.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.spa, size: 14, color: activeHerb.glowColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${activeHerb.botanicalTitle} · ${activeHerb.element} — "${activeHerb.mantra}"',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.5,
                            fontStyle: FontStyle.italic,
                            color: AppColors.etherealLavender,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Interactive Altar Table Smudging Zone
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF090710),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isDone ? AppColors.goldBright : AppColors.goldMuted.withValues(alpha: 0.35),
                        width: isDone ? 1.5 : 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDone
                              ? AppColors.goldBright.withValues(alpha: 0.15)
                              : Colors.black.withValues(alpha: 0.6),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Central Altar Icon & Guidance
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: activeHerb.glowColor.withValues(alpha: 0.08),
                                  border: Border.all(
                                    color: activeHerb.glowColor.withValues(alpha: isDone ? 0.8 : 0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    isDone ? '✦' : activeHerb.iconText,
                                    style: TextStyle(
                                      fontSize: isDone ? 36 : 38,
                                      color: isDone ? AppColors.goldBright : null,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                isDone ? 'ALTAR CONSECRATED' : 'WAFT SACRED SMOKE',
                                style: GoogleFonts.cinzel(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDone ? AppColors.goldBright : AppColors.textPrimary,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  isDone
                                      ? 'The air is purified. Shadows have retreated from the sacred deck.'
                                      : 'Drag your finger across the space to waft smoke and clear stagnant vibrations.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // GPU-Accelerated Smoke Particle Simulation
                          Positioned.fill(
                            child: SmokeParticleCanvas(
                              key: _canvasKey,
                              smokeColor: activeHerb.smokeColor,
                              glowColor: activeHerb.glowColor,
                              ambientOrigin: const Offset(180, 260),
                              onWaftProgress: (delta) {
                                notifier.addWaftingProgress(delta);
                              },
                            ),
                          ),

                          // Top Purification Progress Meter
                          Positioned(
                            top: 14,
                            left: 18,
                            right: 18,
                            child: Row(
                              children: [
                                Text(
                                  'PURIFICATION:',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.goldBright,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 6,
                                      backgroundColor: const Color(0xFF1D172A),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        isDone ? AppColors.goldBright : activeHerb.glowColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${(progress * 100).round()}%',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isDone ? AppColors.goldBright : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Bottom Action Controls
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                child: Row(
                  children: [
                    if (isDone) ...[
                      OutlinedButton.icon(
                        icon: const Icon(Icons.refresh, size: 14),
                        label: Text(
                          'RE-SMUDGE',
                          style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.goldBright,
                          side: const BorderSide(color: AppColors.goldMuted),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => notifier.resetPurification(),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.goldButtonGradient,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.goldMetallic.withValues(alpha: 0.3),
                              blurRadius: 16,
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
                          onPressed: () {
                            if (!isDone) {
                              notifier.completePurification();
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            isDone ? '✦ ENTER THE SANCTUARY ✦' : 'INSTANT CONSECRATION',
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
            ],
          ),
        ),
      ),
    );
  }
}
