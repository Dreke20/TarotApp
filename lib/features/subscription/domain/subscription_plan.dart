/// Definitive subscription plans for Oracle Pro.
enum SubscriptionPlan {
  yearly(
    id: 'oracle_pro_yearly',
    title: 'ANNUAL PLAN',
    defaultPrice: '\$49.99 / yr',
    savings: 'SAVE 58%',
    billingPeriod: 'per year',
  ),
  monthly(
    id: 'oracle_pro_monthly',
    title: 'MONTHLY',
    defaultPrice: '\$9.99 / mo',
    savings: null,
    billingPeriod: 'per month',
  ),
  lifetime(
    id: 'oracle_pro_lifetime',
    title: 'LIFETIME ACCESS',
    defaultPrice: '\$99.99',
    savings: 'ONE-TIME',
    billingPeriod: 'lifetime',
  );

  final String id;
  final String title;
  final String defaultPrice;
  final String? savings;
  final String billingPeriod;

  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.defaultPrice,
    this.savings,
    required this.billingPeriod,
  });

  static const Set<String> allProductIds = {
    'oracle_pro_yearly',
    'oracle_pro_monthly',
    'oracle_pro_lifetime',
  };

  static SubscriptionPlan fromId(String id) {
    return SubscriptionPlan.values.firstWhere(
      (p) => p.id == id,
      orElse: () => SubscriptionPlan.yearly,
    );
  }
}
