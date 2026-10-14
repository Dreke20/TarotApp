// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get id; String? get email;@JsonKey(name: 'display_name') String? get displayName;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'zodiac_sign') String? get zodiacSign;@JsonKey(name: 'moon_sign') String? get moonSign;@JsonKey(name: 'rising_sign') String? get risingSign;@JsonKey(name: 'is_pro') bool get isPro;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.zodiacSign, _this.zodiacSign) || other.zodiacSign == _this.zodiacSign)&&(identical(other.moonSign, _this.moonSign) || other.moonSign == _this.moonSign)&&(identical(other.risingSign, _this.risingSign) || other.risingSign == _this.risingSign)&&(identical(other.isPro, _this.isPro) || other.isPro == _this.isPro)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserProfile;
  return Object.hash(runtimeType,_this.id,_this.email,_this.displayName,_this.avatarUrl,_this.zodiacSign,_this.moonSign,_this.risingSign,_this.isPro,_this.createdAt);
}

@override
String toString() {
  final _this = this as UserProfile;
  return 'UserProfile(id: ${_this.id}, email: ${_this.email}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, zodiacSign: ${_this.zodiacSign}, moonSign: ${_this.moonSign}, risingSign: ${_this.risingSign}, isPro: ${_this.isPro}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String? email,@JsonKey(name: 'display_name') String? displayName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'zodiac_sign') String? zodiacSign,@JsonKey(name: 'moon_sign') String? moonSign,@JsonKey(name: 'rising_sign') String? risingSign,@JsonKey(name: 'is_pro') bool isPro,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = freezed,Object? displayName = freezed,Object? avatarUrl = freezed,Object? zodiacSign = freezed,Object? moonSign = freezed,Object? risingSign = freezed,Object? isPro = null,Object? createdAt = freezed,}) {
  return _then(UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,zodiacSign: freezed == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as String?,moonSign: freezed == moonSign ? _self.moonSign : moonSign // ignore: cast_nullable_to_non_nullable
as String?,risingSign: freezed == risingSign ? _self.risingSign : risingSign // ignore: cast_nullable_to_non_nullable
as String?,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? email, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'zodiac_sign')  String? zodiacSign, @JsonKey(name: 'moon_sign')  String? moonSign, @JsonKey(name: 'rising_sign')  String? risingSign, @JsonKey(name: 'is_pro')  bool isPro, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.avatarUrl,_that.zodiacSign,_that.moonSign,_that.risingSign,_that.isPro,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? email, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'zodiac_sign')  String? zodiacSign, @JsonKey(name: 'moon_sign')  String? moonSign, @JsonKey(name: 'rising_sign')  String? risingSign, @JsonKey(name: 'is_pro')  bool isPro, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.email,_that.displayName,_that.avatarUrl,_that.zodiacSign,_that.moonSign,_that.risingSign,_that.isPro,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? email, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'zodiac_sign')  String? zodiacSign, @JsonKey(name: 'moon_sign')  String? moonSign, @JsonKey(name: 'rising_sign')  String? risingSign, @JsonKey(name: 'is_pro')  bool isPro, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.avatarUrl,_that.zodiacSign,_that.moonSign,_that.risingSign,_that.isPro,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, this.email, @JsonKey(name: 'display_name') this.displayName, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'zodiac_sign') this.zodiacSign, @JsonKey(name: 'moon_sign') this.moonSign, @JsonKey(name: 'rising_sign') this.risingSign, @JsonKey(name: 'is_pro') this.isPro = false, @JsonKey(name: 'created_at') this.createdAt});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String id;
@override final  String? email;
@override@JsonKey(name: 'display_name') final  String? displayName;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'zodiac_sign') final  String? zodiacSign;
@override@JsonKey(name: 'moon_sign') final  String? moonSign;
@override@JsonKey(name: 'rising_sign') final  String? risingSign;
@override@JsonKey(name: 'is_pro') final  bool isPro;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign)&&(identical(other.moonSign, moonSign) || other.moonSign == moonSign)&&(identical(other.risingSign, risingSign) || other.risingSign == risingSign)&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,displayName,avatarUrl,zodiacSign,moonSign,risingSign,isPro,createdAt);
}

@override
String toString() {
    return 'UserProfile(id: $id, email: $email, displayName: $displayName, avatarUrl: $avatarUrl, zodiacSign: $zodiacSign, moonSign: $moonSign, risingSign: $risingSign, isPro: $isPro, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String? email,@JsonKey(name: 'display_name') String? displayName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'zodiac_sign') String? zodiacSign,@JsonKey(name: 'moon_sign') String? moonSign,@JsonKey(name: 'rising_sign') String? risingSign,@JsonKey(name: 'is_pro') bool isPro,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = freezed,Object? displayName = freezed,Object? avatarUrl = freezed,Object? zodiacSign = freezed,Object? moonSign = freezed,Object? risingSign = freezed,Object? isPro = null,Object? createdAt = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,zodiacSign: freezed == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as String?,moonSign: freezed == moonSign ? _self.moonSign : moonSign // ignore: cast_nullable_to_non_nullable
as String?,risingSign: freezed == risingSign ? _self.risingSign : risingSign // ignore: cast_nullable_to_non_nullable
as String?,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
