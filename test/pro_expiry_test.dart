import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/core/services/storage_service.dart';
import 'package:tarot_app/features/auth/domain/pro_entitlement.dart';
import 'package:tarot_app/features/auth/domain/user_profile.dart';
import 'package:tarot_app/features/auth/presentation/auth_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final past = DateTime.utc(2020, 1, 1);
  final future = DateTime.utc(2030, 1, 1);
  final now = DateTime.utc(2026, 10, 29);

  UserProfile profile({required bool isPro, DateTime? proExpiresAt}) {
    return UserProfile(
      id: 'seeker-1',
      email: 'seeker@example.com',
      isPro: isPro,
      proExpiresAt: proExpiresAt,
    );
  }

  test('a local Pro flag is ignored once the stored expiry has passed', () {
    expect(proIsActive(profile(isPro: true, proExpiresAt: past), now), isFalse);
    expect(
      enforceProExpiry(profile(isPro: true, proExpiresAt: past), now).isPro,
      isFalse,
    );
    expect(
      AuthState(profile: profile(isPro: true, proExpiresAt: past)).isPro,
      isFalse,
    );
  });

  test('lifetime Pro has no expiry and a future expiry stays Pro', () {
    expect(proIsActive(profile(isPro: true), now), isTrue);
    expect(proIsActive(profile(isPro: true, proExpiresAt: future), now), isTrue);
    expect(proIsActive(profile(isPro: false, proExpiresAt: future), now), isFalse);
    final json = profile(isPro: true, proExpiresAt: future).toJson();
    expect(json['pro_expires_at'], future.toIso8601String());
    expect(UserProfile.fromJson(json).proExpiresAt, future);
  });

  test('cached Pro is dropped when the signed expiry does not match', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = StorageService();
    await storage.saveProfile(profile(isPro: true, proExpiresAt: future));

    final honest = await storage.loadProfile();
    expect(honest!.isPro, isTrue);

    final prefs = await SharedPreferences.getInstance();
    final raw = jsonDecode(prefs.getString('oraculum_profile_cache_v1')!) as Map<String, dynamic>;
    raw['pro_expires_at'] = future.add(const Duration(days: 365)).toIso8601String();
    await prefs.setString('oraculum_profile_cache_v1', jsonEncode(raw));

    final loaded = await storage.loadProfile();
    expect(loaded!.isPro, isFalse);
  });

  test('a saved Pro flag past its expiry does not reload as Pro', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = StorageService();
    await storage.saveProfile(profile(isPro: true, proExpiresAt: past));
    final loaded = await storage.loadProfile();
    expect(loaded!.isPro, isFalse);
    expect(loaded.proExpiresAt, past);
  });
}
