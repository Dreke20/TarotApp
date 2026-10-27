// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mystic_performance_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MysticPerformanceSettings {

 bool get isBatterySaverEnabled; int get maxParticleCount; bool get enableHolographicSensors; bool get enableGpuParticleDrift;
/// Create a copy of MysticPerformanceSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MysticPerformanceSettingsCopyWith<MysticPerformanceSettings> get copyWith => _$MysticPerformanceSettingsCopyWithImpl<MysticPerformanceSettings>(this as MysticPerformanceSettings, _$identity);

  /// Serializes this MysticPerformanceSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MysticPerformanceSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MysticPerformanceSettings&&(identical(other.isBatterySaverEnabled, _this.isBatterySaverEnabled) || other.isBatterySaverEnabled == _this.isBatterySaverEnabled)&&(identical(other.maxParticleCount, _this.maxParticleCount) || other.maxParticleCount == _this.maxParticleCount)&&(identical(other.enableHolographicSensors, _this.enableHolographicSensors) || other.enableHolographicSensors == _this.enableHolographicSensors)&&(identical(other.enableGpuParticleDrift, _this.enableGpuParticleDrift) || other.enableGpuParticleDrift == _this.enableGpuParticleDrift));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MysticPerformanceSettings;
  return Object.hash(runtimeType,_this.isBatterySaverEnabled,_this.maxParticleCount,_this.enableHolographicSensors,_this.enableGpuParticleDrift);
}

@override
String toString() {
  final _this = this as MysticPerformanceSettings;
  return 'MysticPerformanceSettings(isBatterySaverEnabled: ${_this.isBatterySaverEnabled}, maxParticleCount: ${_this.maxParticleCount}, enableHolographicSensors: ${_this.enableHolographicSensors}, enableGpuParticleDrift: ${_this.enableGpuParticleDrift})';
}


}

