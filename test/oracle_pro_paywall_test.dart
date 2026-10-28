import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:tarot_app/features/subscription/data/store_product_offers.dart';
import 'package:tarot_app/features/subscription/domain/subscription_offer.dart';
import 'package:tarot_app/features/subscription/domain/subscription_plan.dart';
import 'package:tarot_app/features/subscription/presentation/oracle_pro_modal.dart';
import 'package:tarot_app/features/subscription/presentation/subscription_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('paywall shows Play trial copy, savings, and lifetime price', (tester) async {
    final state = _stateFor(_playCatalog(includeTrials: true));
    await _pumpPaywall(tester, state);

    expect(find.text(r'3-day free trial, then $9.99/mo'), findsOneWidget);
    expect(find.text(r'3-day free trial, then $49.99/yr'), findsOneWidget);
    expect(find.text(r'$99.99'), findsOneWidget);
    expect(find.text('Save 58%'), findsOneWidget);
    expect(find.text('3-DAY FREE TRIAL'), findsWidgets);
    expect(find.text('✦ START 3-DAY FREE TRIAL ✦'), findsOneWidget);
    expect(find.textContaining('free trial, then \$99.99'), findsNothing);
    expect(find.textContaining(r'$4.17'), findsNothing);
    expect(find.text('SAVE 58%'), findsNothing);

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, '✦ START 3-DAY FREE TRIAL ✦'),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets('ineligible Play catalog has base prices and no trial wording', (tester) async {
    final state = _stateFor(_playCatalog(includeTrials: false));
    await _pumpPaywall(tester, state);

    expect(find.text(r'$9.99/mo'), findsOneWidget);
    expect(find.text(r'$49.99/yr'), findsOneWidget);
    expect(find.text(r'$99.99'), findsOneWidget);
    expect(find.text('Save 58%'), findsOneWidget);
    expect(find.textContaining('free trial'), findsNothing);
    expect(find.text('✦ SUBSCRIBE TO ORACLE PRO ✦'), findsOneWidget);
  });

  testWidgets('savings label is hidden when live currencies differ', (tester) async {
    final state = _stateFor(_playCatalog(includeTrials: false, monthlyCurrency: 'EUR'));
    await _pumpPaywall(tester, state);

    expect(find.text('Save 58%'), findsNothing);
    expect(find.textContaining('Save '), findsNothing);
    expect(state.yearlySavingsLabel, isNull);
  });

  testWidgets('loading and store-unavailable paywalls do not show prices', (tester) async {
    await _pumpPaywall(
      tester,
      const SubscriptionState(
        isLoading: true,
        isAvailable: true,
        localizedPrices: {'oracle_pro_yearly': r'$49.99/yr'},
      ),
    );
    expect(find.textContaining(r'$'), findsNothing);
    expect(find.textContaining('free trial'), findsNothing);
    expect(find.text('Save 58%'), findsNothing);
    expect(find.text(PaywallQuote.loadingPrice), findsWidgets);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);

    await _pumpPaywall(tester, const SubscriptionState());
    expect(find.textContaining(r'$'), findsNothing);
    expect(find.textContaining('9.99'), findsNothing);
    expect(find.textContaining('49.99'), findsNothing);
    expect(find.textContaining('99.99'), findsNothing);
    expect(find.text(PaywallQuote.unavailablePrice), findsWidgets);
    expect(find.text('✦ STORE UNAVAILABLE ✦'), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
  });
}

SubscriptionState _stateFor(List<GooglePlayProductDetails> products) {
  final catalog = catalogFromStoreProducts(products, storeAvailable: true);
  return const SubscriptionState(isAvailable: true).withLiveCatalog(catalog);
}

Future<void> _pumpPaywall(WidgetTester tester, SubscriptionState state) async {
  tester.view.physicalSize = const Size(420, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        subscriptionProvider.overrideWith(() => _FixedSubscriptionNotifier(state)),
      ],
      child: const MaterialApp(home: Scaffold(body: OracleProModal())),
    ),
  );
  await tester.pump();
}

class _FixedSubscriptionNotifier extends SubscriptionNotifier {
  _FixedSubscriptionNotifier(this.seed);

  final SubscriptionState seed;

  @override
  SubscriptionState build() => seed;
}

List<GooglePlayProductDetails> _playCatalog({
  required bool includeTrials,
  String monthlyCurrency = 'USD',
}) {
  return [
    ...GooglePlayProductDetails.fromProductDetails(
      _plan(
        productId: SubscriptionPlan.monthly.id,
        basePlanId: 'monthly',
        period: 'P1M',
        micros: 9990000,
        price: r'$9.99',
        currency: monthlyCurrency,
        includeTrial: includeTrials,
      ),
    ),
    ...GooglePlayProductDetails.fromProductDetails(
      _plan(
        productId: SubscriptionPlan.yearly.id,
        basePlanId: 'yearly',
        period: 'P1Y',
        micros: 49990000,
        price: r'$49.99',
        currency: 'USD',
        includeTrial: includeTrials,
      ),
    ),
    ...GooglePlayProductDetails.fromProductDetails(
      ProductDetailsWrapper(
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
      ),
    ),
  ];
}

ProductDetailsWrapper _plan({
  required String productId,
  required String basePlanId,
  required String period,
  required int micros,
  required String price,
  required String currency,
  required bool includeTrial,
}) {
  final recurring = PricingPhaseWrapper(
    billingCycleCount: 0,
    billingPeriod: period,
    formattedPrice: price,
    priceAmountMicros: micros,
    priceCurrencyCode: currency,
    recurrenceMode: RecurrenceMode.infiniteRecurring,
  );
  return ProductDetailsWrapper(
    description: productId,
    name: productId,
    productId: productId,
    productType: ProductType.subs,
    title: productId,
    subscriptionOfferDetails: [
      if (includeTrial)
        SubscriptionOfferDetailsWrapper(
          basePlanId: basePlanId,
          offerId: 'trial',
          offerTags: const [],
          offerIdToken: '$basePlanId-trial',
          pricingPhases: [
            PricingPhaseWrapper(
              billingCycleCount: 1,
              billingPeriod: 'P3D',
              formattedPrice: 'Free',
              priceAmountMicros: 0,
              priceCurrencyCode: currency,
              recurrenceMode: RecurrenceMode.finiteRecurring,
            ),
            recurring,
          ],
        ),
      SubscriptionOfferDetailsWrapper(
        basePlanId: basePlanId,
        offerTags: const [],
        offerIdToken: '$basePlanId-base',
        pricingPhases: [recurring],
      ),
    ],
  );
}
