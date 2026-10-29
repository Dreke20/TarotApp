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
      final catalog = await _iapService.initialize(
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

      state = state
          .copyWith(
            isAvailable: _iapService.isAvailable,
            isLoading: false,
          )
          .withLiveCatalog(catalog);
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

  /// Starts a native store purchase for the selected plan.
  ///
  /// Pro is applied only after the store reports a purchase and its receipt
  /// is accepted. A failed or unavailable store does not grant Pro.
  Future<bool> purchaseSelectedPlan() async {
    state = state.copyWith(isSubmitting: true, errorMessage: null, successMessage: null);

    try {
      if (state.isLoading || !state.isAvailable) {
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: state.isLoading
              ? 'The store is still connecting. Try the purchase again in a moment.'
              : 'Google Play billing is unavailable. Oracle Pro can only be unlocked with a store purchase.',
        );
        return false;
      }

      final launched = await _iapService.buyPlan(
        state.selectedPlan,
        offerToken: state.offerTokenFor(state.selectedPlan),
      );
      if (!launched) {
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: 'Could not start the store purchase. Oracle Pro was not unlocked.',
        );
        return false;
      }

      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Asks the store to redeliver previous purchases.
  ///
  /// Restored entitlements arrive on the purchase stream and are verified
  /// individually. This does not grant Pro when the store has nothing to restore.
  Future<bool> restorePurchases() async {
    state = state.copyWith(isSubmitting: true, errorMessage: null, successMessage: null);

    try {
      if (state.isLoading || !state.isAvailable) {
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: state.isLoading
              ? 'The store is still connecting. Try restore again in a moment.'
              : 'The store is unavailable. Oracle Pro can only be restored from a previous purchase.',
        );
        return false;
      }

      await _iapService.restorePurchases();
      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> _handleServerVerification(PurchaseDetails purchase, SubscriptionPlan plan) async {
    final receipt = purchase.verificationData.serverVerificationData;
    final source = purchase.verificationData.source;
    final planName = plan.name;

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
