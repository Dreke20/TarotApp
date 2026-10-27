// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_reflection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioReflection {

 String get id; String get readingId; DateTime get recordedAt; int get durationSeconds; String get transcription; List<double> get waveformSamples;
/// Create a copy of AudioReflection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioReflectionCopyWith<AudioReflection> get copyWith => _$AudioReflectionCopyWithImpl<AudioReflection>(this as AudioReflection, _$identity);

  /// Serializes this AudioReflection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AudioReflection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioReflection&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.readingId, _this.readingId) || other.readingId == _this.readingId)&&(identical(other.recordedAt, _this.recordedAt) || other.recordedAt == _this.recordedAt)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.transcription, _this.transcription) || other.transcription == _this.transcription)&&const DeepCollectionEquality().equals(other.waveformSamples, _this.waveformSamples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AudioReflection;
  return Object.hash(runtimeType,_this.id,_this.readingId,_this.recordedAt,_this.durationSeconds,_this.transcription,const DeepCollectionEquality().hash(_this.waveformSamples));
}

@override
String toString() {
  final _this = this as AudioReflection;
  return 'AudioReflection(id: ${_this.id}, readingId: ${_this.readingId}, recordedAt: ${_this.recordedAt}, durationSeconds: ${_this.durationSeconds}, transcription: ${_this.transcription}, waveformSamples: ${_this.waveformSamples})';
}


}

/// @nodoc
abstract mixin class $AudioReflectionCopyWith<$Res>  {
  factory $AudioReflectionCopyWith(AudioReflection value, $Res Function(AudioReflection) _then) = _$AudioReflectionCopyWithImpl;
@useResult
$Res call({
 String id, String readingId, DateTime recordedAt, int durationSeconds, String transcription, List<double> waveformSamples
});




}
/// @nodoc
class _$AudioReflectionCopyWithImpl<$Res>
    implements $AudioReflectionCopyWith<$Res> {
  _$AudioReflectionCopyWithImpl(this._self, this._then);

  final AudioReflection _self;
  final $Res Function(AudioReflection) _then;

/// Create a copy of AudioReflection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? readingId = null,Object? recordedAt = null,Object? durationSeconds = null,Object? transcription = null,Object? waveformSamples = null,}) {
  return _then(AudioReflection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,readingId: null == readingId ? _self.readingId : readingId // ignore: cast_nullable_to_non_nullable
as String,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,transcription: null == transcription ? _self.transcription : transcription // ignore: cast_nullable_to_non_nullable
as String,waveformSamples: null == waveformSamples ? _self.waveformSamples : waveformSamples // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioReflection].
extension AudioReflectionPatterns on AudioReflection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioReflection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioReflection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioReflection value)  $default,){
final _that = this;
switch (_that) {
case _AudioReflection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioReflection value)?  $default,){
final _that = this;
switch (_that) {
case _AudioReflection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String readingId,  DateTime recordedAt,  int durationSeconds,  String transcription,  List<double> waveformSamples)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioReflection() when $default != null:
return $default(_that.id,_that.readingId,_that.recordedAt,_that.durationSeconds,_that.transcription,_that.waveformSamples);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String readingId,  DateTime recordedAt,  int durationSeconds,  String transcription,  List<double> waveformSamples)  $default,) {final _that = this;
switch (_that) {
case _AudioReflection():
return $default(_that.id,_that.readingId,_that.recordedAt,_that.durationSeconds,_that.transcription,_that.waveformSamples);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String readingId,  DateTime recordedAt,  int durationSeconds,  String transcription,  List<double> waveformSamples)?  $default,) {final _that = this;
switch (_that) {
case _AudioReflection() when $default != null:
return $default(_that.id,_that.readingId,_that.recordedAt,_that.durationSeconds,_that.transcription,_that.waveformSamples);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AudioReflection implements AudioReflection {
  const _AudioReflection({required this.id, required this.readingId, required this.recordedAt, required this.durationSeconds, required this.transcription,  List<double> waveformSamples = const []}): _waveformSamples = waveformSamples;
  factory _AudioReflection.fromJson(Map<String, dynamic> json) => _$AudioReflectionFromJson(json);

@override final  String id;
@override final  String readingId;
@override final  DateTime recordedAt;
@override final  int durationSeconds;
@override final  String transcription;
 final  List<double> _waveformSamples;
@override@JsonKey() List<double> get waveformSamples {
  if (_waveformSamples is EqualUnmodifiableListView) return _waveformSamples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waveformSamples);
}


/// Create a copy of AudioReflection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioReflectionCopyWith<_AudioReflection> get copyWith => __$AudioReflectionCopyWithImpl<_AudioReflection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioReflectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioReflection&&(identical(other.id, id) || other.id == id)&&(identical(other.readingId, readingId) || other.readingId == readingId)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.transcription, transcription) || other.transcription == transcription)&&const DeepCollectionEquality().equals(other.waveformSamples, _waveformSamples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,readingId,recordedAt,durationSeconds,transcription,const DeepCollectionEquality().hash(_waveformSamples));
}

@override
String toString() {
    return 'AudioReflection(id: $id, readingId: $readingId, recordedAt: $recordedAt, durationSeconds: $durationSeconds, transcription: $transcription, waveformSamples: $waveformSamples)';
}


}

/// @nodoc
abstract mixin class _$AudioReflectionCopyWith<$Res> implements $AudioReflectionCopyWith<$Res> {
  factory _$AudioReflectionCopyWith(_AudioReflection value, $Res Function(_AudioReflection) _then) = __$AudioReflectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String readingId, DateTime recordedAt, int durationSeconds, String transcription, List<double> waveformSamples
});




}
/// @nodoc
class __$AudioReflectionCopyWithImpl<$Res>
    implements _$AudioReflectionCopyWith<$Res> {
  __$AudioReflectionCopyWithImpl(this._self, this._then);

  final _AudioReflection _self;
  final $Res Function(_AudioReflection) _then;

/// Create a copy of AudioReflection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? readingId = null,Object? recordedAt = null,Object? durationSeconds = null,Object? transcription = null,Object? waveformSamples = null,}) {
  return _then(_AudioReflection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,readingId: null == readingId ? _self.readingId : readingId // ignore: cast_nullable_to_non_nullable
as String,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,transcription: null == transcription ? _self.transcription : transcription // ignore: cast_nullable_to_non_nullable
as String,waveformSamples: null == waveformSamples ? _self._waveformSamples : waveformSamples // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
