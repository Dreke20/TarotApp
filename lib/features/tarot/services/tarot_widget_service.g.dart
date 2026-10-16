// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarot_widget_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tarotWidgetService)
final tarotWidgetServiceProvider = TarotWidgetServiceProvider._();

final class TarotWidgetServiceProvider
    extends
        $FunctionalProvider<
          TarotWidgetService,
          TarotWidgetService,
          TarotWidgetService
        >
    with $Provider<TarotWidgetService> {
  TarotWidgetServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tarotWidgetServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tarotWidgetServiceHash();

  @$internal
  @override
  $ProviderElement<TarotWidgetService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TarotWidgetService create(Ref ref) {
    return tarotWidgetService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TarotWidgetService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TarotWidgetService>(value),
    );
  }
}

String _$tarotWidgetServiceHash() =>
    r'9b653dc0a9e59caea5b5f03a517ab57de4a6bf7e';
