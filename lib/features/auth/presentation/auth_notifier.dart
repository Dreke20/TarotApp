import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/supabase/supabase_client.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

export 'auth_state.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final client = ref.watch(supabaseClientProvider);
  return AuthRepository(client);
}

/// Session + seeker profile state. Generated provider: [authProvider].
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.watch(authRepositoryProvider);
    Future.microtask(loadProfile);
    return const AuthState();
  }

  Future<void> loadProfile() async {
    if (!ref.mounted) return;
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = await _repository.getCurrentProfile();
      if (!ref.mounted) return;
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = await _repository.signInWithEmail(email, password);
      state = state.copyWith(profile: profile, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: _formatAuthError(e));
      return false;
    }
  }

  Future<bool> signUp(
    String email,
    String password,
    String displayName, {
    String? sunSign,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      var profile =
          await _repository.signUpWithEmail(email, password, displayName);
      if (sunSign != null) {
        profile = profile.copyWith(zodiacSign: sunSign);
        await _repository.updateProfile(profile);
      }
      state = state.copyWith(profile: profile, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: _formatAuthError(e));
      return false;
    }
  }

  Future<bool> sendPasswordReset(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.sendPasswordReset(email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: _formatAuthError(e));
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  String _formatAuthError(Object error) {
    final str = error.toString();
    if (str.contains('Invalid login credentials')) {
      return 'Incorrect email or password. Please verify your credentials.';
    }
    if (str.contains('User already registered') || str.contains('already exists')) {
      return 'An account with this email already exists. Try signing in.';
    }
    if (str.contains('Password should be at least')) {
      return 'Your password must be at least 6 characters.';
    }
    if (str.contains('valid email')) {
      return 'Please enter a valid email address.';
    }
    return str.replaceFirst('Exception: ', '').replaceFirst('AuthException: ', '');
  }

  Future<void> updateZodiacSigns({
    required String sunSign,
    String? moonSign,
    String? risingSign,
    String? displayName,
  }) async {
    final current = state.profile;
    if (current == null) return;
    final updated = current.copyWith(
      displayName: displayName ?? current.displayName,
      zodiacSign: sunSign,
      moonSign: moonSign,
      risingSign: risingSign,
    );
    try {
      await _repository.updateProfile(updated);
      state = state.copyWith(profile: updated, errorMessage: null);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Activates Pro from a verified store receipt. Promo redemption is rejected.
  Future<bool> activatePro({
    String action = 'subscribe',
    String plan = 'yearly',
    String? receipt,
    String? productId,
    String? source,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = await _repository.verifyAndActivatePro(
        action: action,
        plan: plan,
        receipt: receipt,
        productId: productId,
        source: source,
      );
      state = state.copyWith(profile: profile, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Clears a local Pro flag. Passing `true` does not grant Pro.
  Future<void> setProStatus(bool isPro) async {
    if (isPro) {
      state = state.copyWith(
        errorMessage: 'Oracle Pro can only be unlocked with a store purchase.',
      );
      return;
    }
    final current = state.profile;
    if (current == null) return;
    final updated = current.copyWith(isPro: false);
    try {
      await _repository.updateProfile(updated);
      state = state.copyWith(profile: updated, errorMessage: null);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
    await loadProfile();
  }

  Future<void> deleteAccount() async {
    try {
      await _repository.deleteAccount();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
    await loadProfile();
  }
}


@riverpod
bool isProUser(Ref ref) {
  return ref.watch(authProvider).isPro;
}

/// Backwards compatibility alias for the generated [authProvider].
final authNotifierProvider = authProvider;

