// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tarot_lens_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TarotLensState {

 bool get isScanning; String? get capturedImagePath; TarotLensScanResult? get scanResult; String? get errorMessage;
/// Create a copy of TarotLensState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TarotLensStateCopyWith<TarotLensState> get copyWith => _$TarotLensStateCopyWithImpl<TarotLensState>(this as TarotLensState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TarotLensState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TarotLensState&&(identical(other.isScanning, _this.isScanning) || other.isScanning == _this.isScanning)&&(identical(other.capturedImagePath, _this.capturedImagePath) || other.capturedImagePath == _this.capturedImagePath)&&(identical(other.scanResult, _this.scanResult) || other.scanResult == _this.scanResult)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as TarotLensState;
  return Object.hash(runtimeType,_this.isScanning,_this.capturedImagePath,_this.scanResult,_this.errorMessage);
}

@override
String toString() {
  final _this = this as TarotLensState;
  return 'TarotLensState(isScanning: ${_this.isScanning}, capturedImagePath: ${_this.capturedImagePath}, scanResult: ${_this.scanResult}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $TarotLensStateCopyWith<$Res>  {
  factory $TarotLensStateCopyWith(TarotLensState value, $Res Function(TarotLensState) _then) = _$TarotLensStateCopyWithImpl;
@useResult
$Res call({
 bool isScanning, String? capturedImagePath, TarotLensScanResult? scanResult, String? errorMessage
});


$TarotLensScanResultCopyWith<$Res>? get scanResult;

}
/// @nodoc
class _$TarotLensStateCopyWithImpl<$Res>
    implements $TarotLensStateCopyWith<$Res> {
  _$TarotLensStateCopyWithImpl(this._self, this._then);

  final TarotLensState _self;
  final $Res Function(TarotLensState) _then;

/// Create a copy of TarotLensState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isScanning = null,Object? capturedImagePath = freezed,Object? scanResult = freezed,Object? errorMessage = freezed,}) {
  return _then(TarotLensState(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,capturedImagePath: freezed == capturedImagePath ? _self.capturedImagePath : capturedImagePath // ignore: cast_nullable_to_non_nullable
as String?,scanResult: freezed == scanResult ? _self.scanResult : scanResult // ignore: cast_nullable_to_non_nullable
as TarotLensScanResult?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TarotLensState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotLensScanResultCopyWith<$Res>? get scanResult {
    if (_self.scanResult == null) {
    return null;
  }

  return $TarotLensScanResultCopyWith<$Res>(_self.scanResult!, (value) {
    return _then(_self.copyWith(scanResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [TarotLensState].
extension TarotLensStatePatterns on TarotLensState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TarotLensState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TarotLensState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TarotLensState value)  $default,){
final _that = this;
switch (_that) {
case _TarotLensState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TarotLensState value)?  $default,){
final _that = this;
switch (_that) {
case _TarotLensState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isScanning,  String? capturedImagePath,  TarotLensScanResult? scanResult,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TarotLensState() when $default != null:
return $default(_that.isScanning,_that.capturedImagePath,_that.scanResult,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isScanning,  String? capturedImagePath,  TarotLensScanResult? scanResult,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TarotLensState():
return $default(_that.isScanning,_that.capturedImagePath,_that.scanResult,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isScanning,  String? capturedImagePath,  TarotLensScanResult? scanResult,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TarotLensState() when $default != null:
return $default(_that.isScanning,_that.capturedImagePath,_that.scanResult,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TarotLensState implements TarotLensState {
  const _TarotLensState({this.isScanning = false, this.capturedImagePath, this.scanResult, this.errorMessage});
  

@override@JsonKey() final  bool isScanning;
@override final  String? capturedImagePath;
@override final  TarotLensScanResult? scanResult;
@override final  String? errorMessage;

/// Create a copy of TarotLensState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TarotLensStateCopyWith<_TarotLensState> get copyWith => __$TarotLensStateCopyWithImpl<_TarotLensState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TarotLensState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.capturedImagePath, capturedImagePath) || other.capturedImagePath == capturedImagePath)&&(identical(other.scanResult, scanResult) || other.scanResult == scanResult)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isScanning,capturedImagePath,scanResult,errorMessage);
}

@override
String toString() {
    return 'TarotLensState(isScanning: $isScanning, capturedImagePath: $capturedImagePath, scanResult: $scanResult, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TarotLensStateCopyWith<$Res> implements $TarotLensStateCopyWith<$Res> {
  factory _$TarotLensStateCopyWith(_TarotLensState value, $Res Function(_TarotLensState) _then) = __$TarotLensStateCopyWithImpl;
@override @useResult
$Res call({
 bool isScanning, String? capturedImagePath, TarotLensScanResult? scanResult, String? errorMessage
});


@override $TarotLensScanResultCopyWith<$Res>? get scanResult;

}
/// @nodoc
class __$TarotLensStateCopyWithImpl<$Res>
    implements _$TarotLensStateCopyWith<$Res> {
  __$TarotLensStateCopyWithImpl(this._self, this._then);

  final _TarotLensState _self;
  final $Res Function(_TarotLensState) _then;

/// Create a copy of TarotLensState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isScanning = null,Object? capturedImagePath = freezed,Object? scanResult = freezed,Object? errorMessage = freezed,}) {
  return _then(_TarotLensState(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,capturedImagePath: freezed == capturedImagePath ? _self.capturedImagePath : capturedImagePath // ignore: cast_nullable_to_non_nullable
as String?,scanResult: freezed == scanResult ? _self.scanResult : scanResult // ignore: cast_nullable_to_non_nullable
as TarotLensScanResult?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TarotLensState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotLensScanResultCopyWith<$Res>? get scanResult {
    if (_self.scanResult == null) {
    return null;
  }

  return $TarotLensScanResultCopyWith<$Res>(_self.scanResult!, (value) {
    return _then(_self.copyWith(scanResult: value));
  });
}
}

// dart format on
