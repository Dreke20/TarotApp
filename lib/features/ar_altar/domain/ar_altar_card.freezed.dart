// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ar_altar_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArAltarCard {

 String get id; TarotCard get card; int get slotIndex; String get positionName; DateTime get placedAt; bool get isRevealed;
/// Create a copy of ArAltarCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArAltarCardCopyWith<ArAltarCard> get copyWith => _$ArAltarCardCopyWithImpl<ArAltarCard>(this as ArAltarCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ArAltarCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArAltarCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.card, _this.card) || other.card == _this.card)&&(identical(other.slotIndex, _this.slotIndex) || other.slotIndex == _this.slotIndex)&&(identical(other.positionName, _this.positionName) || other.positionName == _this.positionName)&&(identical(other.placedAt, _this.placedAt) || other.placedAt == _this.placedAt)&&(identical(other.isRevealed, _this.isRevealed) || other.isRevealed == _this.isRevealed));
}


@override
int get hashCode {
  final _this = this as ArAltarCard;
  return Object.hash(runtimeType,_this.id,_this.card,_this.slotIndex,_this.positionName,_this.placedAt,_this.isRevealed);
}

@override
String toString() {
  final _this = this as ArAltarCard;
  return 'ArAltarCard(id: ${_this.id}, card: ${_this.card}, slotIndex: ${_this.slotIndex}, positionName: ${_this.positionName}, placedAt: ${_this.placedAt}, isRevealed: ${_this.isRevealed})';
}


}

/// @nodoc
abstract mixin class $ArAltarCardCopyWith<$Res>  {
  factory $ArAltarCardCopyWith(ArAltarCard value, $Res Function(ArAltarCard) _then) = _$ArAltarCardCopyWithImpl;
@useResult
$Res call({
 String id, TarotCard card, int slotIndex, String positionName, DateTime placedAt, bool isRevealed
});


$TarotCardCopyWith<$Res> get card;

}
/// @nodoc
class _$ArAltarCardCopyWithImpl<$Res>
    implements $ArAltarCardCopyWith<$Res> {
  _$ArAltarCardCopyWithImpl(this._self, this._then);

  final ArAltarCard _self;
  final $Res Function(ArAltarCard) _then;

/// Create a copy of ArAltarCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? card = null,Object? slotIndex = null,Object? positionName = null,Object? placedAt = null,Object? isRevealed = null,}) {
  return _then(ArAltarCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as TarotCard,slotIndex: null == slotIndex ? _self.slotIndex : slotIndex // ignore: cast_nullable_to_non_nullable
as int,positionName: null == positionName ? _self.positionName : positionName // ignore: cast_nullable_to_non_nullable
as String,placedAt: null == placedAt ? _self.placedAt : placedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRevealed: null == isRevealed ? _self.isRevealed : isRevealed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ArAltarCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotCardCopyWith<$Res> get card {
  
  return $TarotCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArAltarCard].
extension ArAltarCardPatterns on ArAltarCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArAltarCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArAltarCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArAltarCard value)  $default,){
final _that = this;
switch (_that) {
case _ArAltarCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArAltarCard value)?  $default,){
final _that = this;
switch (_that) {
case _ArAltarCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TarotCard card,  int slotIndex,  String positionName,  DateTime placedAt,  bool isRevealed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArAltarCard() when $default != null:
return $default(_that.id,_that.card,_that.slotIndex,_that.positionName,_that.placedAt,_that.isRevealed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TarotCard card,  int slotIndex,  String positionName,  DateTime placedAt,  bool isRevealed)  $default,) {final _that = this;
switch (_that) {
case _ArAltarCard():
return $default(_that.id,_that.card,_that.slotIndex,_that.positionName,_that.placedAt,_that.isRevealed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TarotCard card,  int slotIndex,  String positionName,  DateTime placedAt,  bool isRevealed)?  $default,) {final _that = this;
switch (_that) {
case _ArAltarCard() when $default != null:
return $default(_that.id,_that.card,_that.slotIndex,_that.positionName,_that.placedAt,_that.isRevealed);case _:
  return null;

}
}

}

/// @nodoc


class _ArAltarCard implements ArAltarCard {
  const _ArAltarCard({required this.id, required this.card, required this.slotIndex, required this.positionName, required this.placedAt, this.isRevealed = false});
  

@override final  String id;
@override final  TarotCard card;
@override final  int slotIndex;
@override final  String positionName;
@override final  DateTime placedAt;
@override@JsonKey() final  bool isRevealed;

/// Create a copy of ArAltarCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArAltarCardCopyWith<_ArAltarCard> get copyWith => __$ArAltarCardCopyWithImpl<_ArAltarCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArAltarCard&&(identical(other.id, id) || other.id == id)&&(identical(other.card, card) || other.card == card)&&(identical(other.slotIndex, slotIndex) || other.slotIndex == slotIndex)&&(identical(other.positionName, positionName) || other.positionName == positionName)&&(identical(other.placedAt, placedAt) || other.placedAt == placedAt)&&(identical(other.isRevealed, isRevealed) || other.isRevealed == isRevealed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,card,slotIndex,positionName,placedAt,isRevealed);
}

@override
String toString() {
    return 'ArAltarCard(id: $id, card: $card, slotIndex: $slotIndex, positionName: $positionName, placedAt: $placedAt, isRevealed: $isRevealed)';
}


}

