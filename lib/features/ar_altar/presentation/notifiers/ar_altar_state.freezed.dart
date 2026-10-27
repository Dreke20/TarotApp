// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ar_altar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArAltarState {

 List<ArAltarCard> get cards; ArSpread get spread; bool get isMandalaAnchored; bool get isDealing; bool get isCameraReady; bool get isCameraStarting; String? get cameraError; String? get selectedCardId;
/// Create a copy of ArAltarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArAltarStateCopyWith<ArAltarState> get copyWith => _$ArAltarStateCopyWithImpl<ArAltarState>(this as ArAltarState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ArAltarState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArAltarState&&const DeepCollectionEquality().equals(other.cards, _this.cards)&&(identical(other.spread, _this.spread) || other.spread == _this.spread)&&(identical(other.isMandalaAnchored, _this.isMandalaAnchored) || other.isMandalaAnchored == _this.isMandalaAnchored)&&(identical(other.isDealing, _this.isDealing) || other.isDealing == _this.isDealing)&&(identical(other.isCameraReady, _this.isCameraReady) || other.isCameraReady == _this.isCameraReady)&&(identical(other.isCameraStarting, _this.isCameraStarting) || other.isCameraStarting == _this.isCameraStarting)&&(identical(other.cameraError, _this.cameraError) || other.cameraError == _this.cameraError)&&(identical(other.selectedCardId, _this.selectedCardId) || other.selectedCardId == _this.selectedCardId));
}


@override
int get hashCode {
  final _this = this as ArAltarState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.cards),_this.spread,_this.isMandalaAnchored,_this.isDealing,_this.isCameraReady,_this.isCameraStarting,_this.cameraError,_this.selectedCardId);
}

@override
String toString() {
  final _this = this as ArAltarState;
  return 'ArAltarState(cards: ${_this.cards}, spread: ${_this.spread}, isMandalaAnchored: ${_this.isMandalaAnchored}, isDealing: ${_this.isDealing}, isCameraReady: ${_this.isCameraReady}, isCameraStarting: ${_this.isCameraStarting}, cameraError: ${_this.cameraError}, selectedCardId: ${_this.selectedCardId})';
}


}

