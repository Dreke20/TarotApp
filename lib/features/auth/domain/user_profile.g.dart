// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  email: json['email'] as String?,
  displayName: json['display_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  zodiacSign: json['zodiac_sign'] as String?,
  moonSign: json['moon_sign'] as String?,
  risingSign: json['rising_sign'] as String?,
  isPro: json['is_pro'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'zodiac_sign': instance.zodiacSign,
      'moon_sign': instance.moonSign,
      'rising_sign': instance.risingSign,
      'is_pro': instance.isPro,
      'created_at': instance.createdAt?.toIso8601String(),
    };
