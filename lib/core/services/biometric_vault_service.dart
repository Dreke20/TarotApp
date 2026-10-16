import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'biometric_vault_service.g.dart';

/// Service managing biometric authentication for private readings & journal reflections.
class BiometricVaultService {
  BiometricVaultService._();
  static final BiometricVaultService instance = BiometricVaultService._();

  final LocalAuthentication _auth = LocalAuthentication();
  static const String _prefKey = 'biometric_vault_enabled';

  /// Returns true if the device hardware supports biometrics
  Future<bool> isHardwareSupported() async {
    try {
      final isSupported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;
      return isSupported || canCheck;
    } catch (e) {
      debugPrint('[BiometricVault] Hardware check error: $e');
      return false;
    }
  }

  /// Returns whether the user has toggled the sanctuary vault ON
  Future<bool> isVaultEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefKey) ?? false;
  }

  /// Sets user preference for biometric vault lock
  Future<void> setVaultEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, enabled);
  }

  /// Prompts biometric scan (Fingerprint / Face Unlock / PIN fallback)
  Future<bool> authenticate({
    String reason = 'Consecrate and unlock your sacred journal reflections',
  }) async {
    try {
      final canAuth = await isHardwareSupported();
      if (!canAuth) return true; // Graceful pass if hardware is absent

      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
          useErrorDialogs: true,
        ),
      );
    } catch (e) {
      debugPrint('[BiometricVault] Authentication error: $e');
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
class BiometricVaultNotifier extends _$BiometricVaultNotifier {
  @override
  Future<bool> build() async {
    return await BiometricVaultService.instance.isVaultEnabled();
  }

  Future<void> toggleVault(bool enable) async {
    if (enable) {
      final success = await BiometricVaultService.instance.authenticate(
        reason: 'Verify biometric identity to enable Sacred Vault lock',
      );
      if (!success) return;
    }
    await BiometricVaultService.instance.setVaultEnabled(enable);
    state = AsyncData(enable);
  }
}