/// @nodoc
abstract mixin class $ArAltarStateCopyWith<$Res>  {
  factory $ArAltarStateCopyWith(ArAltarState value, $Res Function(ArAltarState) _then) = _$ArAltarStateCopyWithImpl;
@useResult
$Res call({
 List<ArAltarCard> cards, ArSpread spread, bool isMandalaAnchored, bool isDealing, bool isCameraReady, bool isCameraStarting, String? cameraError, String? selectedCardId
});




}
/// @nodoc
class _$ArAltarStateCopyWithImpl<$Res>
    implements $ArAltarStateCopyWith<$Res> {
  _$ArAltarStateCopyWithImpl(this._self, this._then);

  final ArAltarState _self;
  final $Res Function(ArAltarState) _then;

/// Create a copy of ArAltarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cards = null,Object? spread = null,Object? isMandalaAnchored = null,Object? isDealing = null,Object? isCameraReady = null,Object? isCameraStarting = null,Object? cameraError = freezed,Object? selectedCardId = freezed,}) {
  return _then(ArAltarState(
cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<ArAltarCard>,spread: null == spread ? _self.spread : spread // ignore: cast_nullable_to_non_nullable
as ArSpread,isMandalaAnchored: null == isMandalaAnchored ? _self.isMandalaAnchored : isMandalaAnchored // ignore: cast_nullable_to_non_nullable
as bool,isDealing: null == isDealing ? _self.isDealing : isDealing // ignore: cast_nullable_to_non_nullable
as bool,isCameraReady: null == isCameraReady ? _self.isCameraReady : isCameraReady // ignore: cast_nullable_to_non_nullable
as bool,isCameraStarting: null == isCameraStarting ? _self.isCameraStarting : isCameraStarting // ignore: cast_nullable_to_non_nullable
as bool,cameraError: freezed == cameraError ? _self.cameraError : cameraError // ignore: cast_nullable_to_non_nullable
as String?,selectedCardId: freezed == selectedCardId ? _self.selectedCardId : selectedCardId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArAltarState].
extension ArAltarStatePatterns on ArAltarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArAltarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArAltarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArAltarState value)  $default,){
final _that = this;
switch (_that) {
case _ArAltarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArAltarState value)?  $default,){
final _that = this;
switch (_that) {
case _ArAltarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ArAltarCard> cards,  ArSpread spread,  bool isMandalaAnchored,  bool isDealing,  bool isCameraReady,  bool isCameraStarting,  String? cameraError,  String? selectedCardId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArAltarState() when $default != null:
return $default(_that.cards,_that.spread,_that.isMandalaAnchored,_that.isDealing,_that.isCameraReady,_that.isCameraStarting,_that.cameraError,_that.selectedCardId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ArAltarCard> cards,  ArSpread spread,  bool isMandalaAnchored,  bool isDealing,  bool isCameraReady,  bool isCameraStarting,  String? cameraError,  String? selectedCardId)  $default,) {final _that = this;
switch (_that) {
case _ArAltarState():
return $default(_that.cards,_that.spread,_that.isMandalaAnchored,_that.isDealing,_that.isCameraReady,_that.isCameraStarting,_that.cameraError,_that.selectedCardId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ArAltarCard> cards,  ArSpread spread,  bool isMandalaAnchored,  bool isDealing,  bool isCameraReady,  bool isCameraStarting,  String? cameraError,  String? selectedCardId)?  $default,) {final _that = this;
switch (_that) {
case _ArAltarState() when $default != null:
return $default(_that.cards,_that.spread,_that.isMandalaAnchored,_that.isDealing,_that.isCameraReady,_that.isCameraStarting,_that.cameraError,_that.selectedCardId);case _:
  return null;

}
}

}

/// @nodoc


class _ArAltarState extends ArAltarState {
  const _ArAltarState({ List<ArAltarCard> cards = const <ArAltarCard>[], this.spread = ArSpread.threeCard, this.isMandalaAnchored = false, this.isDealing = false, this.isCameraReady = false, this.isCameraStarting = false, this.cameraError, this.selectedCardId}): _cards = cards,super._();
  

 final  List<ArAltarCard> _cards;
@override@JsonKey() List<ArAltarCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override@JsonKey() final  ArSpread spread;
@override@JsonKey() final  bool isMandalaAnchored;
@override@JsonKey() final  bool isDealing;
@override@JsonKey() final  bool isCameraReady;
@override@JsonKey() final  bool isCameraStarting;
@override final  String? cameraError;
@override final  String? selectedCardId;

/// Create a copy of ArAltarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArAltarStateCopyWith<_ArAltarState> get copyWith => __$ArAltarStateCopyWithImpl<_ArAltarState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArAltarState&&const DeepCollectionEquality().equals(other.cards, _cards)&&(identical(other.spread, spread) || other.spread == spread)&&(identical(other.isMandalaAnchored, isMandalaAnchored) || other.isMandalaAnchored == isMandalaAnchored)&&(identical(other.isDealing, isDealing) || other.isDealing == isDealing)&&(identical(other.isCameraReady, isCameraReady) || other.isCameraReady == isCameraReady)&&(identical(other.isCameraStarting, isCameraStarting) || other.isCameraStarting == isCameraStarting)&&(identical(other.cameraError, cameraError) || other.cameraError == cameraError)&&(identical(other.selectedCardId, selectedCardId) || other.selectedCardId == selectedCardId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards),spread,isMandalaAnchored,isDealing,isCameraReady,isCameraStarting,cameraError,selectedCardId);
}

@override
String toString() {
    return 'ArAltarState(cards: $cards, spread: $spread, isMandalaAnchored: $isMandalaAnchored, isDealing: $isDealing, isCameraReady: $isCameraReady, isCameraStarting: $isCameraStarting, cameraError: $cameraError, selectedCardId: $selectedCardId)';
}


}

/// @nodoc
abstract mixin class _$ArAltarStateCopyWith<$Res> implements $ArAltarStateCopyWith<$Res> {
  factory _$ArAltarStateCopyWith(_ArAltarState value, $Res Function(_ArAltarState) _then) = __$ArAltarStateCopyWithImpl;
@override @useResult
$Res call({
 List<ArAltarCard> cards, ArSpread spread, bool isMandalaAnchored, bool isDealing, bool isCameraReady, bool isCameraStarting, String? cameraError, String? selectedCardId
});




}
/// @nodoc
class __$ArAltarStateCopyWithImpl<$Res>
    implements _$ArAltarStateCopyWith<$Res> {
  __$ArAltarStateCopyWithImpl(this._self, this._then);

  final _ArAltarState _self;
  final $Res Function(_ArAltarState) _then;

/// Create a copy of ArAltarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cards = null,Object? spread = null,Object? isMandalaAnchored = null,Object? isDealing = null,Object? isCameraReady = null,Object? isCameraStarting = null,Object? cameraError = freezed,Object? selectedCardId = freezed,}) {
  return _then(_ArAltarState(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<ArAltarCard>,spread: null == spread ? _self.spread : spread // ignore: cast_nullable_to_non_nullable
as ArSpread,isMandalaAnchored: null == isMandalaAnchored ? _self.isMandalaAnchored : isMandalaAnchored // ignore: cast_nullable_to_non_nullable
as bool,isDealing: null == isDealing ? _self.isDealing : isDealing // ignore: cast_nullable_to_non_nullable
as bool,isCameraReady: null == isCameraReady ? _self.isCameraReady : isCameraReady // ignore: cast_nullable_to_non_nullable
as bool,isCameraStarting: null == isCameraStarting ? _self.isCameraStarting : isCameraStarting // ignore: cast_nullable_to_non_nullable
as bool,cameraError: freezed == cameraError ? _self.cameraError : cameraError // ignore: cast_nullable_to_non_nullable
as String?,selectedCardId: freezed == selectedCardId ? _self.selectedCardId : selectedCardId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
