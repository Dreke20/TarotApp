// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oracle_dialogue_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OracleDialogueMessage {

 String get id; DialogueSender get sender; String get text; DateTime get timestamp; TarotCard? get referencedCard; String? get personaId; bool get isSpoken;
/// Create a copy of OracleDialogueMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OracleDialogueMessageCopyWith<OracleDialogueMessage> get copyWith => _$OracleDialogueMessageCopyWithImpl<OracleDialogueMessage>(this as OracleDialogueMessage, _$identity);

  /// Serializes this OracleDialogueMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OracleDialogueMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OracleDialogueMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.referencedCard, _this.referencedCard) || other.referencedCard == _this.referencedCard)&&(identical(other.personaId, _this.personaId) || other.personaId == _this.personaId)&&(identical(other.isSpoken, _this.isSpoken) || other.isSpoken == _this.isSpoken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OracleDialogueMessage;
  return Object.hash(runtimeType,_this.id,_this.sender,_this.text,_this.timestamp,_this.referencedCard,_this.personaId,_this.isSpoken);
}

@override
String toString() {
  final _this = this as OracleDialogueMessage;
  return 'OracleDialogueMessage(id: ${_this.id}, sender: ${_this.sender}, text: ${_this.text}, timestamp: ${_this.timestamp}, referencedCard: ${_this.referencedCard}, personaId: ${_this.personaId}, isSpoken: ${_this.isSpoken})';
}


}

