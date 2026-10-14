// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dream_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DreamEntry {

 String get id; DateTime get recordedAt; String get title; String get narrative; String get mood; List<String> get symbols; String? get jungianAnalysis; String? get correlatedTarotCardId; String? get correlatedTarotCardName; String? get archetypalMessage;
/// Create a copy of DreamEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DreamEntryCopyWith<DreamEntry> get copyWith => _$DreamEntryCopyWithImpl<DreamEntry>(this as DreamEntry, _$identity);

  /// Serializes this DreamEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DreamEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DreamEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.recordedAt, _this.recordedAt) || other.recordedAt == _this.recordedAt)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.narrative, _this.narrative) || other.narrative == _this.narrative)&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&const DeepCollectionEquality().equals(other.symbols, _this.symbols)&&(identical(other.jungianAnalysis, _this.jungianAnalysis) || other.jungianAnalysis == _this.jungianAnalysis)&&(identical(other.correlatedTarotCardId, _this.correlatedTarotCardId) || other.correlatedTarotCardId == _this.correlatedTarotCardId)&&(identical(other.correlatedTarotCardName, _this.correlatedTarotCardName) || other.correlatedTarotCardName == _this.correlatedTarotCardName)&&(identical(other.archetypalMessage, _this.archetypalMessage) || other.archetypalMessage == _this.archetypalMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DreamEntry;
  return Object.hash(runtimeType,_this.id,_this.recordedAt,_this.title,_this.narrative,_this.mood,const DeepCollectionEquality().hash(_this.symbols),_this.jungianAnalysis,_this.correlatedTarotCardId,_this.correlatedTarotCardName,_this.archetypalMessage);
}

@override
String toString() {
  final _this = this as DreamEntry;
  return 'DreamEntry(id: ${_this.id}, recordedAt: ${_this.recordedAt}, title: ${_this.title}, narrative: ${_this.narrative}, mood: ${_this.mood}, symbols: ${_this.symbols}, jungianAnalysis: ${_this.jungianAnalysis}, correlatedTarotCardId: ${_this.correlatedTarotCardId}, correlatedTarotCardName: ${_this.correlatedTarotCardName}, archetypalMessage: ${_this.archetypalMessage})';
}


}

