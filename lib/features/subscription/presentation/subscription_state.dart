import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/subscription_offer.dart' as billing;
import '../domain/subscription_plan.dart';

part 'subscription_state.freezed.dart';

/// Immutable state for In-App Purchases and Oracle Pro subscriptions.
@freezed
abstract class SubscriptionState with _$SubscriptionState {
  const SubscriptionState._();

  const factory SubscriptionState({
    @Default(false) bool isAvailable,
    @Default(false) bool isLoading,
    @Default(SubscriptionPlan.yearly) SubscriptionPlan selectedPlan,
    @Default(false) bool isSubmitting,
    @Default(<String, String>{}) Map<String, String> localizedPrices,
    @Default(<String, String>{}) Map<String, String> trialPhrases,
    @Default(<String, String>{}) Map<String, String> offerTokens,
    @Default(<String, int>{}) Map<String, int> recurringMicros,
    @Default(<String, String>{}) Map<String, String> currencyCodes,
    String? errorMessage,
    String? successMessage,
  }) = _SubscriptionState;

  /// Live store price when one has been loaded, otherwise the approved
  /// catalog fallback. The paywall uses [paywallPriceFor] instead.
  String priceFor(SubscriptionPlan plan) {
    return localizedPrices[plan.id] ?? plan.defaultPrice;
  }

  /// Price line for the paywall. Loading and store-unavailable states never
  /// fall back to [SubscriptionPlan.defaultPrice].
  String paywallPriceFor(SubscriptionPlan plan) {
    if (isLoading) return billing.PaywallQuote.loadingPrice;
    if (!isAvailable) return billing.PaywallQuote.unavailablePrice;
    return localizedPrices[plan.id] ?? billing.PaywallQuote.unavailablePrice;
  }

  String? trialPhraseFor(SubscriptionPlan plan) {
    if (plan == SubscriptionPlan.lifetime || isLoading || !isAvailable) {
      return null;
    }
    final phrase = trialPhrases[plan.id];
    if (phrase == null || phrase.isEmpty) return null;
    return phrase;
  }

  String? offerTokenFor(SubscriptionPlan plan) {
    if (isLoading || !isAvailable) return null;
    final token = offerTokens[plan.id];
    if (token == null || token.isEmpty) return null;
    return token;
  }

  bool canPurchase(SubscriptionPlan plan) {
    if (isLoading || !isAvailable || isSubmitting) return false;
    final price = localizedPrices[plan.id];
    return price != null && price.isNotEmpty;
  }

  /// `Save 58%` from live yearly and monthly recurring prices, or null.
  String? get yearlySavingsLabel {
    if (isLoading || !isAvailable) return null;
    return billing.yearlySavingsLabel(
      yearlyMicros: recurringMicros[SubscriptionPlan.yearly.id],
      monthlyMicros: recurringMicros[SubscriptionPlan.monthly.id],
      yearlyCurrency: currencyCodes[SubscriptionPlan.yearly.id],
      monthlyCurrency: currencyCodes[SubscriptionPlan.monthly.id],
    );
  }

  SubscriptionState withLiveCatalog(billing.PaywallCatalogSnapshot catalog) {
    return copyWith(
      localizedPrices: catalog.priceLabels,
      trialPhrases: catalog.trialPhrases,
      offerTokens: catalog.offerTokens,
      recurringMicros: catalog.recurringMicros,
      currencyCodes: catalog.currencyCodes,
    );
  }
}
