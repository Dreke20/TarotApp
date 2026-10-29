import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    String? email,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'zodiac_sign') String? zodiacSign,
    @JsonKey(name: 'moon_sign') String? moonSign,
    @JsonKey(name: 'rising_sign') String? risingSign,
    @JsonKey(name: 'is_pro') @Default(false) bool isPro,
    /// Null is lifetime Pro. A past timestamp means the store subscription ended.
    @JsonKey(name: 'pro_expires_at') DateTime? proExpiresAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
