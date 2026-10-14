import 'package:freezed_annotation/freezed_annotation.dart';

part 'monetization_state.freezed.dart';

/// Immutable monetization state tracking rewarded ad passes & offerings.
@freezed
abstract class MonetizationState with _$MonetizationState {
  const MonetizationState._();

  const factory MonetizationState({
    @Default(0) int starlightPassTokens,
    @Default(0) int totalOfferingsMade,
    @Default(false) bool isOfferingInProgress,
    DateTime? lastOfferingAt,
    String? message,
  }) = _MonetizationState;

  bool get hasStarlightPass => starlightPassTokens > 0;
}
