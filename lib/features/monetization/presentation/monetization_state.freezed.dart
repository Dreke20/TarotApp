// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monetization_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonetizationState {

 int get starlightPassTokens; int get totalOfferingsMade; bool get isOfferingInProgress; DateTime? get lastOfferingAt; String? get message;
/// Create a copy of MonetizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonetizationStateCopyWith<MonetizationState> get copyWith => _$MonetizationStateCopyWithImpl<MonetizationState>(this as MonetizationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MonetizationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonetizationState&&(identical(other.starlightPassTokens, _this.starlightPassTokens) || other.starlightPassTokens == _this.starlightPassTokens)&&(identical(other.totalOfferingsMade, _this.totalOfferingsMade) || other.totalOfferingsMade == _this.totalOfferingsMade)&&(identical(other.isOfferingInProgress, _this.isOfferingInProgress) || other.isOfferingInProgress == _this.isOfferingInProgress)&&(identical(other.lastOfferingAt, _this.lastOfferingAt) || other.lastOfferingAt == _this.lastOfferingAt)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as MonetizationState;
  return Object.hash(runtimeType,_this.starlightPassTokens,_this.totalOfferingsMade,_this.isOfferingInProgress,_this.lastOfferingAt,_this.message);
}

@override
String toString() {
  final _this = this as MonetizationState;
  return 'MonetizationState(starlightPassTokens: ${_this.starlightPassTokens}, totalOfferingsMade: ${_this.totalOfferingsMade}, isOfferingInProgress: ${_this.isOfferingInProgress}, lastOfferingAt: ${_this.lastOfferingAt}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $MonetizationStateCopyWith<$Res>  {
  factory $MonetizationStateCopyWith(MonetizationState value, $Res Function(MonetizationState) _then) = _$MonetizationStateCopyWithImpl;
@useResult
$Res call({
 int starlightPassTokens, int totalOfferingsMade, bool isOfferingInProgress, DateTime? lastOfferingAt, String? message
});




}
/// @nodoc
class _$MonetizationStateCopyWithImpl<$Res>
    implements $MonetizationStateCopyWith<$Res> {
  _$MonetizationStateCopyWithImpl(this._self, this._then);

  final MonetizationState _self;
  final $Res Function(MonetizationState) _then;

/// Create a copy of MonetizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? starlightPassTokens = null,Object? totalOfferingsMade = null,Object? isOfferingInProgress = null,Object? lastOfferingAt = freezed,Object? message = freezed,}) {
  return _then(MonetizationState(
starlightPassTokens: null == starlightPassTokens ? _self.starlightPassTokens : starlightPassTokens // ignore: cast_nullable_to_non_nullable
as int,totalOfferingsMade: null == totalOfferingsMade ? _self.totalOfferingsMade : totalOfferingsMade // ignore: cast_nullable_to_non_nullable
as int,isOfferingInProgress: null == isOfferingInProgress ? _self.isOfferingInProgress : isOfferingInProgress // ignore: cast_nullable_to_non_nullable
as bool,lastOfferingAt: freezed == lastOfferingAt ? _self.lastOfferingAt : lastOfferingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MonetizationState].
extension MonetizationStatePatterns on MonetizationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonetizationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonetizationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonetizationState value)  $default,){
final _that = this;
switch (_that) {
case _MonetizationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonetizationState value)?  $default,){
final _that = this;
switch (_that) {
case _MonetizationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int starlightPassTokens,  int totalOfferingsMade,  bool isOfferingInProgress,  DateTime? lastOfferingAt,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonetizationState() when $default != null:
return $default(_that.starlightPassTokens,_that.totalOfferingsMade,_that.isOfferingInProgress,_that.lastOfferingAt,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int starlightPassTokens,  int totalOfferingsMade,  bool isOfferingInProgress,  DateTime? lastOfferingAt,  String? message)  $default,) {final _that = this;
switch (_that) {
case _MonetizationState():
return $default(_that.starlightPassTokens,_that.totalOfferingsMade,_that.isOfferingInProgress,_that.lastOfferingAt,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int starlightPassTokens,  int totalOfferingsMade,  bool isOfferingInProgress,  DateTime? lastOfferingAt,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _MonetizationState() when $default != null:
return $default(_that.starlightPassTokens,_that.totalOfferingsMade,_that.isOfferingInProgress,_that.lastOfferingAt,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _MonetizationState extends MonetizationState {
  const _MonetizationState({this.starlightPassTokens = 0, this.totalOfferingsMade = 0, this.isOfferingInProgress = false, this.lastOfferingAt, this.message}): super._();
  

@override@JsonKey() final  int starlightPassTokens;
@override@JsonKey() final  int totalOfferingsMade;
@override@JsonKey() final  bool isOfferingInProgress;
@override final  DateTime? lastOfferingAt;
@override final  String? message;

/// Create a copy of MonetizationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonetizationStateCopyWith<_MonetizationState> get copyWith => __$MonetizationStateCopyWithImpl<_MonetizationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonetizationState&&(identical(other.starlightPassTokens, starlightPassTokens) || other.starlightPassTokens == starlightPassTokens)&&(identical(other.totalOfferingsMade, totalOfferingsMade) || other.totalOfferingsMade == totalOfferingsMade)&&(identical(other.isOfferingInProgress, isOfferingInProgress) || other.isOfferingInProgress == isOfferingInProgress)&&(identical(other.lastOfferingAt, lastOfferingAt) || other.lastOfferingAt == lastOfferingAt)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,starlightPassTokens,totalOfferingsMade,isOfferingInProgress,lastOfferingAt,message);
}

@override
String toString() {
    return 'MonetizationState(starlightPassTokens: $starlightPassTokens, totalOfferingsMade: $totalOfferingsMade, isOfferingInProgress: $isOfferingInProgress, lastOfferingAt: $lastOfferingAt, message: $message)';
}


}

/// @nodoc
abstract mixin class _$MonetizationStateCopyWith<$Res> implements $MonetizationStateCopyWith<$Res> {
  factory _$MonetizationStateCopyWith(_MonetizationState value, $Res Function(_MonetizationState) _then) = __$MonetizationStateCopyWithImpl;
@override @useResult
$Res call({
 int starlightPassTokens, int totalOfferingsMade, bool isOfferingInProgress, DateTime? lastOfferingAt, String? message
});




}
/// @nodoc
class __$MonetizationStateCopyWithImpl<$Res>
    implements _$MonetizationStateCopyWith<$Res> {
  __$MonetizationStateCopyWithImpl(this._self, this._then);

  final _MonetizationState _self;
  final $Res Function(_MonetizationState) _then;

/// Create a copy of MonetizationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? starlightPassTokens = null,Object? totalOfferingsMade = null,Object? isOfferingInProgress = null,Object? lastOfferingAt = freezed,Object? message = freezed,}) {
  return _then(_MonetizationState(
starlightPassTokens: null == starlightPassTokens ? _self.starlightPassTokens : starlightPassTokens // ignore: cast_nullable_to_non_nullable
as int,totalOfferingsMade: null == totalOfferingsMade ? _self.totalOfferingsMade : totalOfferingsMade // ignore: cast_nullable_to_non_nullable
as int,isOfferingInProgress: null == isOfferingInProgress ? _self.isOfferingInProgress : isOfferingInProgress // ignore: cast_nullable_to_non_nullable
as bool,lastOfferingAt: freezed == lastOfferingAt ? _self.lastOfferingAt : lastOfferingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
