// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oracle_dialogue_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OracleDialogueViewState {

 List<OracleDialogueMessage> get messages; DialogueState get phase; String get liveTranscript; double get soundLevel; bool get isHandsFree; bool get isSpeechAvailable; bool get isVoiceMuted; OraclePersona get persona; String? get errorMessage;
/// Create a copy of OracleDialogueViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OracleDialogueViewStateCopyWith<OracleDialogueViewState> get copyWith => _$OracleDialogueViewStateCopyWithImpl<OracleDialogueViewState>(this as OracleDialogueViewState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OracleDialogueViewState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OracleDialogueViewState&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&(identical(other.phase, _this.phase) || other.phase == _this.phase)&&(identical(other.liveTranscript, _this.liveTranscript) || other.liveTranscript == _this.liveTranscript)&&(identical(other.soundLevel, _this.soundLevel) || other.soundLevel == _this.soundLevel)&&(identical(other.isHandsFree, _this.isHandsFree) || other.isHandsFree == _this.isHandsFree)&&(identical(other.isSpeechAvailable, _this.isSpeechAvailable) || other.isSpeechAvailable == _this.isSpeechAvailable)&&(identical(other.isVoiceMuted, _this.isVoiceMuted) || other.isVoiceMuted == _this.isVoiceMuted)&&(identical(other.persona, _this.persona) || other.persona == _this.persona)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as OracleDialogueViewState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.messages),_this.phase,_this.liveTranscript,_this.soundLevel,_this.isHandsFree,_this.isSpeechAvailable,_this.isVoiceMuted,_this.persona,_this.errorMessage);
}

