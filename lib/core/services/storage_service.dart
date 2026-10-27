import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/domain/user_profile.dart';
import '../../features/tarot/domain/reading.dart';
import '../../features/dream/domain/dream_entry.dart';
import '../../features/tarot/domain/custom_spread.dart';
import 'encrypted_vault_storage.dart';

part 'storage_service.g.dart';

class StorageService {
  static const String _keyReadings = 'oraculum_readings_cache_v1';
  static const String _keyProfile = 'oraculum_profile_cache_v1';
  static const String _keyProfileProSig = 'oraculum_profile_is_pro_sig';
  static const String _keyDreams = 'oraculum_dreams_cache_v1';
  static const String _keyCustomSpreads = 'oraculum_custom_spreads_cache_v1';
  static const String _keyNotificationHour = 'oraculum_notif_hour';
  static const String _keyNotificationMinute = 'oraculum_notif_minute';
  static const String _keyNotificationEnabled = 'oraculum_notif_enabled';

  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // --- READINGS CACHE ---
  Future<void> saveReadings(List<Reading> readings) async {
    final prefs = await _getPrefs();
    final jsonList = readings.map((r) => r.toJson()).toList();
    await prefs.setString(_keyReadings, jsonEncode(jsonList));
  }

  Future<List<Reading>> loadReadings() async {
    final prefs = await _getPrefs();
    final raw = prefs.getString(_keyReadings);
    if (raw == null || raw.isEmpty) return [];

    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((item) => Reading.fromJson(item as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  // --- PROFILE CACHE ---
  Future<void> saveProfile(UserProfile profile) async {
    final prefs = await _getPrefs();
    await prefs.setString(_keyProfile, jsonEncode(profile.toJson()));
    // Cryptographically sign the isPro entitlement with hardware Keystore HMAC
    await EncryptedVaultStorage.instance.setSignedBool(_keyProfileProSig, profile.isPro);
  }

  Future<UserProfile?> loadProfile() async {
    final prefs = await _getPrefs();
    final raw = prefs.getString(_keyProfile);
    if (raw == null || raw.isEmpty) return null;

    try {
      final profile = UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      // Verify isPro against the cryptographically signed vault
      final verifiedPro = await EncryptedVaultStorage.instance.getSignedBool(
        _keyProfileProSig,
        defaultValue: false,
      );
      // If the plaintext JSON was tampered with (e.g. isPro modified to true without valid HMAC),
      // enforce the cryptographically verified entitlement.
      if (profile.isPro && !verifiedPro) {
        return profile.copyWith(isPro: false);
      }
      return profile;
    } catch (_) {
      return null;
    }
  }

  // --- DREAMS CACHE ---
  Future<void> saveDreams(List<DreamEntry> dreams) async {
    final prefs = await _getPrefs();
    final jsonList = dreams.map((d) => d.toJson()).toList();
    await prefs.setString(_keyDreams, jsonEncode(jsonList));
  }

  Future<List<DreamEntry>> loadDreams() async {
    final prefs = await _getPrefs();
    final raw = prefs.getString(_keyDreams);
    if (raw == null || raw.isEmpty) return [];

    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((item) => DreamEntry.fromJson(item as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  // --- CUSTOM SPREADS CACHE ---
  Future<void> saveCustomSpreads(List<CustomSpread> spreads) async {
    final prefs = await _getPrefs();
    final jsonList = spreads.map((s) => s.toJson()).toList();
    await prefs.setString(_keyCustomSpreads, jsonEncode(jsonList));
  }

  Future<List<CustomSpread>> loadCustomSpreads() async {
    final prefs = await _getPrefs();
    final raw = prefs.getString(_keyCustomSpreads);
    if (raw == null || raw.isEmpty) return [];

    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((item) => CustomSpread.fromJson(item as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  // --- NOTIFICATION PREFERENCES ---
  Future<void> saveNotificationSettings({
    required bool enabled,
    required int hour,
    required int minute,
  }) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyNotificationEnabled, enabled);
    await prefs.setInt(_keyNotificationHour, hour);
    await prefs.setInt(_keyNotificationMinute, minute);
  }

  Future<({bool enabled, int hour, int minute})> loadNotificationSettings() async {
    final prefs = await _getPrefs();
    final enabled = prefs.getBool(_keyNotificationEnabled) ?? true;
    final hour = prefs.getInt(_keyNotificationHour) ?? 8;
    final minute = prefs.getInt(_keyNotificationMinute) ?? 0;
    return (enabled: enabled, hour: hour, minute: minute);
  }
}

@Riverpod(keepAlive: true)
StorageService storageService(Ref ref) => StorageService();
