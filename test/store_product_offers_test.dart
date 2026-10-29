import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_2_wrappers.dart';
import 'package:tarot_app/features/subscription/data/store_product_offers.dart';
import 'package:tarot_app/features/subscription/domain/subscription_plan.dart';

void main() {
  test('Play trial offer is purchased and priced from the recurring phase', () {
    final products = [
      ...GooglePlayProductDetails.fromProductDetails(
        _subscription(
          productId: SubscriptionPlan.monthly.id,
          offers: [
            _offer(
              basePlanId: 'monthly',
              offerId: 'trial-3d',
              token: 'monthly-trial',
              phases: [
                _phase(
                  period: 'P3D',
                  micros: 0,
                  price: 'Free',
                  mode: RecurrenceMode.finiteRecurring,
                  cycles: 1,
                ),
                _phase(
                  period: 'P1M',
                  micros: 9990000,
                  price: r'$9.99',
                  mode: RecurrenceMode.infiniteRecurring,
                ),
              ],
            ),
            _offer(
              basePlanId: 'monthly',
              token: 'monthly-base',
              phases: [
                _phase(
                  period: 'P1M',
                  micros: 9990000,
                  price: r'$9.99',
                  mode: RecurrenceMode.infiniteRecurring,
                ),
              ],
            ),
          ],
        ),
      ),
      ...GooglePlayProductDetails.fromProductDetails(
        _subscription(
          productId: SubscriptionPlan.yearly.id,
          offers: [
            _offer(
              basePlanId: 'yearly',
              offerId: 'trial-3d',
              token: 'yearly-trial',
              phases: [
                _phase(
                  period: 'P3D',
                  micros: 0,
                  price: 'Free',
                  mode: RecurrenceMode.finiteRecurring,
                  cycles: 1,
                ),
                _phase(
                  period: 'P1Y',
                  micros: 49990000,
                  price: r'$49.99',
                  mode: RecurrenceMode.infiniteRecurring,
                ),
              ],
            ),
            _offer(
              basePlanId: 'yearly',
              token: 'yearly-base',
              phases: [
                _phase(
                  period: 'P1Y',
                  micros: 49990000,
                  price: r'$49.99',
                  mode: RecurrenceMode.infiniteRecurring,
                ),
              ],
            ),
          ],
        ),
      ),
      ...GooglePlayProductDetails.fromProductDetails(_lifetime()),
    ];

    expect(products.first.price, 'Free');

    final catalog = catalogFromStoreProducts(products, storeAvailable: true);
    expect(catalog.priceLabels[SubscriptionPlan.monthly.id], r'3-day free trial, then $9.99/mo');
    expect(catalog.priceLabels[SubscriptionPlan.yearly.id], r'3-day free trial, then $49.99/yr');
    expect(catalog.priceLabels[SubscriptionPlan.lifetime.id], r'$99.99');
    expect(catalog.trialPhrases[SubscriptionPlan.lifetime.id], isNull);
    expect(catalog.offerTokens[SubscriptionPlan.monthly.id], 'monthly-trial');
    expect(catalog.offerTokens[SubscriptionPlan.yearly.id], 'yearly-trial');
    expect(catalog.offerTokens.containsKey(SubscriptionPlan.lifetime.id), isFalse);
    expect(catalog.recurringMicros[SubscriptionPlan.monthly.id], 9990000);
    expect(catalog.recurringMicros[SubscriptionPlan.yearly.id], 49990000);

    final trial = selectStoreProduct(
      products: products,
      productId: SubscriptionPlan.monthly.id,
      offerToken: 'monthly-trial',
    );
    expect(trial, isA<GooglePlayProductDetails>());
    final trialParam = purchaseParamFor(trial!);
    expect(trialParam, isA<GooglePlayPurchaseParam>());
    expect((trialParam as GooglePlayPurchaseParam).offerToken, 'monthly-trial');

    final base = selectStoreProduct(
      products: products,
      productId: SubscriptionPlan.yearly.id,
      offerToken: null,
    );
    expect((base as GooglePlayProductDetails).offerToken, 'yearly-base');

    expect(
      selectStoreProduct(
        products: products,
        productId: SubscriptionPlan.monthly.id,
        offerToken: 'missing-token',
      ),
      isNull,
    );

    final lifetime = selectStoreProduct(
      products: products,
      productId: SubscriptionPlan.lifetime.id,
      offerToken: null,
    );
    expect(purchaseParamFor(lifetime!), isNot(isA<GooglePlayPurchaseParam>()));
  });

  test('Play omits ineligible offers and the paywall drops trial wording', () {
    final products = GooglePlayProductDetails.fromProductDetails(
      _subscription(
        productId: SubscriptionPlan.monthly.id,
        offers: [
          _offer(
            basePlanId: 'monthly',
            token: 'monthly-base',
            phases: [
              _phase(
                period: 'P1M',
                micros: 9990000,
                price: r'$9.99',
                mode: RecurrenceMode.infiniteRecurring,
              ),
            ],
          ),
        ],
      ),
    );

    final catalog = catalogFromStoreProducts(products, storeAvailable: true);
    expect(catalog.priceLabels[SubscriptionPlan.monthly.id], r'$9.99/mo');
    expect(catalog.trialPhrases.containsKey(SubscriptionPlan.monthly.id), isFalse);
    expect(catalog.offerTokens[SubscriptionPlan.monthly.id], 'monthly-base');
  });

  test('StoreKit introductory free trial is shown only when eligible', () {
    final product = _iosMonthly(periodCount: 3);

    final eligible = catalogFromStoreProducts(
      [product],
      storeAvailable: true,
      iosIntroEligible: {SubscriptionPlan.monthly.id: true},
    );
    expect(
      eligible.priceLabels[SubscriptionPlan.monthly.id],
      r'3-day free trial, then $9.99/mo',
    );
    expect(eligible.offerTokens.containsKey(SubscriptionPlan.monthly.id), isFalse);

    final ineligible = catalogFromStoreProducts(
      [product],
      storeAvailable: true,
      iosIntroEligible: {SubscriptionPlan.monthly.id: false},
    );
    expect(ineligible.priceLabels[SubscriptionPlan.monthly.id], r'$9.99/mo');
    expect(ineligible.trialPhrases.containsKey(SubscriptionPlan.monthly.id), isFalse);
  });

  test('StoreKit paid intro offers are not described as a free trial', () {
    final product = _iosMonthly(periodCount: 1, introPrice: 4.99);
    final catalog = catalogFromStoreProducts(
      [product],
      storeAvailable: true,
      iosIntroEligible: {SubscriptionPlan.monthly.id: true},
    );
    expect(catalog.priceLabels[SubscriptionPlan.monthly.id], r'$9.99/mo');
    expect(catalog.trialPhrases.containsKey(SubscriptionPlan.monthly.id), isFalse);
  });

  test('a one-week StoreKit intro uses the offer period', () {
    final product = _iosMonthly(
      periodCount: 1,
      unit: SK2SubscriptionPeriodUnit.week,
      periodValue: 1,
    );
    final catalog = catalogFromStoreProducts(
      [product],
      storeAvailable: true,
      iosIntroEligible: {SubscriptionPlan.monthly.id: true},
    );
    expect(
      catalog.priceLabels[SubscriptionPlan.monthly.id],
      r'1-week free trial, then $9.99/mo',
    );
  });
}

