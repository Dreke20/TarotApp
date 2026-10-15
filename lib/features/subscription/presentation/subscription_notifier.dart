import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/presentation/auth_notifier.dart';
import '../data/in_app_purchase_service.dart';
import '../domain/subscription_plan.dart';
import 'subscription_state.dart';

export 'subscription_state.dart';

part 'subscription_notifier.g.dart';

@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  late final InAppPurchaseService _iapService;

  @override
  SubscriptionState build() {
    _iapService = InAppPurchaseService();
    ref.onDispose(() => _iapService.dispose());

    // Schedule initialization after the initial build cycle
    Future.microtask(() => _initializeIAP());

    return const SubscriptionState(isLoading: true);
  }

  Future<void> _initializeIAP() async {
    try {
      final prices = await _iapService.initialize(
        onPurchaseVerified: (purchase, plan) async {
          return _handleServerVerification(purchase, plan);
        },
        onError: (errorMessage) {
          state = state.copyWith(
            errorMessage: errorMessage,
            isSubmitting: false,
          );
        },
      );

      state = state.copyWith(
        isAvailable: _iapService.isAvailable,
        isLoading: false,
        localizedPrices: prices,
      );
    } catch (e) {
      debugPrint('[SubscriptionNotifier] Init error: $e');
      state = state.copyWith(isLoading: false, isAvailable: false);
    }
  }

  void selectPlan(SubscriptionPlan plan) {
    state = state.copyWith(
      selectedPlan: plan,
      errorMessage: null,
      successMessage: null,
    );
  }

  /// Triggers purchase for the currently selected plan.
  /// Uses native Google Play Billing / StoreKit if available;
  /// gracefully falls back to celestial cloud verification in development or offline mode.
  Future<bool> purchaseSelectedPlan() async {
    state = state.copyWith(isSubmitting: true, errorMessage: null, successMessage: null);

    try {
      if (state.isAvailable) {
        final launched = await _iapService.buyPlan(state.selectedPlan);
        if (launched) {
          // Native purchase sheet opened; completion is handled asynchronously via purchase stream
          return true;
        }
      }

      // Fallback: direct server verification (e.g. testing / sandbox / desktop / web)
      final planName = state.selectedPlan == SubscriptionPlan.yearly ? 'yearly' : 'monthly';
      final success = await ref.read(authNotifierProvider.notifier).activatePro(
            action: 'subscribe',
            plan: planName,
          );

      if (success) {
        state = state.copyWith(
          isSubmitting: false,
          successMessage: 'Welcome to Oracle Pro! All celestial mysteries are unlocked.',
        );
        return true;
      } else {
        final error = ref.read(authNotifierProvider).errorMessage ?? 'Subscription could not be verified.';
        state = state.copyWith(isSubmitting: false, errorMessage: error);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Restores previous purchases through native store and server records.
  Future<bool> restorePurchases() async {
    state = state.copyWith(isSubmitting: true, errorMessage: null, successMessage: null);

    try {
      if (state.isAvailable) {
        await _iapService.restorePurchases();
      }

      final success = await ref.read(authNotifierProvider.notifier).activatePro(
            action: 'restore_purchase',
          );

      if (success) {
        state = state.copyWith(
          isSubmitting: false,
          successMessage: 'Oracle Pro purchases restored successfully.',
        );
        return true;
      } else {
        final error = ref.read(authNotifierProvider).errorMessage ??
            'No active Oracle Pro subscription found to restore.';
        state = state.copyWith(isSubmitting: false, errorMessage: error);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Redeems a celestial promo code (e.g. CELESTIAL_PRO, ORACULUM_2026).
  Future<bool> redeemPromoCode(String code) async {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode.isEmpty) return false;

    state = state.copyWith(isSubmitting: true, errorMessage: null, successMessage: null);

    try {
      final success = await ref.read(authNotifierProvider.notifier).activatePro(
            action: 'redeem_promo',
            promoCode: cleanCode,
          );

      if (success) {
        state = state.copyWith(
          isSubmitting: false,
          successMessage: 'Celestial code "$cleanCode" redeemed! Welcome to Oracle Pro.',
        );
        return true;
      } else {
        final error = ref.read(authNotifierProvider).errorMessage ?? 'Invalid or expired celestial code.';
        state = state.copyWith(isSubmitting: false, errorMessage: error);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> _handleServerVerification(PurchaseDetails purchase, SubscriptionPlan plan) async {
    final receipt = purchase.verificationData.serverVerificationData;
    final source = purchase.verificationData.source;
    final planName = plan == SubscriptionPlan.yearly ? 'yearly' : 'monthly';

    final verified = await ref.read(authNotifierProvider.notifier).activatePro(
          action: 'subscribe',
          plan: planName,
          receipt: receipt,
          productId: purchase.productID,
          source: source,
        );

    if (verified) {
      state = state.copyWith(
        isSubmitting: false,
        successMessage: 'Welcome to Oracle Pro! All celestial mysteries are unlocked.',
      );
    } else {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to verify store purchase receipt with server.',
      );
    }

    return verified;
  }

  void clearMessages() {
    state = state.copyWith(errorMessage: null, successMessage: null);
  }
}

/// Backwards compatibility alias for the generated [subscriptionProvider].
final subscriptionNotifierProvider = subscriptionProvider;