/// @nodoc
abstract mixin class _$ArAltarCardCopyWith<$Res> implements $ArAltarCardCopyWith<$Res> {
  factory _$ArAltarCardCopyWith(_ArAltarCard value, $Res Function(_ArAltarCard) _then) = __$ArAltarCardCopyWithImpl;
@override @useResult
$Res call({
 String id, TarotCard card, int slotIndex, String positionName, DateTime placedAt, bool isRevealed
});


@override $TarotCardCopyWith<$Res> get card;

}
/// @nodoc
class __$ArAltarCardCopyWithImpl<$Res>
    implements _$ArAltarCardCopyWith<$Res> {
  __$ArAltarCardCopyWithImpl(this._self, this._then);

  final _ArAltarCard _self;
  final $Res Function(_ArAltarCard) _then;

/// Create a copy of ArAltarCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? card = null,Object? slotIndex = null,Object? positionName = null,Object? placedAt = null,Object? isRevealed = null,}) {
  return _then(_ArAltarCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as TarotCard,slotIndex: null == slotIndex ? _self.slotIndex : slotIndex // ignore: cast_nullable_to_non_nullable
as int,positionName: null == positionName ? _self.positionName : positionName // ignore: cast_nullable_to_non_nullable
as String,placedAt: null == placedAt ? _self.placedAt : placedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRevealed: null == isRevealed ? _self.isRevealed : isRevealed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ArAltarCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotCardCopyWith<$Res> get card {
  
  return $TarotCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}

/// @nodoc
mixin _$ArPose {

 double get yaw; double get pitch;
/// Create a copy of ArPose
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArPoseCopyWith<ArPose> get copyWith => _$ArPoseCopyWithImpl<ArPose>(this as ArPose, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ArPose;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArPose&&(identical(other.yaw, _this.yaw) || other.yaw == _this.yaw)&&(identical(other.pitch, _this.pitch) || other.pitch == _this.pitch));
}


@override
int get hashCode {
  final _this = this as ArPose;
  return Object.hash(runtimeType,_this.yaw,_this.pitch);
}

@override
String toString() {
  final _this = this as ArPose;
  return 'ArPose(yaw: ${_this.yaw}, pitch: ${_this.pitch})';
}


}

/// @nodoc
abstract mixin class $ArPoseCopyWith<$Res>  {
  factory $ArPoseCopyWith(ArPose value, $Res Function(ArPose) _then) = _$ArPoseCopyWithImpl;
@useResult
$Res call({
 double yaw, double pitch
});




}
/// @nodoc
class _$ArPoseCopyWithImpl<$Res>
    implements $ArPoseCopyWith<$Res> {
  _$ArPoseCopyWithImpl(this._self, this._then);

  final ArPose _self;
  final $Res Function(ArPose) _then;

/// Create a copy of ArPose
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? yaw = null,Object? pitch = null,}) {
  return _then(ArPose(
yaw: null == yaw ? _self.yaw : yaw // ignore: cast_nullable_to_non_nullable
as double,pitch: null == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ArPose].
extension ArPosePatterns on ArPose {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArPose value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArPose() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArPose value)  $default,){
final _that = this;
switch (_that) {
case _ArPose():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArPose value)?  $default,){
final _that = this;
switch (_that) {
case _ArPose() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double yaw,  double pitch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArPose() when $default != null:
return $default(_that.yaw,_that.pitch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double yaw,  double pitch)  $default,) {final _that = this;
switch (_that) {
case _ArPose():
return $default(_that.yaw,_that.pitch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double yaw,  double pitch)?  $default,) {final _that = this;
switch (_that) {
case _ArPose() when $default != null:
return $default(_that.yaw,_that.pitch);case _:
  return null;

}
}

}

/// @nodoc


class _ArPose implements ArPose {
  const _ArPose({this.yaw = 0.0, this.pitch = 0.0});
  

@override@JsonKey() final  double yaw;
@override@JsonKey() final  double pitch;

/// Create a copy of ArPose
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArPoseCopyWith<_ArPose> get copyWith => __$ArPoseCopyWithImpl<_ArPose>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArPose&&(identical(other.yaw, yaw) || other.yaw == yaw)&&(identical(other.pitch, pitch) || other.pitch == pitch));
}


@override
int get hashCode {
    return Object.hash(runtimeType,yaw,pitch);
}

@override
String toString() {
    return 'ArPose(yaw: $yaw, pitch: $pitch)';
}


}

/// @nodoc
abstract mixin class _$ArPoseCopyWith<$Res> implements $ArPoseCopyWith<$Res> {
  factory _$ArPoseCopyWith(_ArPose value, $Res Function(_ArPose) _then) = __$ArPoseCopyWithImpl;
@override @useResult
$Res call({
 double yaw, double pitch
});




}
/// @nodoc
class __$ArPoseCopyWithImpl<$Res>
    implements _$ArPoseCopyWith<$Res> {
  __$ArPoseCopyWithImpl(this._self, this._then);

  final _ArPose _self;
  final $Res Function(_ArPose) _then;

/// Create a copy of ArPose
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? yaw = null,Object? pitch = null,}) {
  return _then(_ArPose(
yaw: null == yaw ? _self.yaw : yaw // ignore: cast_nullable_to_non_nullable
as double,pitch: null == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
