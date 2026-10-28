import 'package:flutter/foundation.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_2_wrappers.dart';

import '../domain/subscription_offer.dart';
import '../domain/subscription_plan.dart';

/// Reads Play Billing and StoreKit product details into pure [StoreOffer]s.
///
/// Play only returns offers the signed-in user is eligible for, so a missing
/// free-trial offer means "no trial" rather than a hardcoded fallback. Offer
/// tags are not consulted. On iOS, StoreKit 2 includes introductory offers even
/// when the user is ineligible, so those are included only when
/// [iosIntroEligible] is true.
List<StoreOffer> offersFromProductDetails(
  ProductDetails product, {
  bool iosIntroEligible = false,
}) {
  if (product is GooglePlayProductDetails) {
    return _offersFromGooglePlay(product);
  }
  if (product is AppStoreProduct2Details) {
    return _offersFromStoreKit2(product, introEligible: iosIntroEligible);
  }
  return _genericOffer(product);
}

/// Groups store products by id and describes each Oracle Pro plan.
///
/// Android returns one [ProductDetails] per offer, but each subscription
/// wrapper already contains every eligible offer. The first details object for
/// an id is enough to read that full list.
PaywallCatalogSnapshot catalogFromStoreProducts(
  List<ProductDetails> products, {
  required bool storeAvailable,
  Map<String, bool> iosIntroEligible = const {},
}) {
  if (!storeAvailable) return PaywallCatalogSnapshot.empty;

  final firstById = <String, ProductDetails>{};
  for (final product in products) {
    firstById.putIfAbsent(product.id, () => product);
  }

  final quotes = <String, PaywallQuote>{};
  for (final plan in SubscriptionPlan.values) {
    final product = firstById[plan.id];
    final offers = product == null
        ? const <StoreOffer>[]
        : offersFromProductDetails(
            product,
            iosIntroEligible: iosIntroEligible[plan.id] ?? false,
          );
    quotes[plan.id] = describePlan(
      plan: plan,
      offers: offers,
      storeAvailable: true,
      isLoading: false,
    );
  }
  return snapshotFromQuotes(quotes);
}

/// Picks the [ProductDetails] row whose Play offer token matches [offerToken].
///
/// A null token selects the base plan (offer id null) when Play expanded the
/// subscription into several rows. Returns null when a requested token is not
/// in the catalog, so the app does not purchase a different offer by mistake.
ProductDetails? selectStoreProduct({
  required List<ProductDetails> products,
  required String productId,
  String? offerToken,
}) {
  final matches = products.where((product) => product.id == productId).toList();
  if (matches.isEmpty) return null;

  if (offerToken != null && offerToken.isNotEmpty) {
    for (final product in matches) {
      if (product is GooglePlayProductDetails && product.offerToken == offerToken) {
        return product;
      }
    }
    return null;
  }

  for (final product in matches) {
    if (product is! GooglePlayProductDetails) continue;
    final index = product.subscriptionIndex;
    final offers = product.productDetails.subscriptionOfferDetails;
    if (index != null &&
        offers != null &&
        index < offers.length &&
        offers[index].offerId == null) {
      return product;
    }
  }
  return matches.first;
}

/// Purchase params for the selected store row.
///
/// Subscriptions on Google Play must carry the offer token of the base plan or
/// the free-trial offer. One-time products and StoreKit purchases omit it.
PurchaseParam purchaseParamFor(ProductDetails product) {
  if (product is GooglePlayProductDetails && product.offerToken != null) {
    return GooglePlayPurchaseParam(
      productDetails: product,
      offerToken: product.offerToken,
    );
  }
  return PurchaseParam(productDetails: product);
}

/// StoreKit 2 introductory free trials the current user is allowed to redeem.
///
/// Returns an empty map on Android and anywhere the eligibility call fails.
/// Failure hides the trial instead of advertising one the user cannot redeem.
Future<Map<String, bool>> loadIosIntroEligibility(Iterable<ProductDetails> products) async {
  final candidates = <String>{};
  for (final product in products) {
    if (product is! AppStoreProduct2Details) continue;
    if (_freeIntroOffer(product.sk2Product.subscription) == null) continue;
    candidates.add(product.id);
  }
  if (candidates.isEmpty) return const {};

  try {
    final platform = InAppPurchasePlatform.instance;
    if (platform is! InAppPurchaseStoreKitPlatform) return const {};
    final eligibility = <String, bool>{};
    for (final productId in candidates) {
      try {
        eligibility[productId] = await platform.isIntroductoryOfferEligible(productId);
      } catch (error) {
        debugPrint('[IAP] Introductory offer eligibility failed for $productId: $error');
        eligibility[productId] = false;
      }
    }
    return eligibility;
  } catch (error) {
    debugPrint('[IAP] Introductory offer eligibility unavailable: $error');
    return const {};
  }
}

