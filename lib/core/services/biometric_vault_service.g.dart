// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_vault_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BiometricVaultNotifier)
final biometricVaultProvider = BiometricVaultNotifierProvider._();

final class BiometricVaultNotifierProvider
    extends $AsyncNotifierProvider<BiometricVaultNotifier, bool> {
  BiometricVaultNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricVaultProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricVaultNotifierHash();

  @$internal
  @override
  BiometricVaultNotifier create() => BiometricVaultNotifier();
}

String _$biometricVaultNotifierHash() =>
    r'2ee757366448a85293d88d1657cd6c998270860f';

abstract class _$BiometricVaultNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
