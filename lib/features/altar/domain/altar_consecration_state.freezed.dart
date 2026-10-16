// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'altar_consecration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AltarConsecrationState {

 SacredHerb get activeHerb; bool get isPurified; double get purificationProgress; Map<String, String> get placedCrystals; DateTime? get lastPurifiedAt;
/// Create a copy of AltarConsecrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AltarConsecrationStateCopyWith<AltarConsecrationState> get copyWith => _$AltarConsecrationStateCopyWithImpl<AltarConsecrationState>(this as AltarConsecrationState, _$identity);

  /// Serializes this AltarConsecrationState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AltarConsecrationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AltarConsecrationState&&(identical(other.activeHerb, _this.activeHerb) || other.activeHerb == _this.activeHerb)&&(identical(other.isPurified, _this.isPurified) || other.isPurified == _this.isPurified)&&(identical(other.purificationProgress, _this.purificationProgress) || other.purificationProgress == _this.purificationProgress)&&const DeepCollectionEquality().equals(other.placedCrystals, _this.placedCrystals)&&(identical(other.lastPurifiedAt, _this.lastPurifiedAt) || other.lastPurifiedAt == _this.lastPurifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AltarConsecrationState;
  return Object.hash(runtimeType,_this.activeHerb,_this.isPurified,_this.purificationProgress,const DeepCollectionEquality().hash(_this.placedCrystals),_this.lastPurifiedAt);
}

@override
String toString() {
  final _this = this as AltarConsecrationState;
  return 'AltarConsecrationState(activeHerb: ${_this.activeHerb}, isPurified: ${_this.isPurified}, purificationProgress: ${_this.purificationProgress}, placedCrystals: ${_this.placedCrystals}, lastPurifiedAt: ${_this.lastPurifiedAt})';
}


}

