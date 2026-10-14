import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../notifiers/collective_notifier.dart';

class CollectiveSanctuaryScreen extends ConsumerStatefulWidget {
  const CollectiveSanctuaryScreen({super.key});

  @override
  ConsumerState<CollectiveSanctuaryScreen> createState() => _CollectiveSanctuaryScreenState();
}

class _CollectiveSanctuaryScreenState extends ConsumerState<CollectiveSanctuaryScreen> {
  final _wishController = TextEditingController();
  bool _isReleasing = false;

  @override
  void dispose() {
    _wishController.dispose();
    super.dispose();
  }

  void _submitWish() {
    final text = _wishController.text.trim();
    if (text.isEmpty) return;

    final profile = ref.read(authNotifierProvider).profile;
    final sign = profile?.zodiacSign ?? 'Seeker';

    setState(() => _isReleasing = true);
    ref.read(sensoryServiceProvider).completionHaptic();

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      ref.read(collectiveProvider.notifier).releaseWish(text, sign);
      _wishController.clear();
      setState(() => _isReleasing = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Your star intention has been consecrated into the cosmic collective!',
            style: GoogleFonts.plusJakartaSans(),
          ),
          backgroundColor: AppColors.backgroundMidnight,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final pulse = ref.watch(collectiveProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.goldBright),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'COLLECTIVE CONSCIOUSNESS',
          style: GoogleFonts.cinzel(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.4),
            radius: 1.3,
            colors: [
              AppColors.backgroundViolet.withValues(alpha: 0.5),
              AppColors.backgroundDeep,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Global Tarot Pulse Mandala
              GlassContainer(
                borderRadius: 22,
                padding: const EdgeInsets.all(20),
                fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.85),
                borderColor: AppColors.goldBright.withValues(alpha: 0.5),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cosmicSurface.withValues(alpha: 0.5),
                        border: Border.all(color: AppColors.goldBright, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.goldBright.withValues(alpha: 0.3),
                            blurRadius: 32,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('✨', style: TextStyle(fontSize: 40)),
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(begin: const Offset(0.96, 0.96), end: const Offset(1.04, 1.04), duration: 2.5.seconds),
                    const SizedBox(height: 16),
                    Text(
                      'TODAY\'S GLOBAL DOMINANT ENERGY',
                      style: GoogleFonts.cinzel(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.etherealLavender,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      pulse.dominantGlobalCardName,
                      style: GoogleFonts.cinzel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      pulse.dominantAuraEnergy,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.goldBright.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        '${pulse.totalReadingsToday} READINGS CONSECRATED WORLDWIDE TODAY',
                        style: GoogleFonts.cinzel(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.05, end: 0),

              const SizedBox(height: 18),

              // Frequency Heatmap
              GlassContainer(
                borderRadius: 18,
                padding: const EdgeInsets.all(16),
                fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.75),
                borderColor: AppColors.glassBorder,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GLOBAL ARCANA FREQUENCIES',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.etherealLavender,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...pulse.topDrawnCards.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 13, color: AppColors.goldBright),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Wish Upon A Star Intention Well
              Text(
                'WISH UPON A STAR • CONSTELLATION WELL',
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),

              GlassContainer(
                borderRadius: 18,
                padding: const EdgeInsets.all(16),
                fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.8),
                borderColor: AppColors.goldBright.withValues(alpha: 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cast an intention, blessing, or prayer into the starry vault for all wandering souls:',
                      style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _wishController,
                      maxLines: 3,
                      style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'e.g. May courage and radiant clarity find whoever reads this today...',
                        hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 12),
                        filled: true,
                        fillColor: AppColors.glassFillStrong,
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.glassBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.glassBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.goldBright),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.goldBright,
                          foregroundColor: AppColors.backgroundDeep,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 4,
                        ),
                        onPressed: _isReleasing ? null : _submitWish,
                        icon: _isReleasing
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.backgroundDeep),
                              )
                            : const Icon(Icons.flare, size: 18),
                        label: Text(
                          _isReleasing ? 'ASCENDING TO THE STARS...' : 'RELEASE WISH TO THE COSMOS',
                          style: GoogleFonts.cinzel(fontSize: 11.5, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Live Communal Whispers
              Text(
                'COLLECTIVE CONSTELLATION WHISPERS',
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),

              ...pulse.recentWishes.asMap().entries.map((entry) {
                final wish = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassContainer(
                    borderRadius: 14,
                    padding: const EdgeInsets.all(14),
                    fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.7),
                    borderColor: AppColors.glassBorder,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '★ ${wish.zodiacSign.toUpperCase()} SEEKER',
                              style: GoogleFonts.cinzel(
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                              ),
                            ),
                            Text(
                              'Just now',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '"${wish.intention}"',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: AppColors.textPrimary.withValues(alpha: 0.9),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 300.ms, delay: (entry.key * 50).ms).slideY(begin: 0.05, end: 0);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
