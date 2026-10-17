import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Central Google AdMob service managing Banner, Interstitial, and Rewarded ads.
/// Implements balanced monetization: strict frequency caps, zero ads for Pro users,
/// and web/desktop fallback safety.
class AdMobService {
  AdMobService._();
  static final AdMobService instance = AdMobService._();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  InterstitialAd? _interstitialAd;
  bool _isInterstitialLoading = false;
  DateTime? _lastInterstitialShownAt;
  int _completedReadingsSinceAd = 0;

  RewardedAd? _rewardedAd;
  bool _isRewardedLoading = false;

  // AdMob Ad Unit IDs (supports compile-time --dart-define for production with test ID fallback)
  static String get bannerAdUnitId {
    if (kIsWeb) return '';
    const customId = String.fromEnvironment('ADMOB_BANNER_ID');
    if (customId.isNotEmpty) return customId;
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    return '';
  }

  static String get interstitialAdUnitId {
    if (kIsWeb) return '';
    const customId = String.fromEnvironment('ADMOB_INTERSTITIAL_ID');
    if (customId.isNotEmpty) return customId;
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    }
    return '';
  }

  static String get rewardedAdUnitId {
    if (kIsWeb) return '';
    const customId = String.fromEnvironment('ADMOB_REWARDED_ID');
    if (customId.isNotEmpty) return customId;
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    }
    return '';
  }

  /// Whether current platform natively runs Google Mobile Ads (Android & iOS).
  bool get isNativeSupported {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }

  /// Initializes Google Mobile Ads SDK on supported mobile platforms.
  Future<void> initialize() async {
    if (_isInitialized) return;
    if (!isNativeSupported) {
      debugPrint('[AdMobService] Running on non-mobile platform or Web. Native AdMob skipped.');
      _isInitialized = true;
      return;
    }

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      debugPrint('[AdMobService] Google Mobile Ads initialized successfully.');
      // Pre-warm interstitial and rewarded ads in the background
      preloadInterstitial();
      preloadRewarded();
    } catch (e) {
      debugPrint('[AdMobService] Failed to initialize MobileAds: $e');
    }
  }

  // -------------------------------------------------------------
  // BANNER ADS
  // -------------------------------------------------------------

  /// Creates a BannerAd instance ready for loading.
  BannerAd? createBannerAd({
    required void Function(Ad ad) onAdLoaded,
    required void Function(Ad ad, LoadAdError error) onAdFailedToLoad,
  }) {
    if (!isNativeSupported) return null;
    final adUnitId = bannerAdUnitId;
    if (adUnitId.isEmpty) return null;

    return BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }

  // -------------------------------------------------------------
  // INTERSTITIAL ADS (BALANCED & FREQUENCY CAPPED)
  // -------------------------------------------------------------

  /// Pre-warms the next interstitial ad so it displays without latency when ready.
  void preloadInterstitial() {
    if (!isNativeSupported || _isInterstitialLoading || _interstitialAd != null) {
      return;
    }
    _isInterstitialLoading = true;
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoading = false;
          debugPrint('[AdMobService] Interstitial Ad preloaded.');
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isInterstitialLoading = false;
          debugPrint('[AdMobService] Interstitial Ad failed to load: ${error.message}');
        },
      ),
    );
  }

  /// Record a reading completion and check if an interstitial should be presented.
  /// Strictly capped:
  /// - Pro users: NEVER shown.
  /// - Minimum 5 minutes cooldown between ads.
  /// - Minimum 2 completed readings between ads.
  Future<bool> showInterstitialIfReady({required bool isPro}) async {
    if (isPro) return false;

    _completedReadingsSinceAd++;

    final now = DateTime.now();
    final cooldownPassed = _lastInterstitialShownAt == null ||
        now.difference(_lastInterstitialShownAt!).inMinutes >= 5;

    final reachedQuota = _completedReadingsSinceAd >= 2;

    if (!cooldownPassed || !reachedQuota) {
      return false;
    }

    if (!isNativeSupported) {
      // In web/desktop, simulate or record timestamp without interrupting
      _lastInterstitialShownAt = now;
      _completedReadingsSinceAd = 0;
      return true;
    }

    if (_interstitialAd == null) {
      preloadInterstitial();
      return false;
    }

    try {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          preloadInterstitial();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _interstitialAd = null;
          preloadInterstitial();
        },
      );

      await _interstitialAd!.show();
      _lastInterstitialShownAt = now;
      _completedReadingsSinceAd = 0;
      _interstitialAd = null;
      return true;
    } catch (e) {
      debugPrint('[AdMobService] Error showing interstitial: $e');
      _interstitialAd = null;
      preloadInterstitial();
      return false;
    }
  }

  // -------------------------------------------------------------
  // REWARDED ADS ("CELESTIAL OFFERING / STARLIGHT PASS")
  // -------------------------------------------------------------

  /// Pre-warms the next rewarded ad.
  void preloadRewarded() {
    if (!isNativeSupported || _isRewardedLoading || _rewardedAd != null) {
      return;
    }
    _isRewardedLoading = true;
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedLoading = false;
          debugPrint('[AdMobService] Rewarded Ad preloaded.');
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          _isRewardedLoading = false;
          debugPrint('[AdMobService] Rewarded Ad failed to load: ${error.message}');
        },
      ),
    );
  }

  /// Presents a rewarded ad (Celestial Incense Offering).
  /// Calls [onUserEarnedReward] upon completion.
  Future<bool> showRewardedAd({
    required bool isPro,
    required void Function() onUserEarnedReward,
  }) async {
    // Pro users automatically get the reward without ads
    if (isPro) {
      onUserEarnedReward();
      return true;
    }

    // On Web or non-mobile platforms: simulate offering completion
    if (!isNativeSupported) {
      debugPrint('[AdMobService] Simulated rewarded ad on Web/Desktop.');
      onUserEarnedReward();
      return true;
    }

    if (_rewardedAd == null) {
      preloadRewarded();
      // If ad was not pre-warmed in time, gracefully grant reward or return false
      return false;
    }

    try {
      bool rewardGranted = false;
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _rewardedAd = null;
          preloadRewarded();
          if (rewardGranted) {
            onUserEarnedReward();
          }
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _rewardedAd = null;
          preloadRewarded();
        },
      );

      await _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          rewardGranted = true;
        },
      );
      return true;
    } catch (e) {
      debugPrint('[AdMobService] Error showing rewarded ad: $e');
      _rewardedAd = null;
      preloadRewarded();
      return false;
    }
  }
}
