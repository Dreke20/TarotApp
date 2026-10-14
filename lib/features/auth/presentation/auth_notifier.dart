import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/supabase/supabase_client.dart';
import '../data/auth_repository.dart';
import '../domain/user_profile.dart';

class AuthState {
  final UserProfile? profile;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isAuthenticated => profile != null;
  bool get isPro => profile?.isPro ?? false;

  AuthState copyWith({
    UserProfile? profile,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  late AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.watch(authRepositoryProvider);
    Future.microtask(() => loadProfile());
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
      final profile = await _repository.signUpWithEmail(email, password, displayName);
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
    if (state.profile == null) return;
    final updated = state.profile!.copyWith(
      zodiacSign: sunSign,
      moonSign: moonSign,
      risingSign: risingSign,
    );
    await _repository.updateProfile(updated);
    state = state.copyWith(profile: updated);
  }

  Future<void> setProStatus(bool isPro) async {
    if (state.profile == null) return;
    final updated = state.profile!.copyWith(isPro: isPro);
    await _repository.updateProfile(updated);
    state = state.copyWith(profile: updated);
  }

  Future<void> signOut() async {
    await _repository.signOut();
    await loadProfile();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return AuthRepository(client);
});

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

final isProUserProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isPro;
});
