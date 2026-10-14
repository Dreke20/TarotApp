import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/user_profile.dart';

part 'auth_state.freezed.dart';

/// Immutable authentication/session state for the current seeker.
@freezed
abstract class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    UserProfile? profile,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _AuthState;

  bool get isAuthenticated => profile != null;
  bool get isPro => profile?.isPro ?? false;
}
