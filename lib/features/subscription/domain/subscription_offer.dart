import 'subscription_plan.dart';

/// How a store pricing phase repeats.
enum PhaseRecurrence { finite, infinite, nonRecurring }

/// One pricing phase from a store offer, independent of the billing plugin.
class StorePhase {
  const StorePhase({
    required this.billingPeriod,
    required this.priceAmountMicros,
    required this.formattedPrice,
    required this.currencyCode,
    required this.billingCycleCount,
    required this.recurrence,
  });

  /// ISO-8601 period such as `P3D` or `P1W`. Empty for a one-time price.
  final String billingPeriod;
  final int priceAmountMicros;
  final String formattedPrice;
  final String currencyCode;
  final int billingCycleCount;
  final PhaseRecurrence recurrence;

  bool get isFree => priceAmountMicros == 0;
}

/// A subscription offer or one-time price the store says this user can buy.
class StoreOffer {
  const StoreOffer({
    this.offerId,
    this.offerToken,
    this.tags = const [],
    required this.phases,
  });

  /// Null for the Play base plan itself. Set for a discounted offer.
  final String? offerId;

  /// Play Billing offer token. Null on iOS and for one-time products.
  final String? offerToken;

  /// Present for completeness. Selection does not depend on tags.
  final List<String> tags;
  final List<StorePhase> phases;
}

/// Copy and purchase target for one plan on the paywall.
class PaywallQuote {
  const PaywallQuote({
    required this.priceLabel,
    this.trialPhrase,
    this.offerToken,
    this.recurringMicros,
    this.currencyCode,
    required this.purchasable,
  });

  static const loadingPrice = 'Loading…';
  static const unavailablePrice = 'Unavailable';

  static const loading = PaywallQuote(
    priceLabel: loadingPrice,
    purchasable: false,
  );

  static const unavailable = PaywallQuote(
    priceLabel: unavailablePrice,
    purchasable: false,
  );

  /// Line shown on the plan card. Never a hardcoded catalog amount.
  final String priceLabel;

  /// For example `3-day free trial`. Null when this user has no free trial.
  final String? trialPhrase;
  final String? offerToken;
  final int? recurringMicros;
  final String? currencyCode;
  final bool purchasable;
}

/// Live prices and offer tokens collected for the paywall.
class PaywallCatalogSnapshot {
  const PaywallCatalogSnapshot({
    this.priceLabels = const {},
    this.trialPhrases = const {},
    this.offerTokens = const {},
    this.recurringMicros = const {},
    this.currencyCodes = const {},
  });

  static const empty = PaywallCatalogSnapshot();

  final Map<String, String> priceLabels;
  final Map<String, String> trialPhrases;
  final Map<String, String> offerTokens;
  final Map<String, int> recurringMicros;
  final Map<String, String> currencyCodes;
}

final RegExp _isoPeriod = RegExp(r'^P(\d+)([DWMY])$', caseSensitive: false);

/// Parses a single-unit ISO-8601 period into a compound like `3-day` or `1-week`.
///
/// Returns null when the period is missing, zero, or not a simple PnD/PnW/PnM/PnY
/// value. Callers must not invent a trial length in that case.
String? formatBillingPeriod(String iso8601) {
  final match = _isoPeriod.firstMatch(iso8601.trim());
  if (match == null) return null;
  final count = int.tryParse(match.group(1)!);
  if (count == null || count <= 0) return null;
  final unit = switch (match.group(2)!.toUpperCase()) {
    'D' => 'day',
    'W' => 'week',
    'M' => 'month',
    'Y' => 'year',
    _ => null,
  };
  if (unit == null) return null;
  return '$count-$unit';
}

/// Percent saved by the yearly plan versus 12 monthly payments, rounded down.
///
/// Hidden (null) when either price is missing, not positive, or the currencies
/// differ. A yearly price that is not cheaper than 12 months is also hidden.
int? yearlySavingsPercent({
  required int? yearlyMicros,
  required int? monthlyMicros,
  required String? yearlyCurrency,
  required String? monthlyCurrency,
}) {
  if (yearlyMicros == null || monthlyMicros == null) return null;
  if (yearlyMicros <= 0 || monthlyMicros <= 0) return null;
  if (yearlyCurrency == null || monthlyCurrency == null) return null;
  if (yearlyCurrency.isEmpty || monthlyCurrency.isEmpty) return null;
  if (yearlyCurrency.toUpperCase() != monthlyCurrency.toUpperCase()) {
    return null;
  }

  final annualizedMonthly = monthlyMicros * 12;
  if (yearlyMicros >= annualizedMonthly) return null;
  final percent = ((annualizedMonthly - yearlyMicros) * 100) ~/ annualizedMonthly;
  if (percent <= 0) return null;
  return percent;
}

/// `Save 58%`, or null when [yearlySavingsPercent] cannot be computed.
String? yearlySavingsLabel({
  required int? yearlyMicros,
  required int? monthlyMicros,
  required String? yearlyCurrency,
  required String? monthlyCurrency,
}) {
  final percent = yearlySavingsPercent(
    yearlyMicros: yearlyMicros,
    monthlyMicros: monthlyMicros,
    yearlyCurrency: yearlyCurrency,
    monthlyCurrency: monthlyCurrency,
  );
  if (percent == null) return null;
  return 'Save $percent%';
}

