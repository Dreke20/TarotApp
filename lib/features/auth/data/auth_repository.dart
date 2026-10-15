import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/supabase/supabase_config.dart';
import '../domain/user_profile.dart';

class AuthRepository {
  final SupabaseClient? _supabase;
  final StorageService _storage;

  static UserProfile _localProfile = const UserProfile(
    id: 'local_seeker_001',
    email: 'seeker@oraculum.app',
    displayName: 'Cosmic Seeker',
    zodiacSign: 'Scorpio',
    moonSign: 'Pisces',
    risingSign: 'Leo',
    isPro: false,
  );

  AuthRepository([this._supabase, StorageService? storage])
      : _storage = storage ?? StorageService();

  User? get currentUser => _supabase?.auth.currentUser;

  Future<UserProfile> getCurrentProfile() async {
    // 1. Try loading cached profile from persistent device storage
    final cached = await _storage.loadProfile();
    if (cached != null) {
      _localProfile = cached;
    }

    // 2. Fetch fresh profile from Supabase if online
    if (_supabase != null && SupabaseConfig.isConfigured) {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        try {
          final data = await _supabase
              .from('profiles')
              .select()
              .eq('id', user.id)
              .maybeSingle();

          if (data != null) {
            final remoteProfile = UserProfile.fromJson(data);
            await _storage.saveProfile(remoteProfile);
            return remoteProfile;
          } else {
            // Create default profile
            final newProfile = UserProfile(
              id: user.id,
              email: user.email,
              displayName:
                  user.userMetadata?['display_name'] as String? ?? 'Seeker',
              createdAt: DateTime.now(),
            );
            await updateProfile(newProfile);
            return newProfile;
          }
        } catch (e) {
          debugPrint('Error fetching profile from Supabase: $e');
        }
      }
    }

    return _localProfile;
  }

  Future<UserProfile> updateProfile(UserProfile profile) async {
    _localProfile = profile;
    await _storage.saveProfile(profile);

    final authUserId = _supabase?.auth.currentUser?.id;
    if (_supabase != null &&
        SupabaseConfig.isConfigured &&
        authUserId != null &&
        authUserId == profile.id) {
      try {
        // `is_pro` is server-owned (guarded by a DB trigger); never send it.
        final payload = Map<String, Object?>.from(profile.toJson())
          ..remove('is_pro')
          ..removeWhere((key, value) => key == 'created_at' && value == null);
        await _supabase.from('profiles').upsert(payload);
      } catch (e) {
        debugPrint('Error updating profile in Supabase: $e');
      }
    }

    return _localProfile;
  }

  Future<UserProfile> signInWithEmail(String email, String password) async {
    if (_supabase != null && SupabaseConfig.isConfigured) {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return getCurrentProfile();
      }
    }

    _localProfile =
        _localProfile.copyWith(email: email, displayName: email.split('@').first);
    await _storage.saveProfile(_localProfile);
    return _localProfile;
  }

  Future<UserProfile> signUpWithEmail(
      String email, String password, String displayName) async {
    if (_supabase != null && SupabaseConfig.isConfigured) {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'display_name': displayName},
      );
      if (response.user != null) {
        final profile = UserProfile(
          id: response.user!.id,
          email: email,
          displayName: displayName,
          createdAt: DateTime.now(),
        );
        return updateProfile(profile);
      }
    }

    _localProfile =
        _localProfile.copyWith(email: email, displayName: displayName);
    await _storage.saveProfile(_localProfile);
    return _localProfile;
  }

  Future<void> signOut() async {
    if (_supabase != null && SupabaseConfig.isConfigured) {
      await _supabase.auth.signOut();
    }
  }

  /// Securely verifies and activates Oracle Pro through the Supabase Edge Function
  Future<UserProfile> verifyAndActivatePro({
    String action = 'subscribe',
    String plan = 'yearly',
    String? promoCode,
    String? receipt,
    String? productId,
    String? source,
  }) async {
    if (_supabase != null && SupabaseConfig.isConfigured) {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final res = await _supabase.functions.invoke(
          'verify-subscription',
          body: {
            'action': action,
            'plan': plan,
            if (promoCode != null && promoCode.trim().isNotEmpty)
              'promo_code': promoCode.trim(),
            if (receipt != null && receipt.trim().isNotEmpty)
              'receipt': receipt.trim(),
            'product_id': ?productId,
            'source': ?source,
          },
        );
        if (res.status == 200) {
          // Re-fetch fresh profile from Supabase with verified is_pro
          return getCurrentProfile();
        } else {
          final data = res.data;
          final errorMsg = (data is Map && data['error'] != null)
              ? data['error'].toString()
              : 'Failed to verify subscription with server';
          throw Exception(errorMsg);
        }
      }
    }

    // Local / Guest fallback for offline testing
    _localProfile = _localProfile.copyWith(isPro: true);
    await _storage.saveProfile(_localProfile);
    return _localProfile;
  }
}