/// @nodoc
abstract mixin class $AltarConsecrationStateCopyWith<$Res>  {
  factory $AltarConsecrationStateCopyWith(AltarConsecrationState value, $Res Function(AltarConsecrationState) _then) = _$AltarConsecrationStateCopyWithImpl;
@useResult
$Res call({
 SacredHerb activeHerb, bool isPurified, double purificationProgress, Map<String, String> placedCrystals, DateTime? lastPurifiedAt
});




}
/// @nodoc
class _$AltarConsecrationStateCopyWithImpl<$Res>
    implements $AltarConsecrationStateCopyWith<$Res> {
  _$AltarConsecrationStateCopyWithImpl(this._self, this._then);

  final AltarConsecrationState _self;
  final $Res Function(AltarConsecrationState) _then;

/// Create a copy of AltarConsecrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeHerb = null,Object? isPurified = null,Object? purificationProgress = null,Object? placedCrystals = null,Object? lastPurifiedAt = freezed,}) {
  return _then(AltarConsecrationState(
activeHerb: null == activeHerb ? _self.activeHerb : activeHerb // ignore: cast_nullable_to_non_nullable
as SacredHerb,isPurified: null == isPurified ? _self.isPurified : isPurified // ignore: cast_nullable_to_non_nullable
as bool,purificationProgress: null == purificationProgress ? _self.purificationProgress : purificationProgress // ignore: cast_nullable_to_non_nullable
as double,placedCrystals: null == placedCrystals ? _self.placedCrystals : placedCrystals // ignore: cast_nullable_to_non_nullable
as Map<String, String>,lastPurifiedAt: freezed == lastPurifiedAt ? _self.lastPurifiedAt : lastPurifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AltarConsecrationState].
extension AltarConsecrationStatePatterns on AltarConsecrationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AltarConsecrationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AltarConsecrationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AltarConsecrationState value)  $default,){
final _that = this;
switch (_that) {
case _AltarConsecrationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AltarConsecrationState value)?  $default,){
final _that = this;
switch (_that) {
case _AltarConsecrationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SacredHerb activeHerb,  bool isPurified,  double purificationProgress,  Map<String, String> placedCrystals,  DateTime? lastPurifiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AltarConsecrationState() when $default != null:
return $default(_that.activeHerb,_that.isPurified,_that.purificationProgress,_that.placedCrystals,_that.lastPurifiedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SacredHerb activeHerb,  bool isPurified,  double purificationProgress,  Map<String, String> placedCrystals,  DateTime? lastPurifiedAt)  $default,) {final _that = this;
switch (_that) {
case _AltarConsecrationState():
return $default(_that.activeHerb,_that.isPurified,_that.purificationProgress,_that.placedCrystals,_that.lastPurifiedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SacredHerb activeHerb,  bool isPurified,  double purificationProgress,  Map<String, String> placedCrystals,  DateTime? lastPurifiedAt)?  $default,) {final _that = this;
switch (_that) {
case _AltarConsecrationState() when $default != null:
return $default(_that.activeHerb,_that.isPurified,_that.purificationProgress,_that.placedCrystals,_that.lastPurifiedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AltarConsecrationState extends AltarConsecrationState {
  const _AltarConsecrationState({this.activeHerb = SacredHerb.paloSanto, this.isPurified = false, this.purificationProgress = 0.0,  Map<String, String> placedCrystals = const {'topLeft' : 'clear_quartz', 'topRight' : 'amethyst', 'bottomLeft' : 'black_tourmaline', 'bottomRight' : 'citrine'}, this.lastPurifiedAt}): _placedCrystals = placedCrystals,super._();
  factory _AltarConsecrationState.fromJson(Map<String, dynamic> json) => _$AltarConsecrationStateFromJson(json);

@override@JsonKey() final  SacredHerb activeHerb;
@override@JsonKey() final  bool isPurified;
@override@JsonKey() final  double purificationProgress;
 final  Map<String, String> _placedCrystals;
@override@JsonKey() Map<String, String> get placedCrystals {
  if (_placedCrystals is EqualUnmodifiableMapView) return _placedCrystals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_placedCrystals);
}

@override final  DateTime? lastPurifiedAt;

/// Create a copy of AltarConsecrationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AltarConsecrationStateCopyWith<_AltarConsecrationState> get copyWith => __$AltarConsecrationStateCopyWithImpl<_AltarConsecrationState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AltarConsecrationStateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AltarConsecrationState&&(identical(other.activeHerb, activeHerb) || other.activeHerb == activeHerb)&&(identical(other.isPurified, isPurified) || other.isPurified == isPurified)&&(identical(other.purificationProgress, purificationProgress) || other.purificationProgress == purificationProgress)&&const DeepCollectionEquality().equals(other.placedCrystals, _placedCrystals)&&(identical(other.lastPurifiedAt, lastPurifiedAt) || other.lastPurifiedAt == lastPurifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activeHerb,isPurified,purificationProgress,const DeepCollectionEquality().hash(_placedCrystals),lastPurifiedAt);
}

@override
String toString() {
    return 'AltarConsecrationState(activeHerb: $activeHerb, isPurified: $isPurified, purificationProgress: $purificationProgress, placedCrystals: $placedCrystals, lastPurifiedAt: $lastPurifiedAt)';
}


}

/// @nodoc
abstract mixin class _$AltarConsecrationStateCopyWith<$Res> implements $AltarConsecrationStateCopyWith<$Res> {
  factory _$AltarConsecrationStateCopyWith(_AltarConsecrationState value, $Res Function(_AltarConsecrationState) _then) = __$AltarConsecrationStateCopyWithImpl;
@override @useResult
$Res call({
 SacredHerb activeHerb, bool isPurified, double purificationProgress, Map<String, String> placedCrystals, DateTime? lastPurifiedAt
});




}
/// @nodoc
class __$AltarConsecrationStateCopyWithImpl<$Res>
    implements _$AltarConsecrationStateCopyWith<$Res> {
  __$AltarConsecrationStateCopyWithImpl(this._self, this._then);

  final _AltarConsecrationState _self;
  final $Res Function(_AltarConsecrationState) _then;

/// Create a copy of AltarConsecrationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeHerb = null,Object? isPurified = null,Object? purificationProgress = null,Object? placedCrystals = null,Object? lastPurifiedAt = freezed,}) {
  return _then(_AltarConsecrationState(
activeHerb: null == activeHerb ? _self.activeHerb : activeHerb // ignore: cast_nullable_to_non_nullable
as SacredHerb,isPurified: null == isPurified ? _self.isPurified : isPurified // ignore: cast_nullable_to_non_nullable
as bool,purificationProgress: null == purificationProgress ? _self.purificationProgress : purificationProgress // ignore: cast_nullable_to_non_nullable
as double,placedCrystals: null == placedCrystals ? _self._placedCrystals : placedCrystals // ignore: cast_nullable_to_non_nullable
as Map<String, String>,lastPurifiedAt: freezed == lastPurifiedAt ? _self.lastPurifiedAt : lastPurifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
