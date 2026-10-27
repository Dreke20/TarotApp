// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hands_free_voice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HandsFreeVoiceState {

 bool get isListening; bool get isSpeaking; bool get isProcessing; String get currentTranscript; double get speechConfidence; double get soundLevel; bool get handsFreeEnabled; double get duckingLevel; String? get lastFinalizedInquiry;
/// Create a copy of HandsFreeVoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandsFreeVoiceStateCopyWith<HandsFreeVoiceState> get copyWith => _$HandsFreeVoiceStateCopyWithImpl<HandsFreeVoiceState>(this as HandsFreeVoiceState, _$identity);

  /// Serializes this HandsFreeVoiceState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HandsFreeVoiceState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandsFreeVoiceState&&(identical(other.isListening, _this.isListening) || other.isListening == _this.isListening)&&(identical(other.isSpeaking, _this.isSpeaking) || other.isSpeaking == _this.isSpeaking)&&(identical(other.isProcessing, _this.isProcessing) || other.isProcessing == _this.isProcessing)&&(identical(other.currentTranscript, _this.currentTranscript) || other.currentTranscript == _this.currentTranscript)&&(identical(other.speechConfidence, _this.speechConfidence) || other.speechConfidence == _this.speechConfidence)&&(identical(other.soundLevel, _this.soundLevel) || other.soundLevel == _this.soundLevel)&&(identical(other.handsFreeEnabled, _this.handsFreeEnabled) || other.handsFreeEnabled == _this.handsFreeEnabled)&&(identical(other.duckingLevel, _this.duckingLevel) || other.duckingLevel == _this.duckingLevel)&&(identical(other.lastFinalizedInquiry, _this.lastFinalizedInquiry) || other.lastFinalizedInquiry == _this.lastFinalizedInquiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HandsFreeVoiceState;
  return Object.hash(runtimeType,_this.isListening,_this.isSpeaking,_this.isProcessing,_this.currentTranscript,_this.speechConfidence,_this.soundLevel,_this.handsFreeEnabled,_this.duckingLevel,_this.lastFinalizedInquiry);
}

@override
String toString() {
  final _this = this as HandsFreeVoiceState;
  return 'HandsFreeVoiceState(isListening: ${_this.isListening}, isSpeaking: ${_this.isSpeaking}, isProcessing: ${_this.isProcessing}, currentTranscript: ${_this.currentTranscript}, speechConfidence: ${_this.speechConfidence}, soundLevel: ${_this.soundLevel}, handsFreeEnabled: ${_this.handsFreeEnabled}, duckingLevel: ${_this.duckingLevel}, lastFinalizedInquiry: ${_this.lastFinalizedInquiry})';
}


}

