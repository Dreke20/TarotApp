import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/supabase/supabase_config.dart';
import '../domain/pro_entitlement.dart';
import '../domain/user_profile.dart';

class AuthRepository {
  final SupabaseClient? _supabase;
  final StorageService _storage;

  static UserProfile _localProfile = const UserProfile(
    id: 'local_seeker_001',
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
      _localProfile = withoutGuestPro(enforceProExpiry(cached));
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
            final remoteProfile = enforceProExpiry(UserProfile.fromJson(data));
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

    return withoutGuestPro(enforceProExpiry(_localProfile));
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
    _localProfile = const UserProfile(
      id: 'local_seeker_001',
      displayName: 'Cosmic Seeker',
      zodiacSign: 'Scorpio',
      moonSign: 'Pisces',
      risingSign: 'Leo',
      isPro: false,
    );
    await _storage.saveProfile(_localProfile);
  }

  Future<void> sendPasswordReset(String email) async {
    if (_supabase != null && SupabaseConfig.isConfigured) {
      await _supabase.auth.resetPasswordForEmail(email);
    }
  }

  /// Deletes the signed-in account on the server, then clears the local profile.
  ///
  /// The Edge Function removes the user's rows, storage objects, and auth user.
  /// Guests only have on-device data, so they are cleared locally.
  Future<void> deleteAccount() async {
    if (_supabase != null && SupabaseConfig.isConfigured) {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final res = await _supabase.functions.invoke('delete-account');
        if (res.status != 200) {
          final data = res.data;
          final errorMsg = (data is Map && data['error'] != null)
              ? data['error'].toString()
              : 'Account deletion did not finish.';
          throw Exception(errorMsg);
        }
      }
      try {
        await _supabase.auth.signOut();
      } catch (_) {}
    }
    _localProfile = const UserProfile(id: 'local_seeker', isPro: false);
    await _storage.saveProfile(_localProfile);
  }


  /// Activates Oracle Pro from a store purchase receipt.
  ///
  /// Promo redemption is rejected. A non-empty store receipt is required.
  Future<UserProfile> verifyAndActivatePro({
    String action = 'subscribe',
    String plan = 'yearly',
    String? receipt,
    String? productId,
    String? source,
  }) async {
    if (action == 'redeem_promo') {
      throw Exception(
        'Promo codes are not accepted. Oracle Pro is available through the store.',
      );
    }

    final purchaseReceipt = receipt?.trim() ?? '';
    if (purchaseReceipt.isEmpty) {
      throw Exception(
        'A store purchase receipt is required to activate Oracle Pro.',
      );
    }
    if (action != 'subscribe' && action != 'restore_purchase') {
      throw Exception('Oracle Pro can only be activated from a store purchase.');
    }

    if (_supabase != null && SupabaseConfig.isConfigured) {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final res = await _supabase.functions.invoke(
          'verify-subscription',
          body: {
            'action': action,
            'plan': plan,
            'receipt': purchaseReceipt,
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

    // Guests have no account for the server to verify. Never grant local Pro.
    throw Exception(
      'Sign in before unlocking Oracle Pro. A store receipt is checked on the server.',
    );
  }
}