List<StoreOffer> _offersFromGooglePlay(GooglePlayProductDetails product) {
  final subscriptionOffers = product.productDetails.subscriptionOfferDetails;
  if (subscriptionOffers != null && subscriptionOffers.isNotEmpty) {
    return [
      for (final offer in subscriptionOffers)
        StoreOffer(
          offerId: offer.offerId,
          offerToken: offer.offerIdToken,
          tags: offer.offerTags,
          phases: [
            for (final phase in offer.pricingPhases)
              StorePhase(
                billingPeriod: phase.billingPeriod,
                priceAmountMicros: phase.priceAmountMicros,
                formattedPrice: phase.formattedPrice,
                currencyCode: phase.priceCurrencyCode,
                billingCycleCount: phase.billingCycleCount,
                recurrence: _recurrence(phase.recurrenceMode),
              ),
          ],
        ),
    ];
  }

  final oneTime = product.productDetails.oneTimePurchaseOfferDetails;
  if (oneTime != null) {
    return [
      StoreOffer(
        phases: [
          StorePhase(
            billingPeriod: '',
            priceAmountMicros: oneTime.priceAmountMicros,
            formattedPrice: oneTime.formattedPrice,
            currencyCode: oneTime.priceCurrencyCode,
            billingCycleCount: 1,
            recurrence: PhaseRecurrence.nonRecurring,
          ),
        ],
      ),
    ];
  }

  return _genericOffer(product);
}

List<StoreOffer> _offersFromStoreKit2(
  AppStoreProduct2Details product, {
  required bool introEligible,
}) {
  final subscription = product.sk2Product.subscription;
  final recurring = StorePhase(
    billingPeriod: subscription == null
        ? ''
        : _isoFromStoreKitPeriod(subscription.subscriptionPeriod, 1),
    priceAmountMicros: (product.rawPrice * 1000000).round(),
    formattedPrice: product.price,
    currencyCode: product.currencyCode,
    billingCycleCount: subscription == null ? 1 : 0,
    recurrence: subscription == null ? PhaseRecurrence.nonRecurring : PhaseRecurrence.infinite,
  );

  final intro = introEligible ? _freeIntroOffer(subscription) : null;
  if (intro == null) {
    return [StoreOffer(phases: [recurring])];
  }

  return [
    StoreOffer(
      offerId: intro.id ?? 'introductory',
      phases: [
        StorePhase(
          billingPeriod: _isoFromStoreKitPeriod(intro.period, intro.periodCount),
          priceAmountMicros: 0,
          formattedPrice: 'Free',
          currencyCode: product.currencyCode,
          billingCycleCount: intro.periodCount,
          recurrence: PhaseRecurrence.finite,
        ),
        recurring,
      ],
    ),
    StoreOffer(phases: [recurring]),
  ];
}

SK2SubscriptionOffer? _freeIntroOffer(SK2SubscriptionInfo? subscription) {
  if (subscription == null) return null;
  for (final offer in subscription.promotionalOffers) {
    final isFreeIntro = offer.type == SK2SubscriptionOfferType.introductory &&
        offer.paymentMode == SK2SubscriptionOfferPaymentMode.freeTrial &&
        offer.price == 0;
    if (isFreeIntro) return offer;
  }
  return null;
}

String _isoFromStoreKitPeriod(SK2SubscriptionPeriod period, int periodCount) {
  final cycles = periodCount <= 0 ? 1 : periodCount;
  final count = period.value * cycles;
  final unit = switch (period.unit) {
    SK2SubscriptionPeriodUnit.day => 'D',
    SK2SubscriptionPeriodUnit.week => 'W',
    SK2SubscriptionPeriodUnit.month => 'M',
    SK2SubscriptionPeriodUnit.year => 'Y',
  };
  return 'P$count$unit';
}

PhaseRecurrence _recurrence(RecurrenceMode mode) {
  return switch (mode) {
    RecurrenceMode.finiteRecurring => PhaseRecurrence.finite,
    RecurrenceMode.infiniteRecurring => PhaseRecurrence.infinite,
    RecurrenceMode.nonRecurring => PhaseRecurrence.nonRecurring,
  };
}

List<StoreOffer> _genericOffer(ProductDetails product) {
  return [
    StoreOffer(
      phases: [
        StorePhase(
          billingPeriod: '',
          priceAmountMicros: (product.rawPrice * 1000000).round(),
          formattedPrice: product.price,
          currencyCode: product.currencyCode,
          billingCycleCount: 1,
          recurrence: PhaseRecurrence.nonRecurring,
        ),
      ],
    ),
  ];
}
