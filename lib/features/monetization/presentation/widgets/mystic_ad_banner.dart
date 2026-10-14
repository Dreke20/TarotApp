import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/admob_service.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';

/// Discreet, gold-framed AdMob banner container designed for the Whispers & Warnings aesthetic.
/// Automatically collapses to 0 height for Pro seekers and provides an elegant
/// sanctuary banner fallback on Web/Desktop.
class MysticAdBanner extends ConsumerStatefulWidget {
  const MysticAdBanner({super.key});

  @override
  ConsumerState<MysticAdBanner> createState() => _MysticAdBannerState();
}

class _MysticAdBannerState extends ConsumerState<MysticAdBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _isDismissed = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    final isPro = ref.read(isProUserProvider);
    if (isPro || !AdMobService.instance.isNativeSupported) return;

    _bannerAd = AdMobService.instance.createBannerAd(
      onAdLoaded: (ad) {
        if (mounted) setState(() => _isLoaded = true);
      },
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        if (mounted) setState(() => _isLoaded = false);
      },
    );
    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPro = ref.watch(isProUserProvider);
    if (isPro || _isDismissed) {
      return const SizedBox.shrink();
    }

    // On native mobile with loaded AdMob banner
    if (AdMobService.instance.isNativeSupported && _bannerAd != null && _isLoaded) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.backgroundMidnight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.glassBorder, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    'SPONSORED SANCTUARY OFFERING',
                    style: GoogleFonts.cinzel(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldMuted,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isDismissed = true),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.close, size: 14, color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
          ],
        ),
      );
    }

    // On Web / Desktop / Test environment: display elegant subtle house banner
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundMidnight.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.25), width: 0.8),
      ),
      child: Row(
        children: [
          const Text('✦', style: TextStyle(color: AppColors.goldBright, fontSize: 13)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Experience an ad-free sanctuary & unlimited Celtic Cross spreads with Oracle Pro.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => OracleProModal.show(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.goldButtonGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'GO PRO',
                style: GoogleFonts.cinzel(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF09080C),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => setState(() => _isDismissed = true),
            child: const Icon(Icons.close, size: 14, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
