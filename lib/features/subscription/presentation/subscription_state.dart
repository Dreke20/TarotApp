import 'package:freezed_annotation/freezed_annotation.dart';
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
    String? errorMessage,
    String? successMessage,
  }) = _SubscriptionState;

  String priceFor(SubscriptionPlan plan) {
    return localizedPrices[plan.id] ?? plan.defaultPrice;
  }
}