/// @nodoc
abstract mixin class $DreamEntryCopyWith<$Res>  {
  factory $DreamEntryCopyWith(DreamEntry value, $Res Function(DreamEntry) _then) = _$DreamEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime recordedAt, String title, String narrative, String mood, List<String> symbols, String? jungianAnalysis, String? correlatedTarotCardId, String? correlatedTarotCardName, String? archetypalMessage
});




}
/// @nodoc
class _$DreamEntryCopyWithImpl<$Res>
    implements $DreamEntryCopyWith<$Res> {
  _$DreamEntryCopyWithImpl(this._self, this._then);

  final DreamEntry _self;
  final $Res Function(DreamEntry) _then;

/// Create a copy of DreamEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? recordedAt = null,Object? title = null,Object? narrative = null,Object? mood = null,Object? symbols = null,Object? jungianAnalysis = freezed,Object? correlatedTarotCardId = freezed,Object? correlatedTarotCardName = freezed,Object? archetypalMessage = freezed,}) {
  return _then(DreamEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,narrative: null == narrative ? _self.narrative : narrative // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String,symbols: null == symbols ? _self.symbols : symbols // ignore: cast_nullable_to_non_nullable
as List<String>,jungianAnalysis: freezed == jungianAnalysis ? _self.jungianAnalysis : jungianAnalysis // ignore: cast_nullable_to_non_nullable
as String?,correlatedTarotCardId: freezed == correlatedTarotCardId ? _self.correlatedTarotCardId : correlatedTarotCardId // ignore: cast_nullable_to_non_nullable
as String?,correlatedTarotCardName: freezed == correlatedTarotCardName ? _self.correlatedTarotCardName : correlatedTarotCardName // ignore: cast_nullable_to_non_nullable
as String?,archetypalMessage: freezed == archetypalMessage ? _self.archetypalMessage : archetypalMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DreamEntry].
extension DreamEntryPatterns on DreamEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DreamEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DreamEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DreamEntry value)  $default,){
final _that = this;
switch (_that) {
case _DreamEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DreamEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DreamEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime recordedAt,  String title,  String narrative,  String mood,  List<String> symbols,  String? jungianAnalysis,  String? correlatedTarotCardId,  String? correlatedTarotCardName,  String? archetypalMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DreamEntry() when $default != null:
return $default(_that.id,_that.recordedAt,_that.title,_that.narrative,_that.mood,_that.symbols,_that.jungianAnalysis,_that.correlatedTarotCardId,_that.correlatedTarotCardName,_that.archetypalMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime recordedAt,  String title,  String narrative,  String mood,  List<String> symbols,  String? jungianAnalysis,  String? correlatedTarotCardId,  String? correlatedTarotCardName,  String? archetypalMessage)  $default,) {final _that = this;
switch (_that) {
case _DreamEntry():
return $default(_that.id,_that.recordedAt,_that.title,_that.narrative,_that.mood,_that.symbols,_that.jungianAnalysis,_that.correlatedTarotCardId,_that.correlatedTarotCardName,_that.archetypalMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime recordedAt,  String title,  String narrative,  String mood,  List<String> symbols,  String? jungianAnalysis,  String? correlatedTarotCardId,  String? correlatedTarotCardName,  String? archetypalMessage)?  $default,) {final _that = this;
switch (_that) {
case _DreamEntry() when $default != null:
return $default(_that.id,_that.recordedAt,_that.title,_that.narrative,_that.mood,_that.symbols,_that.jungianAnalysis,_that.correlatedTarotCardId,_that.correlatedTarotCardName,_that.archetypalMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DreamEntry implements DreamEntry {
  const _DreamEntry({required this.id, required this.recordedAt, required this.title, required this.narrative, required this.mood,  List<String> symbols = const [], this.jungianAnalysis, this.correlatedTarotCardId, this.correlatedTarotCardName, this.archetypalMessage}): _symbols = symbols;
  factory _DreamEntry.fromJson(Map<String, dynamic> json) => _$DreamEntryFromJson(json);

@override final  String id;
@override final  DateTime recordedAt;
@override final  String title;
@override final  String narrative;
@override final  String mood;
 final  List<String> _symbols;
@override@JsonKey() List<String> get symbols {
  if (_symbols is EqualUnmodifiableListView) return _symbols;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symbols);
}

@override final  String? jungianAnalysis;
@override final  String? correlatedTarotCardId;
@override final  String? correlatedTarotCardName;
@override final  String? archetypalMessage;

/// Create a copy of DreamEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DreamEntryCopyWith<_DreamEntry> get copyWith => __$DreamEntryCopyWithImpl<_DreamEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DreamEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DreamEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.narrative, narrative) || other.narrative == narrative)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other.symbols, _symbols)&&(identical(other.jungianAnalysis, jungianAnalysis) || other.jungianAnalysis == jungianAnalysis)&&(identical(other.correlatedTarotCardId, correlatedTarotCardId) || other.correlatedTarotCardId == correlatedTarotCardId)&&(identical(other.correlatedTarotCardName, correlatedTarotCardName) || other.correlatedTarotCardName == correlatedTarotCardName)&&(identical(other.archetypalMessage, archetypalMessage) || other.archetypalMessage == archetypalMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,recordedAt,title,narrative,mood,const DeepCollectionEquality().hash(_symbols),jungianAnalysis,correlatedTarotCardId,correlatedTarotCardName,archetypalMessage);
}

@override
String toString() {
    return 'DreamEntry(id: $id, recordedAt: $recordedAt, title: $title, narrative: $narrative, mood: $mood, symbols: $symbols, jungianAnalysis: $jungianAnalysis, correlatedTarotCardId: $correlatedTarotCardId, correlatedTarotCardName: $correlatedTarotCardName, archetypalMessage: $archetypalMessage)';
}


}

/// @nodoc
abstract mixin class _$DreamEntryCopyWith<$Res> implements $DreamEntryCopyWith<$Res> {
  factory _$DreamEntryCopyWith(_DreamEntry value, $Res Function(_DreamEntry) _then) = __$DreamEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime recordedAt, String title, String narrative, String mood, List<String> symbols, String? jungianAnalysis, String? correlatedTarotCardId, String? correlatedTarotCardName, String? archetypalMessage
});




}
/// @nodoc
class __$DreamEntryCopyWithImpl<$Res>
    implements _$DreamEntryCopyWith<$Res> {
  __$DreamEntryCopyWithImpl(this._self, this._then);

  final _DreamEntry _self;
  final $Res Function(_DreamEntry) _then;

/// Create a copy of DreamEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? recordedAt = null,Object? title = null,Object? narrative = null,Object? mood = null,Object? symbols = null,Object? jungianAnalysis = freezed,Object? correlatedTarotCardId = freezed,Object? correlatedTarotCardName = freezed,Object? archetypalMessage = freezed,}) {
  return _then(_DreamEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,narrative: null == narrative ? _self.narrative : narrative // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String,symbols: null == symbols ? _self._symbols : symbols // ignore: cast_nullable_to_non_nullable
as List<String>,jungianAnalysis: freezed == jungianAnalysis ? _self.jungianAnalysis : jungianAnalysis // ignore: cast_nullable_to_non_nullable
as String?,correlatedTarotCardId: freezed == correlatedTarotCardId ? _self.correlatedTarotCardId : correlatedTarotCardId // ignore: cast_nullable_to_non_nullable
as String?,correlatedTarotCardName: freezed == correlatedTarotCardName ? _self.correlatedTarotCardName : correlatedTarotCardName // ignore: cast_nullable_to_non_nullable
as String?,archetypalMessage: freezed == archetypalMessage ? _self.archetypalMessage : archetypalMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
