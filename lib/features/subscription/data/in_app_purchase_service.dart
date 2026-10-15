import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../domain/subscription_plan.dart';

/// Callback signature for handling completed purchase verification with backend.
typedef OnPurchaseVerified = Future<bool> Function(
  PurchaseDetails purchaseDetails,
  SubscriptionPlan plan,
);

/// Service managing native Google Play Billing & Apple StoreKit purchase flows.
class InAppPurchaseService {
  final InAppPurchase? _customIap;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = const [];
  bool _isAvailable = false;

  InAppPurchaseService({InAppPurchase? iap}) : _customIap = iap;

  InAppPurchase? get _iap {
    if (_customIap != null) return _customIap;
    try {
      return InAppPurchase.instance;
    } catch (e) {
      debugPrint('[IAP] InAppPurchase.instance unavailable: $e');
      return null;
    }
  }

  bool get isAvailable => _isAvailable;
  List<ProductDetails> get products => _products;

  /// Initializes store connection and queries available subscription product details.
  Future<Map<String, String>> initialize({
    required OnPurchaseVerified onPurchaseVerified,
    required void Function(String error) onError,
  }) async {
    try {
      final iap = _iap;
      if (iap == null) {
        _isAvailable = false;
        debugPrint('[IAP] Platform in-app purchase instance could not be resolved.');
        return const {};
      }

      _isAvailable = await iap.isAvailable();
      if (!_isAvailable) {
        debugPrint('[IAP] Store is not available on this platform/device.');
        return const {};
      }

      // Listen to the native purchase stream
      _subscription?.cancel();
      _subscription = iap.purchaseStream.listen(
        (purchaseDetailsList) {
          _handlePurchaseUpdates(
            purchaseDetailsList,
            onPurchaseVerified: onPurchaseVerified,
            onError: onError,
          );
        },
        onDone: () => _subscription?.cancel(),
        onError: (Object error) {
          onError(error.toString());
        },
      );

      // Query products from Google Play / Apple App Store
      final response = await iap.queryProductDetails(SubscriptionPlan.allProductIds);
      if (response.error != null) {
        debugPrint('[IAP] Error querying products: ${response.error!.message}');
        return const {};
      }

      _products = response.productDetails;
      final localizedMap = <String, String>{};
      for (final product in _products) {
        localizedMap[product.id] = product.price;
      }
      return localizedMap;
    } catch (e) {
      debugPrint('[IAP] Initialization exception: $e');
      _isAvailable = false;
      return const {};
    }
  }

  /// Triggers native Google Play / Apple StoreKit checkout sheet for the requested plan.
  Future<bool> buyPlan(SubscriptionPlan plan) async {
    final iap = _iap;
    if (iap == null || !_isAvailable) {
      debugPrint('[IAP] Native store unavailable. Resorting to server verification.');
      return false;
    }

    final product = _products.cast<ProductDetails?>().firstWhere(
          (p) => p?.id == plan.id,
          orElse: () => null,
        );

    if (product == null) {
      debugPrint('[IAP] Product ${plan.id} not found in store catalog.');
      return false;
    }

    final purchaseParam = PurchaseParam(productDetails: product);
    return iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// Restores previous purchases across devices.
  Future<void> restorePurchases() async {
    final iap = _iap;
    if (iap == null || !_isAvailable) return;
    try {
      await iap.restorePurchases();
    } catch (e) {
      debugPrint('[IAP] restorePurchases exception: $e');
    }
  }

  /// Completes and acknowledges a purchase once server verification succeeds.
  Future<void> completePurchase(PurchaseDetails purchase) async {
    final iap = _iap;
    if (iap != null && purchase.pendingCompletePurchase) {
      try {
        await iap.completePurchase(purchase);
      } catch (e) {
        debugPrint('[IAP] completePurchase exception: $e');
      }
    }
  }

  Future<void> _handlePurchaseUpdates(
    List<PurchaseDetails> purchaseDetailsList, {
    required OnPurchaseVerified onPurchaseVerified,
    required void Function(String error) onError,
  }) async {
    for (final purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        debugPrint('[IAP] Purchase pending for ${purchaseDetails.productID}');
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        onError(purchaseDetails.error?.message ?? 'Purchase was declined or failed.');
        await completePurchase(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.canceled) {
        debugPrint('[IAP] Purchase cancelled by user.');
        await completePurchase(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        final plan = SubscriptionPlan.fromId(purchaseDetails.productID);
        final verified = await onPurchaseVerified(purchaseDetails, plan);
        if (verified) {
          await completePurchase(purchaseDetails);
        }
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