@override
String toString() {
  final _this = this as OracleDialogueViewState;
  return 'OracleDialogueViewState(messages: ${_this.messages}, phase: ${_this.phase}, liveTranscript: ${_this.liveTranscript}, soundLevel: ${_this.soundLevel}, isHandsFree: ${_this.isHandsFree}, isSpeechAvailable: ${_this.isSpeechAvailable}, isVoiceMuted: ${_this.isVoiceMuted}, persona: ${_this.persona}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $OracleDialogueViewStateCopyWith<$Res>  {
  factory $OracleDialogueViewStateCopyWith(OracleDialogueViewState value, $Res Function(OracleDialogueViewState) _then) = _$OracleDialogueViewStateCopyWithImpl;
@useResult
$Res call({
 List<OracleDialogueMessage> messages, DialogueState phase, String liveTranscript, double soundLevel, bool isHandsFree, bool isSpeechAvailable, bool isVoiceMuted, OraclePersona persona, String? errorMessage
});




}
/// @nodoc
class _$OracleDialogueViewStateCopyWithImpl<$Res>
    implements $OracleDialogueViewStateCopyWith<$Res> {
  _$OracleDialogueViewStateCopyWithImpl(this._self, this._then);

  final OracleDialogueViewState _self;
  final $Res Function(OracleDialogueViewState) _then;

/// Create a copy of OracleDialogueViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? phase = null,Object? liveTranscript = null,Object? soundLevel = null,Object? isHandsFree = null,Object? isSpeechAvailable = null,Object? isVoiceMuted = null,Object? persona = null,Object? errorMessage = freezed,}) {
  return _then(OracleDialogueViewState(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<OracleDialogueMessage>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as DialogueState,liveTranscript: null == liveTranscript ? _self.liveTranscript : liveTranscript // ignore: cast_nullable_to_non_nullable
as String,soundLevel: null == soundLevel ? _self.soundLevel : soundLevel // ignore: cast_nullable_to_non_nullable
as double,isHandsFree: null == isHandsFree ? _self.isHandsFree : isHandsFree // ignore: cast_nullable_to_non_nullable
as bool,isSpeechAvailable: null == isSpeechAvailable ? _self.isSpeechAvailable : isSpeechAvailable // ignore: cast_nullable_to_non_nullable
as bool,isVoiceMuted: null == isVoiceMuted ? _self.isVoiceMuted : isVoiceMuted // ignore: cast_nullable_to_non_nullable
as bool,persona: null == persona ? _self.persona : persona // ignore: cast_nullable_to_non_nullable
as OraclePersona,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OracleDialogueViewState].
extension OracleDialogueViewStatePatterns on OracleDialogueViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OracleDialogueViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OracleDialogueViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OracleDialogueViewState value)  $default,){
final _that = this;
switch (_that) {
case _OracleDialogueViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OracleDialogueViewState value)?  $default,){
final _that = this;
switch (_that) {
case _OracleDialogueViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OracleDialogueMessage> messages,  DialogueState phase,  String liveTranscript,  double soundLevel,  bool isHandsFree,  bool isSpeechAvailable,  bool isVoiceMuted,  OraclePersona persona,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OracleDialogueViewState() when $default != null:
return $default(_that.messages,_that.phase,_that.liveTranscript,_that.soundLevel,_that.isHandsFree,_that.isSpeechAvailable,_that.isVoiceMuted,_that.persona,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OracleDialogueMessage> messages,  DialogueState phase,  String liveTranscript,  double soundLevel,  bool isHandsFree,  bool isSpeechAvailable,  bool isVoiceMuted,  OraclePersona persona,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _OracleDialogueViewState():
return $default(_that.messages,_that.phase,_that.liveTranscript,_that.soundLevel,_that.isHandsFree,_that.isSpeechAvailable,_that.isVoiceMuted,_that.persona,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OracleDialogueMessage> messages,  DialogueState phase,  String liveTranscript,  double soundLevel,  bool isHandsFree,  bool isSpeechAvailable,  bool isVoiceMuted,  OraclePersona persona,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _OracleDialogueViewState() when $default != null:
return $default(_that.messages,_that.phase,_that.liveTranscript,_that.soundLevel,_that.isHandsFree,_that.isSpeechAvailable,_that.isVoiceMuted,_that.persona,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _OracleDialogueViewState implements OracleDialogueViewState {
  const _OracleDialogueViewState({ List<OracleDialogueMessage> messages = const <OracleDialogueMessage>[], this.phase = DialogueState.idle, this.liveTranscript = '', this.soundLevel = 0.0, this.isHandsFree = true, this.isSpeechAvailable = false, this.isVoiceMuted = false, this.persona = OraclePersona.highPriestess, this.errorMessage}): _messages = messages;
  

 final  List<OracleDialogueMessage> _messages;
@override@JsonKey() List<OracleDialogueMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  DialogueState phase;
@override@JsonKey() final  String liveTranscript;
@override@JsonKey() final  double soundLevel;
@override@JsonKey() final  bool isHandsFree;
@override@JsonKey() final  bool isSpeechAvailable;
@override@JsonKey() final  bool isVoiceMuted;
@override@JsonKey() final  OraclePersona persona;
@override final  String? errorMessage;

/// Create a copy of OracleDialogueViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OracleDialogueViewStateCopyWith<_OracleDialogueViewState> get copyWith => __$OracleDialogueViewStateCopyWithImpl<_OracleDialogueViewState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OracleDialogueViewState&&const DeepCollectionEquality().equals(other.messages, _messages)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.liveTranscript, liveTranscript) || other.liveTranscript == liveTranscript)&&(identical(other.soundLevel, soundLevel) || other.soundLevel == soundLevel)&&(identical(other.isHandsFree, isHandsFree) || other.isHandsFree == isHandsFree)&&(identical(other.isSpeechAvailable, isSpeechAvailable) || other.isSpeechAvailable == isSpeechAvailable)&&(identical(other.isVoiceMuted, isVoiceMuted) || other.isVoiceMuted == isVoiceMuted)&&(identical(other.persona, persona) || other.persona == persona)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),phase,liveTranscript,soundLevel,isHandsFree,isSpeechAvailable,isVoiceMuted,persona,errorMessage);
}

@override
String toString() {
    return 'OracleDialogueViewState(messages: $messages, phase: $phase, liveTranscript: $liveTranscript, soundLevel: $soundLevel, isHandsFree: $isHandsFree, isSpeechAvailable: $isSpeechAvailable, isVoiceMuted: $isVoiceMuted, persona: $persona, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$OracleDialogueViewStateCopyWith<$Res> implements $OracleDialogueViewStateCopyWith<$Res> {
  factory _$OracleDialogueViewStateCopyWith(_OracleDialogueViewState value, $Res Function(_OracleDialogueViewState) _then) = __$OracleDialogueViewStateCopyWithImpl;
@override @useResult
$Res call({
 List<OracleDialogueMessage> messages, DialogueState phase, String liveTranscript, double soundLevel, bool isHandsFree, bool isSpeechAvailable, bool isVoiceMuted, OraclePersona persona, String? errorMessage
});




}
/// @nodoc
class __$OracleDialogueViewStateCopyWithImpl<$Res>
    implements _$OracleDialogueViewStateCopyWith<$Res> {
  __$OracleDialogueViewStateCopyWithImpl(this._self, this._then);

  final _OracleDialogueViewState _self;
  final $Res Function(_OracleDialogueViewState) _then;

/// Create a copy of OracleDialogueViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? phase = null,Object? liveTranscript = null,Object? soundLevel = null,Object? isHandsFree = null,Object? isSpeechAvailable = null,Object? isVoiceMuted = null,Object? persona = null,Object? errorMessage = freezed,}) {
  return _then(_OracleDialogueViewState(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<OracleDialogueMessage>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as DialogueState,liveTranscript: null == liveTranscript ? _self.liveTranscript : liveTranscript // ignore: cast_nullable_to_non_nullable
as String,soundLevel: null == soundLevel ? _self.soundLevel : soundLevel // ignore: cast_nullable_to_non_nullable
as double,isHandsFree: null == isHandsFree ? _self.isHandsFree : isHandsFree // ignore: cast_nullable_to_non_nullable
as bool,isSpeechAvailable: null == isSpeechAvailable ? _self.isSpeechAvailable : isSpeechAvailable // ignore: cast_nullable_to_non_nullable
as bool,isVoiceMuted: null == isVoiceMuted ? _self.isVoiceMuted : isVoiceMuted // ignore: cast_nullable_to_non_nullable
as bool,persona: null == persona ? _self.persona : persona // ignore: cast_nullable_to_non_nullable
as OraclePersona,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
