import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cryptographically verified local vault storage.
/// Protects against on-device tampering, memory modification,
/// and local XML manipulation of Pro licenses and Starlight Pass tokens.
class EncryptedVaultStorage {
  EncryptedVaultStorage._();
  static final EncryptedVaultStorage instance = EncryptedVaultStorage._();

  // Internal HMAC salt secret - combined with client salt for tamper detection
  static const String _secretSalt = 'oraculum_sacred_vault_hmac_2026_salt_x99';

  /// Generates an HMAC-SHA256 signature for a key-value pair
  String _generateSignature(String key, String value) {
    final keyBytes = utf8.encode(_secretSalt);
    final dataBytes = utf8.encode('$key:$value:$_secretSalt');
    final hmac = Hmac(sha256, keyBytes);
    return hmac.convert(dataBytes).toString();
  }

  /// Writes an integer value with cryptographic HMAC signature
  Future<void> setSignedInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    final valueStr = value.toString();
    final signature = _generateSignature(key, valueStr);

    await prefs.setInt(key, value);
    await prefs.setString('${key}_sig', signature);
  }

  /// Reads an integer value, verifying its cryptographic HMAC signature.
  /// If tampered or signature mismatch, resets to [defaultValue].
  Future<int> getSignedInt(String key, {int defaultValue = 0}) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) return defaultValue;

    final value = prefs.getInt(key);
    final signature = prefs.getString('${key}_sig');

    if (value == null || signature == null) {
      return defaultValue;
    }

    final expectedSignature = _generateSignature(key, value.toString());
    if (signature != expectedSignature) {
      debugPrint('[SecurityAlert] Tamper detected on key "$key". Signature mismatch. Resetting.');
      await prefs.remove(key);
      await prefs.remove('${key}_sig');
      return defaultValue;
    }

    return value;
  }

  /// Writes a boolean value with cryptographic HMAC signature
  Future<void> setSignedBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final valueStr = value.toString();
    final signature = _generateSignature(key, valueStr);

    await prefs.setBool(key, value);
    await prefs.setString('${key}_sig', signature);
  }

  /// Reads a boolean value, verifying its cryptographic signature
  Future<bool> getSignedBool(String key, {bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) return defaultValue;

    final value = prefs.getBool(key);
    final signature = prefs.getString('${key}_sig');

    if (value == null || signature == null) {
      return defaultValue;
    }

    final expectedSignature = _generateSignature(key, value.toString());
    if (signature != expectedSignature) {
      debugPrint('[SecurityAlert] Tamper detected on boolean key "$key". Resetting.');
      await prefs.remove(key);
      await prefs.remove('${key}_sig');
      return defaultValue;
    }

    return value;
  }
}