ProductDetailsWrapper _subscription({
  required String productId,
  required List<SubscriptionOfferDetailsWrapper> offers,
}) {
  return ProductDetailsWrapper(
    description: productId,
    name: productId,
    productId: productId,
    productType: ProductType.subs,
    title: productId,
    subscriptionOfferDetails: offers,
  );
}

ProductDetailsWrapper _lifetime() {
  return ProductDetailsWrapper(
    description: 'Lifetime',
    name: 'Lifetime',
    productId: SubscriptionPlan.lifetime.id,
    productType: ProductType.inapp,
    title: 'Lifetime',
    oneTimePurchaseOfferDetails: const OneTimePurchaseOfferDetailsWrapper(
      formattedPrice: r'$99.99',
      priceAmountMicros: 99990000,
      priceCurrencyCode: 'USD',
    ),
  );
}

SubscriptionOfferDetailsWrapper _offer({
  required String basePlanId,
  String? offerId,
  required String token,
  required List<PricingPhaseWrapper> phases,
}) {
  return SubscriptionOfferDetailsWrapper(
    basePlanId: basePlanId,
    offerId: offerId,
    offerTags: const ['ignored-tag'],
    offerIdToken: token,
    pricingPhases: phases,
  );
}

PricingPhaseWrapper _phase({
  required String period,
  required int micros,
  required String price,
  required RecurrenceMode mode,
  int cycles = 0,
}) {
  return PricingPhaseWrapper(
    billingCycleCount: cycles,
    billingPeriod: period,
    formattedPrice: price,
    priceAmountMicros: micros,
    priceCurrencyCode: 'USD',
    recurrenceMode: mode,
  );
}

AppStoreProduct2Details _iosMonthly({
  required int periodCount,
  double introPrice = 0,
  SK2SubscriptionPeriodUnit unit = SK2SubscriptionPeriodUnit.day,
  int periodValue = 1,
}) {
  return AppStoreProduct2Details(
    id: SubscriptionPlan.monthly.id,
    title: 'Monthly',
    description: 'Oracle Pro',
    price: r'$9.99',
    rawPrice: 9.99,
    currencyCode: 'USD',
    currencySymbol: r'$',
    sk2Product: SK2Product(
      id: SubscriptionPlan.monthly.id,
      displayName: 'Monthly',
      displayPrice: r'$9.99',
      description: 'Oracle Pro',
      price: 9.99,
      type: SK2ProductType.autoRenewable,
      priceLocale: SK2PriceLocale(currencyCode: 'USD', currencySymbol: r'$'),
      subscription: SK2SubscriptionInfo(
        subscriptionGroupID: 'oracle_pro',
        promotionalOffers: [
          SK2SubscriptionOffer(
            price: introPrice,
            type: SK2SubscriptionOfferType.introductory,
            period: SK2SubscriptionPeriod(value: periodValue, unit: unit),
            periodCount: periodCount,
            paymentMode: introPrice == 0
                ? SK2SubscriptionOfferPaymentMode.freeTrial
                : SK2SubscriptionOfferPaymentMode.payAsYouGo,
          ),
        ],
        subscriptionPeriod: const SK2SubscriptionPeriod(
          value: 1,
          unit: SK2SubscriptionPeriodUnit.month,
        ),
      ),
    ),
  );
}
