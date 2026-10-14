// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(streak)
final streakProvider = StreakProvider._();

final class StreakProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  StreakProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'streakProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$streakHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return streak(ref);
  }
}

String _$streakHash() => r'6346843e0c467d8a68b0fd33edea2a940f0550bd';