/// @nodoc
abstract mixin class $OracleDialogueMessageCopyWith<$Res>  {
  factory $OracleDialogueMessageCopyWith(OracleDialogueMessage value, $Res Function(OracleDialogueMessage) _then) = _$OracleDialogueMessageCopyWithImpl;
@useResult
$Res call({
 String id, DialogueSender sender, String text, DateTime timestamp, TarotCard? referencedCard, String? personaId, bool isSpoken
});


$TarotCardCopyWith<$Res>? get referencedCard;

}
/// @nodoc
class _$OracleDialogueMessageCopyWithImpl<$Res>
    implements $OracleDialogueMessageCopyWith<$Res> {
  _$OracleDialogueMessageCopyWithImpl(this._self, this._then);

  final OracleDialogueMessage _self;
  final $Res Function(OracleDialogueMessage) _then;

/// Create a copy of OracleDialogueMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sender = null,Object? text = null,Object? timestamp = null,Object? referencedCard = freezed,Object? personaId = freezed,Object? isSpoken = null,}) {
  return _then(OracleDialogueMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as DialogueSender,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,referencedCard: freezed == referencedCard ? _self.referencedCard : referencedCard // ignore: cast_nullable_to_non_nullable
as TarotCard?,personaId: freezed == personaId ? _self.personaId : personaId // ignore: cast_nullable_to_non_nullable
as String?,isSpoken: null == isSpoken ? _self.isSpoken : isSpoken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of OracleDialogueMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotCardCopyWith<$Res>? get referencedCard {
    if (_self.referencedCard == null) {
    return null;
  }

  return $TarotCardCopyWith<$Res>(_self.referencedCard!, (value) {
    return _then(_self.copyWith(referencedCard: value));
  });
}
}


/// Adds pattern-matching-related methods to [OracleDialogueMessage].
extension OracleDialogueMessagePatterns on OracleDialogueMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OracleDialogueMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OracleDialogueMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OracleDialogueMessage value)  $default,){
final _that = this;
switch (_that) {
case _OracleDialogueMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OracleDialogueMessage value)?  $default,){
final _that = this;
switch (_that) {
case _OracleDialogueMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DialogueSender sender,  String text,  DateTime timestamp,  TarotCard? referencedCard,  String? personaId,  bool isSpoken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OracleDialogueMessage() when $default != null:
return $default(_that.id,_that.sender,_that.text,_that.timestamp,_that.referencedCard,_that.personaId,_that.isSpoken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DialogueSender sender,  String text,  DateTime timestamp,  TarotCard? referencedCard,  String? personaId,  bool isSpoken)  $default,) {final _that = this;
switch (_that) {
case _OracleDialogueMessage():
return $default(_that.id,_that.sender,_that.text,_that.timestamp,_that.referencedCard,_that.personaId,_that.isSpoken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DialogueSender sender,  String text,  DateTime timestamp,  TarotCard? referencedCard,  String? personaId,  bool isSpoken)?  $default,) {final _that = this;
switch (_that) {
case _OracleDialogueMessage() when $default != null:
return $default(_that.id,_that.sender,_that.text,_that.timestamp,_that.referencedCard,_that.personaId,_that.isSpoken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OracleDialogueMessage implements OracleDialogueMessage {
  const _OracleDialogueMessage({required this.id, required this.sender, required this.text, required this.timestamp, this.referencedCard, this.personaId, this.isSpoken = false});
  factory _OracleDialogueMessage.fromJson(Map<String, dynamic> json) => _$OracleDialogueMessageFromJson(json);

@override final  String id;
@override final  DialogueSender sender;
@override final  String text;
@override final  DateTime timestamp;
@override final  TarotCard? referencedCard;
@override final  String? personaId;
@override@JsonKey() final  bool isSpoken;

/// Create a copy of OracleDialogueMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OracleDialogueMessageCopyWith<_OracleDialogueMessage> get copyWith => __$OracleDialogueMessageCopyWithImpl<_OracleDialogueMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OracleDialogueMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OracleDialogueMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.text, text) || other.text == text)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.referencedCard, referencedCard) || other.referencedCard == referencedCard)&&(identical(other.personaId, personaId) || other.personaId == personaId)&&(identical(other.isSpoken, isSpoken) || other.isSpoken == isSpoken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,sender,text,timestamp,referencedCard,personaId,isSpoken);
}

@override
String toString() {
    return 'OracleDialogueMessage(id: $id, sender: $sender, text: $text, timestamp: $timestamp, referencedCard: $referencedCard, personaId: $personaId, isSpoken: $isSpoken)';
}


}

/// @nodoc
abstract mixin class _$OracleDialogueMessageCopyWith<$Res> implements $OracleDialogueMessageCopyWith<$Res> {
  factory _$OracleDialogueMessageCopyWith(_OracleDialogueMessage value, $Res Function(_OracleDialogueMessage) _then) = __$OracleDialogueMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, DialogueSender sender, String text, DateTime timestamp, TarotCard? referencedCard, String? personaId, bool isSpoken
});


@override $TarotCardCopyWith<$Res>? get referencedCard;

}
/// @nodoc
class __$OracleDialogueMessageCopyWithImpl<$Res>
    implements _$OracleDialogueMessageCopyWith<$Res> {
  __$OracleDialogueMessageCopyWithImpl(this._self, this._then);

  final _OracleDialogueMessage _self;
  final $Res Function(_OracleDialogueMessage) _then;

/// Create a copy of OracleDialogueMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sender = null,Object? text = null,Object? timestamp = null,Object? referencedCard = freezed,Object? personaId = freezed,Object? isSpoken = null,}) {
  return _then(_OracleDialogueMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as DialogueSender,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,referencedCard: freezed == referencedCard ? _self.referencedCard : referencedCard // ignore: cast_nullable_to_non_nullable
as TarotCard?,personaId: freezed == personaId ? _self.personaId : personaId // ignore: cast_nullable_to_non_nullable
as String?,isSpoken: null == isSpoken ? _self.isSpoken : isSpoken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of OracleDialogueMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotCardCopyWith<$Res>? get referencedCard {
    if (_self.referencedCard == null) {
    return null;
  }

  return $TarotCardCopyWith<$Res>(_self.referencedCard!, (value) {
    return _then(_self.copyWith(referencedCard: value));
  });
}
}

// dart format on
