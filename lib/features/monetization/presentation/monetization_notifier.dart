import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/admob_service.dart';
import '../../../core/services/encrypted_vault_storage.dart';
import 'monetization_state.dart';

export 'monetization_state.dart';

part 'monetization_notifier.g.dart';

const String _prefStarlightTokens = 'oraculum_starlight_tokens';
const String _prefTotalOfferings = 'oraculum_total_offerings';

@Riverpod(keepAlive: true)
class MonetizationNotifier extends _$MonetizationNotifier {
  @override
  MonetizationState build() {
    _loadPersistedTokens();
    return const MonetizationState();
  }

  Future<void> _loadPersistedTokens() async {
    try {
      final tokens = await EncryptedVaultStorage.instance.getSignedInt(_prefStarlightTokens);
      final offerings = await EncryptedVaultStorage.instance.getSignedInt(_prefTotalOfferings);
      state = state.copyWith(
        starlightPassTokens: tokens,
        totalOfferingsMade: offerings,
      );
    } catch (_) {}
  }

  /// Consumes 1 Starlight Pass token when unlocking a premium spread or reading.
  Future<bool> consumeStarlightPass() async {
    if (state.starlightPassTokens <= 0) return false;
    final updatedTokens = state.starlightPassTokens - 1;
    state = state.copyWith(starlightPassTokens: updatedTokens);
    try {
      await EncryptedVaultStorage.instance.setSignedInt(_prefStarlightTokens, updatedTokens);
    } catch (_) {}
    return true;
  }

  /// Initiates a Celestial Starlight Offering (Rewarded AdMob video).
  /// Grants 1 Starlight Pass token upon ad completion.
  Future<bool> makeCelestialOffering({required bool isPro}) async {
    state = state.copyWith(isOfferingInProgress: true, message: null);

    bool granted = false;
    final result = await AdMobService.instance.showRewardedAd(
      isPro: isPro,
      onUserEarnedReward: () {
        granted = true;
      },
    );

    if (granted || isPro) {
      final newTokens = state.starlightPassTokens + 1;
      final newOfferings = state.totalOfferingsMade + 1;
      state = state.copyWith(
        starlightPassTokens: newTokens,
        totalOfferingsMade: newOfferings,
        lastOfferingAt: DateTime.now(),
        isOfferingInProgress: false,
        message: '✦ Celestial Starlight Received! 1 Sacred Pass added to your inventory. ✦',
      );
      try {
        await EncryptedVaultStorage.instance.setSignedInt(_prefStarlightTokens, newTokens);
        await EncryptedVaultStorage.instance.setSignedInt(_prefTotalOfferings, newOfferings);
      } catch (_) {}
      return true;
    } else {
      state = state.copyWith(
        isOfferingInProgress: false,
        message: result ? null : 'The celestial offering could not be loaded at this moment.',
      );
      return false;
    }
  }

  /// Grants bonus Starlight Pass tokens for maintaining daily devotion streaks
  Future<void> grantStreakBonus(int bonusCount) async {
    final updatedTokens = state.starlightPassTokens + bonusCount;
    state = state.copyWith(
      starlightPassTokens: updatedTokens,
      message: '✦ Daily Devotion Honored! $bonusCount Sacred Starlight Passes granted. ✦',
    );
    try {
      await EncryptedVaultStorage.instance.setSignedInt(_prefStarlightTokens, updatedTokens);
    } catch (_) {}
  }

  /// Evaluates and presents a post-reading interstitial ad if cooldown & frequency criteria match.
  Future<bool> showPostReadingAdIfEligible({required bool isPro}) async {
    return AdMobService.instance.showInterstitialIfReady(isPro: isPro);
  }
}