/// Builds the paywall line for [plan] from offers the store actually returned.
///
/// Monthly and yearly prefer an eligible free-trial offer (a zero-price phase
/// plus a paid recurring phase). The trial length comes only from that free
/// phase's billing period. The amount is the recurring phase's formatted price.
/// Lifetime never includes trial wording.
PaywallQuote describePlan({
  required SubscriptionPlan plan,
  required List<StoreOffer> offers,
  required bool storeAvailable,
  required bool isLoading,
}) {
  if (isLoading) return PaywallQuote.loading;
  if (!storeAvailable || offers.isEmpty) return PaywallQuote.unavailable;

  if (plan == SubscriptionPlan.lifetime) {
    final paid = _paidPhase(offers);
    if (paid == null) return PaywallQuote.unavailable;
    return PaywallQuote(
      priceLabel: paid.formattedPrice.trim(),
      recurringMicros: paid.priceAmountMicros,
      currencyCode: paid.currencyCode,
      purchasable: true,
    );
  }

  final trial = _freeTrialOffer(offers);
  final base = _baseOffer(offers);
  final chosen = trial ?? base;
  if (chosen == null) return PaywallQuote.unavailable;
  final recurring = _recurringPaid(chosen);
  if (recurring == null) return PaywallQuote.unavailable;

  final suffix = plan == SubscriptionPlan.yearly ? '/yr' : '/mo';
  final priceWithSuffix = _withSuffix(recurring.formattedPrice, suffix);

  if (trial != null) {
    final length = formatBillingPeriod(_freePhase(trial)!.billingPeriod);
    if (length != null) {
      final phrase = '$length free trial';
      return PaywallQuote(
        priceLabel: '$phrase, then $priceWithSuffix',
        trialPhrase: phrase,
        offerToken: trial.offerToken,
        recurringMicros: recurring.priceAmountMicros,
        currencyCode: recurring.currencyCode,
        purchasable: true,
      );
    }
  }

  final baseRecurring = base == null ? recurring : (_recurringPaid(base) ?? recurring);
  return PaywallQuote(
    priceLabel: _withSuffix(baseRecurring.formattedPrice, suffix),
    offerToken: (base ?? chosen).offerToken,
    recurringMicros: baseRecurring.priceAmountMicros,
    currencyCode: baseRecurring.currencyCode,
    purchasable: true,
  );
}

PaywallCatalogSnapshot snapshotFromQuotes(Map<String, PaywallQuote> quotes) {
  final priceLabels = <String, String>{};
  final trialPhrases = <String, String>{};
  final offerTokens = <String, String>{};
  final recurringMicros = <String, int>{};
  final currencyCodes = <String, String>{};

  for (final entry in quotes.entries) {
    final quote = entry.value;
    if (!quote.purchasable) continue;
    priceLabels[entry.key] = quote.priceLabel;
    final trial = quote.trialPhrase;
    if (trial != null && trial.isNotEmpty) {
      trialPhrases[entry.key] = trial;
    }
    final token = quote.offerToken;
    if (token != null && token.isNotEmpty) {
      offerTokens[entry.key] = token;
    }
    final micros = quote.recurringMicros;
    if (micros != null) {
      recurringMicros[entry.key] = micros;
    }
    final currency = quote.currencyCode;
    if (currency != null && currency.isNotEmpty) {
      currencyCodes[entry.key] = currency;
    }
  }

  return PaywallCatalogSnapshot(
    priceLabels: priceLabels,
    trialPhrases: trialPhrases,
    offerTokens: offerTokens,
    recurringMicros: recurringMicros,
    currencyCodes: currencyCodes,
  );
}

StorePhase? _freePhase(StoreOffer offer) {
  for (final phase in offer.phases) {
    if (phase.isFree && formatBillingPeriod(phase.billingPeriod) != null) {
      return phase;
    }
  }
  return null;
}

StorePhase? _recurringPaid(StoreOffer offer) {
  StorePhase? infinite;
  StorePhase? paid;
  for (final phase in offer.phases) {
    if (phase.priceAmountMicros <= 0 || phase.formattedPrice.trim().isEmpty) {
      continue;
    }
    paid = phase;
    if (phase.recurrence == PhaseRecurrence.infinite) {
      infinite = phase;
    }
  }
  return infinite ?? paid;
}

StorePhase? _paidPhase(List<StoreOffer> offers) {
  StorePhase? paid;
  for (final offer in offers) {
    for (final phase in offer.phases) {
      if (phase.priceAmountMicros > 0 && phase.formattedPrice.trim().isNotEmpty) {
        paid = phase;
      }
    }
  }
  return paid;
}

StoreOffer? _freeTrialOffer(List<StoreOffer> offers) {
  for (final offer in offers) {
    if (_freePhase(offer) != null && _recurringPaid(offer) != null) {
      return offer;
    }
  }
  return null;
}

StoreOffer? _baseOffer(List<StoreOffer> offers) {
  for (final offer in offers) {
    if (offer.offerId == null && _recurringPaid(offer) != null) {
      return offer;
    }
  }
  for (final offer in offers) {
    if (_freePhase(offer) == null && _recurringPaid(offer) != null) {
      return offer;
    }
  }
  return null;
}

String _withSuffix(String formattedPrice, String suffix) {
  final trimmed = formattedPrice.trim();
  if (trimmed.endsWith(suffix)) return trimmed;
  return '$trimmed$suffix';
}
