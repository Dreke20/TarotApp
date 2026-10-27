// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oracle_dialogue_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OracleDialogueReply {

 String get text; TarotCard? get drawnCard; bool get isOfflineFallback;
/// Create a copy of OracleDialogueReply
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OracleDialogueReplyCopyWith<OracleDialogueReply> get copyWith => _$OracleDialogueReplyCopyWithImpl<OracleDialogueReply>(this as OracleDialogueReply, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OracleDialogueReply;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OracleDialogueReply&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.drawnCard, _this.drawnCard) || other.drawnCard == _this.drawnCard)&&(identical(other.isOfflineFallback, _this.isOfflineFallback) || other.isOfflineFallback == _this.isOfflineFallback));
}


@override
int get hashCode {
  final _this = this as OracleDialogueReply;
  return Object.hash(runtimeType,_this.text,_this.drawnCard,_this.isOfflineFallback);
}

@override
String toString() {
  final _this = this as OracleDialogueReply;
  return 'OracleDialogueReply(text: ${_this.text}, drawnCard: ${_this.drawnCard}, isOfflineFallback: ${_this.isOfflineFallback})';
}


}

/// @nodoc
abstract mixin class $OracleDialogueReplyCopyWith<$Res>  {
  factory $OracleDialogueReplyCopyWith(OracleDialogueReply value, $Res Function(OracleDialogueReply) _then) = _$OracleDialogueReplyCopyWithImpl;
@useResult
$Res call({
 String text, TarotCard? drawnCard, bool isOfflineFallback
});


$TarotCardCopyWith<$Res>? get drawnCard;

}
/// @nodoc
class _$OracleDialogueReplyCopyWithImpl<$Res>
    implements $OracleDialogueReplyCopyWith<$Res> {
  _$OracleDialogueReplyCopyWithImpl(this._self, this._then);

  final OracleDialogueReply _self;
  final $Res Function(OracleDialogueReply) _then;

/// Create a copy of OracleDialogueReply
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? drawnCard = freezed,Object? isOfflineFallback = null,}) {
  return _then(OracleDialogueReply(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,drawnCard: freezed == drawnCard ? _self.drawnCard : drawnCard // ignore: cast_nullable_to_non_nullable
as TarotCard?,isOfflineFallback: null == isOfflineFallback ? _self.isOfflineFallback : isOfflineFallback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of OracleDialogueReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotCardCopyWith<$Res>? get drawnCard {
    if (_self.drawnCard == null) {
    return null;
  }

  return $TarotCardCopyWith<$Res>(_self.drawnCard!, (value) {
    return _then(_self.copyWith(drawnCard: value));
  });
}
}


/// Adds pattern-matching-related methods to [OracleDialogueReply].
extension OracleDialogueReplyPatterns on OracleDialogueReply {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OracleDialogueReply value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OracleDialogueReply() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OracleDialogueReply value)  $default,){
final _that = this;
switch (_that) {
case _OracleDialogueReply():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OracleDialogueReply value)?  $default,){
final _that = this;
switch (_that) {
case _OracleDialogueReply() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  TarotCard? drawnCard,  bool isOfflineFallback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OracleDialogueReply() when $default != null:
return $default(_that.text,_that.drawnCard,_that.isOfflineFallback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  TarotCard? drawnCard,  bool isOfflineFallback)  $default,) {final _that = this;
switch (_that) {
case _OracleDialogueReply():
return $default(_that.text,_that.drawnCard,_that.isOfflineFallback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  TarotCard? drawnCard,  bool isOfflineFallback)?  $default,) {final _that = this;
switch (_that) {
case _OracleDialogueReply() when $default != null:
return $default(_that.text,_that.drawnCard,_that.isOfflineFallback);case _:
  return null;

}
}

}

/// @nodoc


class _OracleDialogueReply implements OracleDialogueReply {
  const _OracleDialogueReply({required this.text, this.drawnCard, this.isOfflineFallback = false});
  

@override final  String text;
@override final  TarotCard? drawnCard;
@override@JsonKey() final  bool isOfflineFallback;

/// Create a copy of OracleDialogueReply
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OracleDialogueReplyCopyWith<_OracleDialogueReply> get copyWith => __$OracleDialogueReplyCopyWithImpl<_OracleDialogueReply>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OracleDialogueReply&&(identical(other.text, text) || other.text == text)&&(identical(other.drawnCard, drawnCard) || other.drawnCard == drawnCard)&&(identical(other.isOfflineFallback, isOfflineFallback) || other.isOfflineFallback == isOfflineFallback));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text,drawnCard,isOfflineFallback);
}

@override
String toString() {
    return 'OracleDialogueReply(text: $text, drawnCard: $drawnCard, isOfflineFallback: $isOfflineFallback)';
}


}

/// @nodoc
abstract mixin class _$OracleDialogueReplyCopyWith<$Res> implements $OracleDialogueReplyCopyWith<$Res> {
  factory _$OracleDialogueReplyCopyWith(_OracleDialogueReply value, $Res Function(_OracleDialogueReply) _then) = __$OracleDialogueReplyCopyWithImpl;
@override @useResult
$Res call({
 String text, TarotCard? drawnCard, bool isOfflineFallback
});


@override $TarotCardCopyWith<$Res>? get drawnCard;

}
/// @nodoc
class __$OracleDialogueReplyCopyWithImpl<$Res>
    implements _$OracleDialogueReplyCopyWith<$Res> {
  __$OracleDialogueReplyCopyWithImpl(this._self, this._then);

  final _OracleDialogueReply _self;
  final $Res Function(_OracleDialogueReply) _then;

/// Create a copy of OracleDialogueReply
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? drawnCard = freezed,Object? isOfflineFallback = null,}) {
  return _then(_OracleDialogueReply(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,drawnCard: freezed == drawnCard ? _self.drawnCard : drawnCard // ignore: cast_nullable_to_non_nullable
as TarotCard?,isOfflineFallback: null == isOfflineFallback ? _self.isOfflineFallback : isOfflineFallback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of OracleDialogueReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotCardCopyWith<$Res>? get drawnCard {
    if (_self.drawnCard == null) {
    return null;
  }

  return $TarotCardCopyWith<$Res>(_self.drawnCard!, (value) {
    return _then(_self.copyWith(drawnCard: value));
  });
}
}

// dart format on
