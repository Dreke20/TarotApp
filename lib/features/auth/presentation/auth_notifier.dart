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
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = await _repository.getCurrentProfile();
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = await _repository.signInWithEmail(email, password);
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> signUp(String email, String password, String displayName) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile =
          await _repository.signUpWithEmail(email, password, displayName);
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateZodiacSigns({
    required String sunSign,
    String? moonSign,
    String? risingSign,
  }) async {
    final current = state.profile;
    if (current == null) return;
    final updated = current.copyWith(
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

  Future<void> setProStatus(bool isPro) async {
    final current = state.profile;
    if (current == null) return;
    final updated = current.copyWith(isPro: isPro);
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
}

@riverpod
bool isProUser(Ref ref) {
  return ref.watch(authProvider).isPro;
}

/// Backwards compatibility alias for the generated [authProvider].
final authNotifierProvider = authProvider;

