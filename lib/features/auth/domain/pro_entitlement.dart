import 'user_profile.dart';

/// Guests are device-only profiles. They never carry Oracle Pro.
bool profileIsGuest(UserProfile profile) {
  final email = profile.email;
  return profile.id.startsWith('local_') ||
      email == null ||
      email.isEmpty ||
      email == 'seeker@oraculum.app';
}

UserProfile withoutGuestPro(UserProfile profile) {
  if (!profileIsGuest(profile) || !profile.isPro) return profile;
  return profile.copyWith(isPro: false);
}

/// Server and client share this rule: a local `isPro` flag does not outlive
/// `proExpiresAt`. Null expiry is lifetime (a verified one-time product).
bool proIsActive(UserProfile profile, DateTime now) {
  if (!profile.isPro) return false;
  final expiry = profile.proExpiresAt;
  if (expiry == null) return true;
  return expiry.toUtc().isAfter(now.toUtc());
}

/// Drops a stale Pro flag. The expiry timestamp is kept so the caller can see
/// why the entitlement ended.
UserProfile enforceProExpiry(UserProfile profile, [DateTime? now]) {
  if (proIsActive(profile, now ?? DateTime.now())) return profile;
  if (!profile.isPro) return profile;
  return profile.copyWith(isPro: false);
}
