// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSettings {

 bool get dailyEnabled; int get hour; int get minute; bool get lunarTransits; bool get sabbatAlerts;
/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsCopyWith<NotificationSettings> get copyWith => _$NotificationSettingsCopyWithImpl<NotificationSettings>(this as NotificationSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotificationSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettings&&(identical(other.dailyEnabled, _this.dailyEnabled) || other.dailyEnabled == _this.dailyEnabled)&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.minute, _this.minute) || other.minute == _this.minute)&&(identical(other.lunarTransits, _this.lunarTransits) || other.lunarTransits == _this.lunarTransits)&&(identical(other.sabbatAlerts, _this.sabbatAlerts) || other.sabbatAlerts == _this.sabbatAlerts));
}


@override
int get hashCode {
  final _this = this as NotificationSettings;
  return Object.hash(runtimeType,_this.dailyEnabled,_this.hour,_this.minute,_this.lunarTransits,_this.sabbatAlerts);
}

@override
String toString() {
  final _this = this as NotificationSettings;
  return 'NotificationSettings(dailyEnabled: ${_this.dailyEnabled}, hour: ${_this.hour}, minute: ${_this.minute}, lunarTransits: ${_this.lunarTransits}, sabbatAlerts: ${_this.sabbatAlerts})';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsCopyWith<$Res>  {
  factory $NotificationSettingsCopyWith(NotificationSettings value, $Res Function(NotificationSettings) _then) = _$NotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool dailyEnabled, int hour, int minute, bool lunarTransits, bool sabbatAlerts
});




}
/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._self, this._then);

  final NotificationSettings _self;
  final $Res Function(NotificationSettings) _then;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dailyEnabled = null,Object? hour = null,Object? minute = null,Object? lunarTransits = null,Object? sabbatAlerts = null,}) {
  return _then(NotificationSettings(
dailyEnabled: null == dailyEnabled ? _self.dailyEnabled : dailyEnabled // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,lunarTransits: null == lunarTransits ? _self.lunarTransits : lunarTransits // ignore: cast_nullable_to_non_nullable
as bool,sabbatAlerts: null == sabbatAlerts ? _self.sabbatAlerts : sabbatAlerts // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettings].
extension NotificationSettingsPatterns on NotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool dailyEnabled,  int hour,  int minute,  bool lunarTransits,  bool sabbatAlerts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
return $default(_that.dailyEnabled,_that.hour,_that.minute,_that.lunarTransits,_that.sabbatAlerts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool dailyEnabled,  int hour,  int minute,  bool lunarTransits,  bool sabbatAlerts)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettings():
return $default(_that.dailyEnabled,_that.hour,_that.minute,_that.lunarTransits,_that.sabbatAlerts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool dailyEnabled,  int hour,  int minute,  bool lunarTransits,  bool sabbatAlerts)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
return $default(_that.dailyEnabled,_that.hour,_that.minute,_that.lunarTransits,_that.sabbatAlerts);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationSettings extends NotificationSettings {
  const _NotificationSettings({this.dailyEnabled = true, this.hour = 8, this.minute = 0, this.lunarTransits = true, this.sabbatAlerts = true}): super._();
  

@override@JsonKey() final  bool dailyEnabled;
@override@JsonKey() final  int hour;
@override@JsonKey() final  int minute;
@override@JsonKey() final  bool lunarTransits;
@override@JsonKey() final  bool sabbatAlerts;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsCopyWith<_NotificationSettings> get copyWith => __$NotificationSettingsCopyWithImpl<_NotificationSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettings&&(identical(other.dailyEnabled, dailyEnabled) || other.dailyEnabled == dailyEnabled)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.lunarTransits, lunarTransits) || other.lunarTransits == lunarTransits)&&(identical(other.sabbatAlerts, sabbatAlerts) || other.sabbatAlerts == sabbatAlerts));
}


@override
int get hashCode {
    return Object.hash(runtimeType,dailyEnabled,hour,minute,lunarTransits,sabbatAlerts);
}

@override
String toString() {
    return 'NotificationSettings(dailyEnabled: $dailyEnabled, hour: $hour, minute: $minute, lunarTransits: $lunarTransits, sabbatAlerts: $sabbatAlerts)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsCopyWith<$Res> implements $NotificationSettingsCopyWith<$Res> {
  factory _$NotificationSettingsCopyWith(_NotificationSettings value, $Res Function(_NotificationSettings) _then) = __$NotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool dailyEnabled, int hour, int minute, bool lunarTransits, bool sabbatAlerts
});




}
/// @nodoc
class __$NotificationSettingsCopyWithImpl<$Res>
    implements _$NotificationSettingsCopyWith<$Res> {
  __$NotificationSettingsCopyWithImpl(this._self, this._then);

  final _NotificationSettings _self;
  final $Res Function(_NotificationSettings) _then;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dailyEnabled = null,Object? hour = null,Object? minute = null,Object? lunarTransits = null,Object? sabbatAlerts = null,}) {
  return _then(_NotificationSettings(
dailyEnabled: null == dailyEnabled ? _self.dailyEnabled : dailyEnabled // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,lunarTransits: null == lunarTransits ? _self.lunarTransits : lunarTransits // ignore: cast_nullable_to_non_nullable
as bool,sabbatAlerts: null == sabbatAlerts ? _self.sabbatAlerts : sabbatAlerts // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