/// @nodoc
abstract mixin class $HandsFreeVoiceStateCopyWith<$Res>  {
  factory $HandsFreeVoiceStateCopyWith(HandsFreeVoiceState value, $Res Function(HandsFreeVoiceState) _then) = _$HandsFreeVoiceStateCopyWithImpl;
@useResult
$Res call({
 bool isListening, bool isSpeaking, bool isProcessing, String currentTranscript, double speechConfidence, double soundLevel, bool handsFreeEnabled, double duckingLevel, String? lastFinalizedInquiry
});




}
/// @nodoc
class _$HandsFreeVoiceStateCopyWithImpl<$Res>
    implements $HandsFreeVoiceStateCopyWith<$Res> {
  _$HandsFreeVoiceStateCopyWithImpl(this._self, this._then);

  final HandsFreeVoiceState _self;
  final $Res Function(HandsFreeVoiceState) _then;

/// Create a copy of HandsFreeVoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isListening = null,Object? isSpeaking = null,Object? isProcessing = null,Object? currentTranscript = null,Object? speechConfidence = null,Object? soundLevel = null,Object? handsFreeEnabled = null,Object? duckingLevel = null,Object? lastFinalizedInquiry = freezed,}) {
  return _then(HandsFreeVoiceState(
isListening: null == isListening ? _self.isListening : isListening // ignore: cast_nullable_to_non_nullable
as bool,isSpeaking: null == isSpeaking ? _self.isSpeaking : isSpeaking // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,currentTranscript: null == currentTranscript ? _self.currentTranscript : currentTranscript // ignore: cast_nullable_to_non_nullable
as String,speechConfidence: null == speechConfidence ? _self.speechConfidence : speechConfidence // ignore: cast_nullable_to_non_nullable
as double,soundLevel: null == soundLevel ? _self.soundLevel : soundLevel // ignore: cast_nullable_to_non_nullable
as double,handsFreeEnabled: null == handsFreeEnabled ? _self.handsFreeEnabled : handsFreeEnabled // ignore: cast_nullable_to_non_nullable
as bool,duckingLevel: null == duckingLevel ? _self.duckingLevel : duckingLevel // ignore: cast_nullable_to_non_nullable
as double,lastFinalizedInquiry: freezed == lastFinalizedInquiry ? _self.lastFinalizedInquiry : lastFinalizedInquiry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HandsFreeVoiceState].
extension HandsFreeVoiceStatePatterns on HandsFreeVoiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandsFreeVoiceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandsFreeVoiceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandsFreeVoiceState value)  $default,){
final _that = this;
switch (_that) {
case _HandsFreeVoiceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandsFreeVoiceState value)?  $default,){
final _that = this;
switch (_that) {
case _HandsFreeVoiceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isListening,  bool isSpeaking,  bool isProcessing,  String currentTranscript,  double speechConfidence,  double soundLevel,  bool handsFreeEnabled,  double duckingLevel,  String? lastFinalizedInquiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandsFreeVoiceState() when $default != null:
return $default(_that.isListening,_that.isSpeaking,_that.isProcessing,_that.currentTranscript,_that.speechConfidence,_that.soundLevel,_that.handsFreeEnabled,_that.duckingLevel,_that.lastFinalizedInquiry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isListening,  bool isSpeaking,  bool isProcessing,  String currentTranscript,  double speechConfidence,  double soundLevel,  bool handsFreeEnabled,  double duckingLevel,  String? lastFinalizedInquiry)  $default,) {final _that = this;
switch (_that) {
case _HandsFreeVoiceState():
return $default(_that.isListening,_that.isSpeaking,_that.isProcessing,_that.currentTranscript,_that.speechConfidence,_that.soundLevel,_that.handsFreeEnabled,_that.duckingLevel,_that.lastFinalizedInquiry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isListening,  bool isSpeaking,  bool isProcessing,  String currentTranscript,  double speechConfidence,  double soundLevel,  bool handsFreeEnabled,  double duckingLevel,  String? lastFinalizedInquiry)?  $default,) {final _that = this;
switch (_that) {
case _HandsFreeVoiceState() when $default != null:
return $default(_that.isListening,_that.isSpeaking,_that.isProcessing,_that.currentTranscript,_that.speechConfidence,_that.soundLevel,_that.handsFreeEnabled,_that.duckingLevel,_that.lastFinalizedInquiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HandsFreeVoiceState implements HandsFreeVoiceState {
  const _HandsFreeVoiceState({this.isListening = false, this.isSpeaking = false, this.isProcessing = false, this.currentTranscript = '', this.speechConfidence = 0.0, this.soundLevel = 0.0, this.handsFreeEnabled = true, this.duckingLevel = 1.0, this.lastFinalizedInquiry});
  factory _HandsFreeVoiceState.fromJson(Map<String, dynamic> json) => _$HandsFreeVoiceStateFromJson(json);

@override@JsonKey() final  bool isListening;
@override@JsonKey() final  bool isSpeaking;
@override@JsonKey() final  bool isProcessing;
@override@JsonKey() final  String currentTranscript;
@override@JsonKey() final  double speechConfidence;
@override@JsonKey() final  double soundLevel;
@override@JsonKey() final  bool handsFreeEnabled;
@override@JsonKey() final  double duckingLevel;
@override final  String? lastFinalizedInquiry;

/// Create a copy of HandsFreeVoiceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandsFreeVoiceStateCopyWith<_HandsFreeVoiceState> get copyWith => __$HandsFreeVoiceStateCopyWithImpl<_HandsFreeVoiceState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HandsFreeVoiceStateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandsFreeVoiceState&&(identical(other.isListening, isListening) || other.isListening == isListening)&&(identical(other.isSpeaking, isSpeaking) || other.isSpeaking == isSpeaking)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.currentTranscript, currentTranscript) || other.currentTranscript == currentTranscript)&&(identical(other.speechConfidence, speechConfidence) || other.speechConfidence == speechConfidence)&&(identical(other.soundLevel, soundLevel) || other.soundLevel == soundLevel)&&(identical(other.handsFreeEnabled, handsFreeEnabled) || other.handsFreeEnabled == handsFreeEnabled)&&(identical(other.duckingLevel, duckingLevel) || other.duckingLevel == duckingLevel)&&(identical(other.lastFinalizedInquiry, lastFinalizedInquiry) || other.lastFinalizedInquiry == lastFinalizedInquiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,isListening,isSpeaking,isProcessing,currentTranscript,speechConfidence,soundLevel,handsFreeEnabled,duckingLevel,lastFinalizedInquiry);
}

@override
String toString() {
    return 'HandsFreeVoiceState(isListening: $isListening, isSpeaking: $isSpeaking, isProcessing: $isProcessing, currentTranscript: $currentTranscript, speechConfidence: $speechConfidence, soundLevel: $soundLevel, handsFreeEnabled: $handsFreeEnabled, duckingLevel: $duckingLevel, lastFinalizedInquiry: $lastFinalizedInquiry)';
}


}

/// @nodoc
abstract mixin class _$HandsFreeVoiceStateCopyWith<$Res> implements $HandsFreeVoiceStateCopyWith<$Res> {
  factory _$HandsFreeVoiceStateCopyWith(_HandsFreeVoiceState value, $Res Function(_HandsFreeVoiceState) _then) = __$HandsFreeVoiceStateCopyWithImpl;
@override @useResult
$Res call({
 bool isListening, bool isSpeaking, bool isProcessing, String currentTranscript, double speechConfidence, double soundLevel, bool handsFreeEnabled, double duckingLevel, String? lastFinalizedInquiry
});




}
/// @nodoc
class __$HandsFreeVoiceStateCopyWithImpl<$Res>
    implements _$HandsFreeVoiceStateCopyWith<$Res> {
  __$HandsFreeVoiceStateCopyWithImpl(this._self, this._then);

  final _HandsFreeVoiceState _self;
  final $Res Function(_HandsFreeVoiceState) _then;

/// Create a copy of HandsFreeVoiceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isListening = null,Object? isSpeaking = null,Object? isProcessing = null,Object? currentTranscript = null,Object? speechConfidence = null,Object? soundLevel = null,Object? handsFreeEnabled = null,Object? duckingLevel = null,Object? lastFinalizedInquiry = freezed,}) {
  return _then(_HandsFreeVoiceState(
isListening: null == isListening ? _self.isListening : isListening // ignore: cast_nullable_to_non_nullable
as bool,isSpeaking: null == isSpeaking ? _self.isSpeaking : isSpeaking // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,currentTranscript: null == currentTranscript ? _self.currentTranscript : currentTranscript // ignore: cast_nullable_to_non_nullable
as String,speechConfidence: null == speechConfidence ? _self.speechConfidence : speechConfidence // ignore: cast_nullable_to_non_nullable
as double,soundLevel: null == soundLevel ? _self.soundLevel : soundLevel // ignore: cast_nullable_to_non_nullable
as double,handsFreeEnabled: null == handsFreeEnabled ? _self.handsFreeEnabled : handsFreeEnabled // ignore: cast_nullable_to_non_nullable
as bool,duckingLevel: null == duckingLevel ? _self.duckingLevel : duckingLevel // ignore: cast_nullable_to_non_nullable
as double,lastFinalizedInquiry: freezed == lastFinalizedInquiry ? _self.lastFinalizedInquiry : lastFinalizedInquiry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