/// @nodoc
abstract mixin class $MysticPerformanceSettingsCopyWith<$Res>  {
  factory $MysticPerformanceSettingsCopyWith(MysticPerformanceSettings value, $Res Function(MysticPerformanceSettings) _then) = _$MysticPerformanceSettingsCopyWithImpl;
@useResult
$Res call({
 bool isBatterySaverEnabled, int maxParticleCount, bool enableHolographicSensors, bool enableGpuParticleDrift
});




}
/// @nodoc
class _$MysticPerformanceSettingsCopyWithImpl<$Res>
    implements $MysticPerformanceSettingsCopyWith<$Res> {
  _$MysticPerformanceSettingsCopyWithImpl(this._self, this._then);

  final MysticPerformanceSettings _self;
  final $Res Function(MysticPerformanceSettings) _then;

/// Create a copy of MysticPerformanceSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isBatterySaverEnabled = null,Object? maxParticleCount = null,Object? enableHolographicSensors = null,Object? enableGpuParticleDrift = null,}) {
  return _then(MysticPerformanceSettings(
isBatterySaverEnabled: null == isBatterySaverEnabled ? _self.isBatterySaverEnabled : isBatterySaverEnabled // ignore: cast_nullable_to_non_nullable
as bool,maxParticleCount: null == maxParticleCount ? _self.maxParticleCount : maxParticleCount // ignore: cast_nullable_to_non_nullable
as int,enableHolographicSensors: null == enableHolographicSensors ? _self.enableHolographicSensors : enableHolographicSensors // ignore: cast_nullable_to_non_nullable
as bool,enableGpuParticleDrift: null == enableGpuParticleDrift ? _self.enableGpuParticleDrift : enableGpuParticleDrift // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MysticPerformanceSettings].
extension MysticPerformanceSettingsPatterns on MysticPerformanceSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MysticPerformanceSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MysticPerformanceSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MysticPerformanceSettings value)  $default,){
final _that = this;
switch (_that) {
case _MysticPerformanceSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MysticPerformanceSettings value)?  $default,){
final _that = this;
switch (_that) {
case _MysticPerformanceSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isBatterySaverEnabled,  int maxParticleCount,  bool enableHolographicSensors,  bool enableGpuParticleDrift)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MysticPerformanceSettings() when $default != null:
return $default(_that.isBatterySaverEnabled,_that.maxParticleCount,_that.enableHolographicSensors,_that.enableGpuParticleDrift);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isBatterySaverEnabled,  int maxParticleCount,  bool enableHolographicSensors,  bool enableGpuParticleDrift)  $default,) {final _that = this;
switch (_that) {
case _MysticPerformanceSettings():
return $default(_that.isBatterySaverEnabled,_that.maxParticleCount,_that.enableHolographicSensors,_that.enableGpuParticleDrift);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isBatterySaverEnabled,  int maxParticleCount,  bool enableHolographicSensors,  bool enableGpuParticleDrift)?  $default,) {final _that = this;
switch (_that) {
case _MysticPerformanceSettings() when $default != null:
return $default(_that.isBatterySaverEnabled,_that.maxParticleCount,_that.enableHolographicSensors,_that.enableGpuParticleDrift);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MysticPerformanceSettings implements MysticPerformanceSettings {
  const _MysticPerformanceSettings({this.isBatterySaverEnabled = false, this.maxParticleCount = 60, this.enableHolographicSensors = true, this.enableGpuParticleDrift = true});
  factory _MysticPerformanceSettings.fromJson(Map<String, dynamic> json) => _$MysticPerformanceSettingsFromJson(json);

@override@JsonKey() final  bool isBatterySaverEnabled;
@override@JsonKey() final  int maxParticleCount;
@override@JsonKey() final  bool enableHolographicSensors;
@override@JsonKey() final  bool enableGpuParticleDrift;

/// Create a copy of MysticPerformanceSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MysticPerformanceSettingsCopyWith<_MysticPerformanceSettings> get copyWith => __$MysticPerformanceSettingsCopyWithImpl<_MysticPerformanceSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MysticPerformanceSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MysticPerformanceSettings&&(identical(other.isBatterySaverEnabled, isBatterySaverEnabled) || other.isBatterySaverEnabled == isBatterySaverEnabled)&&(identical(other.maxParticleCount, maxParticleCount) || other.maxParticleCount == maxParticleCount)&&(identical(other.enableHolographicSensors, enableHolographicSensors) || other.enableHolographicSensors == enableHolographicSensors)&&(identical(other.enableGpuParticleDrift, enableGpuParticleDrift) || other.enableGpuParticleDrift == enableGpuParticleDrift));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,isBatterySaverEnabled,maxParticleCount,enableHolographicSensors,enableGpuParticleDrift);
}

@override
String toString() {
    return 'MysticPerformanceSettings(isBatterySaverEnabled: $isBatterySaverEnabled, maxParticleCount: $maxParticleCount, enableHolographicSensors: $enableHolographicSensors, enableGpuParticleDrift: $enableGpuParticleDrift)';
}


}

/// @nodoc
abstract mixin class _$MysticPerformanceSettingsCopyWith<$Res> implements $MysticPerformanceSettingsCopyWith<$Res> {
  factory _$MysticPerformanceSettingsCopyWith(_MysticPerformanceSettings value, $Res Function(_MysticPerformanceSettings) _then) = __$MysticPerformanceSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool isBatterySaverEnabled, int maxParticleCount, bool enableHolographicSensors, bool enableGpuParticleDrift
});




}
/// @nodoc
class __$MysticPerformanceSettingsCopyWithImpl<$Res>
    implements _$MysticPerformanceSettingsCopyWith<$Res> {
  __$MysticPerformanceSettingsCopyWithImpl(this._self, this._then);

  final _MysticPerformanceSettings _self;
  final $Res Function(_MysticPerformanceSettings) _then;

/// Create a copy of MysticPerformanceSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isBatterySaverEnabled = null,Object? maxParticleCount = null,Object? enableHolographicSensors = null,Object? enableGpuParticleDrift = null,}) {
  return _then(_MysticPerformanceSettings(
isBatterySaverEnabled: null == isBatterySaverEnabled ? _self.isBatterySaverEnabled : isBatterySaverEnabled // ignore: cast_nullable_to_non_nullable
as bool,maxParticleCount: null == maxParticleCount ? _self.maxParticleCount : maxParticleCount // ignore: cast_nullable_to_non_nullable
as int,enableHolographicSensors: null == enableHolographicSensors ? _self.enableHolographicSensors : enableHolographicSensors // ignore: cast_nullable_to_non_nullable
as bool,enableGpuParticleDrift: null == enableGpuParticleDrift ? _self.enableGpuParticleDrift : enableGpuParticleDrift // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
