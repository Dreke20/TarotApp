import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';
import '../../../tarot/domain/spread_type.dart';
import '../monetization_notifier.dart';

/// Modal dialog presented when a seeker requests a locked celestial spread or feature.
/// Offers the choice between upgrading to Oracle Pro or making a free
/// "Celestial Offering" (Rewarded Ad) to unlock the feature immediately.
class StarlightOfferingModal extends ConsumerStatefulWidget {
  final SpreadType? requestedSpread;
  final VoidCallback? onUnlocked;

  const StarlightOfferingModal({
    super.key,
    this.requestedSpread,
    this.onUnlocked,
  });

  static Future<void> show(
    BuildContext context, {
    SpreadType? requestedSpread,
    VoidCallback? onUnlocked,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StarlightOfferingModal(
        requestedSpread: requestedSpread,
        onUnlocked: onUnlocked,
      ),
    );
  }

  @override
  ConsumerState<StarlightOfferingModal> createState() =>
      _StarlightOfferingModalState();
}

class _StarlightOfferingModalState
    extends ConsumerState<StarlightOfferingModal> {
  bool _isLoading = false;

  Future<void> _handleWatchAd() async {
    setState(() => _isLoading = true);
    final isPro = ref.read(isProUserProvider);
    final notifier = ref.read(monetizationProvider.notifier);

    final success = await notifier.makeCelestialOffering(isPro: isPro);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.of(context).pop();
      widget.onUnlocked?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '✦ Celestial Offering Accepted! Sacred Spread Unlocked. ✦',
            style: TextStyle(color: AppColors.goldBright),
          ),
          backgroundColor: AppColors.backgroundMidnight,
        ),
      );
    } else {
      final msg = ref.read(monetizationProvider).message ??
          'The celestial offering could not be loaded at this moment.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spreadTitle =
        widget.requestedSpread?.title.toUpperCase() ?? 'SACRED PROPHECY';
    final monetization = ref.watch(monetizationProvider);

    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: AppColors.backgroundMidnight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 36,
            spreadRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Emblem
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.goldButtonGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldCandle.withValues(alpha: 0.35),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('✨', style: TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'UNLOCK $spreadTitle',
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This comprehensive alignment spread is reserved for our honored Seekers. Choose your path to unveil the wisdom:',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),

              if (monetization.starlightPassTokens > 0) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.glassFillStrong,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.goldBright),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.stars, color: AppColors.goldBright, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'You have ${monetization.starlightPassTokens} Starlight Pass(es) available',
                        style: GoogleFonts.cinzel(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Option 1: Rewarded Offering (Free)
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.goldButtonGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldMetallic.withValues(alpha: 0.35),
                        blurRadius: 16,
                        spreadRadius: 1,
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
                    onPressed: _isLoading ? null : _handleWatchAd,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF09080C)),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.ondemand_video,
                                  size: 18, color: Color(0xFF09080C)),
                              const SizedBox(width: 8),
                              Text(
                                '✦ OFFER CELESTIAL INCENSE (WATCH AD) ✦',
                                style: GoogleFonts.cinzel(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: const Color(0xFF09080C),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Option 2: Oracle Pro (Paid)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.goldBright,
                    side: const BorderSide(color: AppColors.goldBright, width: 1.2),
                    backgroundColor: AppColors.glassFill,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    OracleProModal.show(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.workspace_premium,
                          size: 16, color: AppColors.goldBright),
                      const SizedBox(width: 8),
                      Text(
                        'UPGRADE TO ORACLE PRO (AD-FREE FOREVER)',
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

              const SizedBox(height: 10),

              // Dismiss
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Dismiss for now',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
