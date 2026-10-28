import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/subscription/domain/subscription_offer.dart';
import 'package:tarot_app/features/subscription/domain/subscription_plan.dart';

void main() {
  group('formatBillingPeriod', () {
    test('parses P3D and P1W into trial lengths', () {
      expect(formatBillingPeriod('P3D'), '3-day');
      expect(formatBillingPeriod('P1W'), '1-week');
      expect(formatBillingPeriod(' p14d '), '14-day');
      expect(formatBillingPeriod('P2M'), '2-month');
      expect(formatBillingPeriod('P1Y'), '1-year');
    });

    test('rejects empty, zero, and compound periods', () {
      expect(formatBillingPeriod(''), isNull);
      expect(formatBillingPeriod('P0D'), isNull);
      expect(formatBillingPeriod('P1M3D'), isNull);
      expect(formatBillingPeriod('3 days'), isNull);
    });
  });

  group('yearly savings', () {
    test('approved prices save 58 percent rounded down', () {
      expect(
        yearlySavingsPercent(
          yearlyMicros: 49990000,
          monthlyMicros: 9990000,
          yearlyCurrency: 'USD',
          monthlyCurrency: 'usd',
        ),
        58,
      );
      expect(
        yearlySavingsLabel(
          yearlyMicros: 49990000,
          monthlyMicros: 9990000,
          yearlyCurrency: 'USD',
          monthlyCurrency: 'USD',
        ),
        'Save 58%',
      );
    });

    test('rounds down instead of to the nearest percent', () {
      // 12 * $10.00 = $120.00. Yearly $49.32 is 58.9% off, which rounds to 59.
      expect(
        yearlySavingsPercent(
          yearlyMicros: 49320000,
          monthlyMicros: 10000000,
          yearlyCurrency: 'USD',
          monthlyCurrency: 'USD',
        ),
        58,
      );
    });

    test('hides the label when a price or currency is missing or mismatched', () {
      expect(
        yearlySavingsLabel(
          yearlyMicros: null,
          monthlyMicros: 9990000,
          yearlyCurrency: 'USD',
          monthlyCurrency: 'USD',
        ),
        isNull,
      );
      expect(
        yearlySavingsLabel(
          yearlyMicros: 49990000,
          monthlyMicros: 9990000,
          yearlyCurrency: 'USD',
          monthlyCurrency: 'EUR',
        ),
        isNull,
      );
      expect(
        yearlySavingsLabel(
          yearlyMicros: 49990000,
          monthlyMicros: 9990000,
          yearlyCurrency: '',
          monthlyCurrency: 'USD',
        ),
        isNull,
      );
      expect(
        yearlySavingsPercent(
          yearlyMicros: 120000000,
          monthlyMicros: 9990000,
          yearlyCurrency: 'USD',
          monthlyCurrency: 'USD',
        ),
        isNull,
      );
    });
  });

  group('describePlan', () {
    const recurringMonthly = StorePhase(
      billingPeriod: 'P1M',
      priceAmountMicros: 9990000,
      formattedPrice: r'$9.99',
      currencyCode: 'USD',
      billingCycleCount: 0,
      recurrence: PhaseRecurrence.infinite,
    );
    const recurringYearly = StorePhase(
      billingPeriod: 'P1Y',
      priceAmountMicros: 49990000,
      formattedPrice: r'$49.99',
      currencyCode: 'USD',
      billingCycleCount: 0,
      recurrence: PhaseRecurrence.infinite,
    );

    StoreOffer trialOffer({
      required String period,
      required String token,
      required StorePhase recurring,
    }) {
      return StoreOffer(
        offerId: 'free-trial',
        offerToken: token,
        phases: [
          StorePhase(
            billingPeriod: period,
            priceAmountMicros: 0,
            formattedPrice: 'Free',
            currencyCode: 'USD',
            billingCycleCount: 1,
            recurrence: PhaseRecurrence.finite,
          ),
          recurring,
        ],
      );
    }

    StoreOffer baseOffer({required String token, required StorePhase recurring}) {
      return StoreOffer(offerToken: token, phases: [recurring]);
    }

    test('monthly and yearly trials use the free phase and recurring price', () {
      final monthly = describePlan(
        plan: SubscriptionPlan.monthly,
        offers: [
          baseOffer(token: 'monthly-base', recurring: recurringMonthly),
          trialOffer(period: 'P3D', token: 'monthly-trial', recurring: recurringMonthly),
        ],
        storeAvailable: true,
        isLoading: false,
      );
      expect(monthly.priceLabel, r'3-day free trial, then $9.99/mo');
      expect(monthly.trialPhrase, '3-day free trial');
      expect(monthly.offerToken, 'monthly-trial');
      expect(monthly.recurringMicros, 9990000);

      final yearly = describePlan(
        plan: SubscriptionPlan.yearly,
        offers: [
          trialOffer(period: 'P1W', token: 'yearly-trial', recurring: recurringYearly),
        ],
        storeAvailable: true,
        isLoading: false,
      );
      expect(yearly.priceLabel, r'1-week free trial, then $49.99/yr');
      expect(yearly.trialPhrase, '1-week free trial');
      expect(yearly.offerToken, 'yearly-trial');
    });

    test('ineligible users with only a base plan get the plain price', () {
      final monthly = describePlan(
        plan: SubscriptionPlan.monthly,
        offers: [baseOffer(token: 'monthly-base', recurring: recurringMonthly)],
        storeAvailable: true,
        isLoading: false,
      );
      expect(monthly.priceLabel, r'$9.99/mo');
      expect(monthly.trialPhrase, isNull);
      expect(monthly.offerToken, 'monthly-base');
      expect(monthly.priceLabel.contains('trial'), isFalse);
    });

    test('lifetime never shows trial wording', () {
      final lifetime = describePlan(
        plan: SubscriptionPlan.lifetime,
        offers: [
          const StoreOffer(
            offerId: 'not-a-trial',
            offerToken: 'should-not-be-used',
            phases: [
              StorePhase(
                billingPeriod: 'P3D',
                priceAmountMicros: 0,
                formattedPrice: 'Free',
                currencyCode: 'USD',
                billingCycleCount: 1,
                recurrence: PhaseRecurrence.finite,
              ),
              StorePhase(
                billingPeriod: '',
                priceAmountMicros: 99990000,
                formattedPrice: r'$99.99',
                currencyCode: 'USD',
                billingCycleCount: 1,
                recurrence: PhaseRecurrence.nonRecurring,
              ),
            ],
          ),
        ],
        storeAvailable: true,
        isLoading: false,
      );
      expect(lifetime.priceLabel, r'$99.99');
      expect(lifetime.trialPhrase, isNull);
      expect(lifetime.offerToken, isNull);
      expect(lifetime.priceLabel.toLowerCase().contains('trial'), isFalse);
    });

    test('loading and unavailable quotes are not purchasable prices', () {
      final loading = describePlan(
        plan: SubscriptionPlan.yearly,
        offers: [baseOffer(token: 'yearly-base', recurring: recurringYearly)],
        storeAvailable: true,
        isLoading: true,
      );
      expect(loading.priceLabel, PaywallQuote.loadingPrice);
      expect(loading.priceLabel.contains(r'$'), isFalse);
      expect(loading.purchasable, isFalse);

      final unavailable = describePlan(
        plan: SubscriptionPlan.monthly,
        offers: const [],
        storeAvailable: false,
        isLoading: false,
      );
      expect(unavailable.priceLabel, PaywallQuote.unavailablePrice);
      expect(unavailable.purchasable, isFalse);
    });
  });

  test('approved catalog fallback prices stay on the plan model', () {
    expect(SubscriptionPlan.monthly.defaultPrice, r'$9.99 / mo');
    expect(SubscriptionPlan.yearly.defaultPrice, r'$49.99 / yr');
    expect(SubscriptionPlan.lifetime.defaultPrice, r'$99.99');
  });
}
