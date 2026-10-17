// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reading {

 String get id;@JsonKey(name: 'user_id') String? get userId; String get question;@JsonKey(name: 'spread_type') String get spreadType; List<TarotCard> get cards; String get interpretation; String? get summary; String? get advice; String get notes;@JsonKey(name: 'is_favorite') bool get isFavorite;@JsonKey(name: 'journey_recall') String? get journeyRecall;@JsonKey(name: 'elemental_chemistry') String? get elementalChemistry;@JsonKey(name: 'cosmic_weather') String? get cosmicWeather;@JsonKey(name: 'scrying_prompts') List<String> get scryingPrompts;@JsonKey(name: 'persona_id') String? get personaId;@JsonKey(name: 'altar_consecration') String? get altarConsecration;@JsonKey(name: 'micro_ritual') String? get microRitual;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of Reading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingCopyWith<Reading> get copyWith => _$ReadingCopyWithImpl<Reading>(this as Reading, _$identity);

  /// Serializes this Reading to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Reading;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reading&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.spreadType, _this.spreadType) || other.spreadType == _this.spreadType)&&const DeepCollectionEquality().equals(other.cards, _this.cards)&&(identical(other.interpretation, _this.interpretation) || other.interpretation == _this.interpretation)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.advice, _this.advice) || other.advice == _this.advice)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.isFavorite, _this.isFavorite) || other.isFavorite == _this.isFavorite)&&(identical(other.journeyRecall, _this.journeyRecall) || other.journeyRecall == _this.journeyRecall)&&(identical(other.elementalChemistry, _this.elementalChemistry) || other.elementalChemistry == _this.elementalChemistry)&&(identical(other.cosmicWeather, _this.cosmicWeather) || other.cosmicWeather == _this.cosmicWeather)&&const DeepCollectionEquality().equals(other.scryingPrompts, _this.scryingPrompts)&&(identical(other.personaId, _this.personaId) || other.personaId == _this.personaId)&&(identical(other.altarConsecration, _this.altarConsecration) || other.altarConsecration == _this.altarConsecration)&&(identical(other.microRitual, _this.microRitual) || other.microRitual == _this.microRitual)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Reading;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.question,_this.spreadType,const DeepCollectionEquality().hash(_this.cards),_this.interpretation,_this.summary,_this.advice,_this.notes,_this.isFavorite,_this.journeyRecall,_this.elementalChemistry,_this.cosmicWeather,const DeepCollectionEquality().hash(_this.scryingPrompts),_this.personaId,_this.altarConsecration,_this.microRitual,_this.createdAt);
}

@override
String toString() {
  final _this = this as Reading;
  return 'Reading(id: ${_this.id}, userId: ${_this.userId}, question: ${_this.question}, spreadType: ${_this.spreadType}, cards: ${_this.cards}, interpretation: ${_this.interpretation}, summary: ${_this.summary}, advice: ${_this.advice}, notes: ${_this.notes}, isFavorite: ${_this.isFavorite}, journeyRecall: ${_this.journeyRecall}, elementalChemistry: ${_this.elementalChemistry}, cosmicWeather: ${_this.cosmicWeather}, scryingPrompts: ${_this.scryingPrompts}, personaId: ${_this.personaId}, altarConsecration: ${_this.altarConsecration}, microRitual: ${_this.microRitual}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ReadingCopyWith<$Res>  {
  factory $ReadingCopyWith(Reading value, $Res Function(Reading) _then) = _$ReadingCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String? userId, String question,@JsonKey(name: 'spread_type') String spreadType, List<TarotCard> cards, String interpretation, String? summary, String? advice, String notes,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'journey_recall') String? journeyRecall,@JsonKey(name: 'elemental_chemistry') String? elementalChemistry,@JsonKey(name: 'cosmic_weather') String? cosmicWeather,@JsonKey(name: 'scrying_prompts') List<String> scryingPrompts,@JsonKey(name: 'persona_id') String? personaId,@JsonKey(name: 'altar_consecration') String? altarConsecration,@JsonKey(name: 'micro_ritual') String? microRitual,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$ReadingCopyWithImpl<$Res>
    implements $ReadingCopyWith<$Res> {
  _$ReadingCopyWithImpl(this._self, this._then);

  final Reading _self;
  final $Res Function(Reading) _then;

/// Create a copy of Reading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? question = null,Object? spreadType = null,Object? cards = null,Object? interpretation = null,Object? summary = freezed,Object? advice = freezed,Object? notes = null,Object? isFavorite = null,Object? journeyRecall = freezed,Object? elementalChemistry = freezed,Object? cosmicWeather = freezed,Object? scryingPrompts = null,Object? personaId = freezed,Object? altarConsecration = freezed,Object? microRitual = freezed,Object? createdAt = null,}) {
  return _then(Reading(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,spreadType: null == spreadType ? _self.spreadType : spreadType // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<TarotCard>,interpretation: null == interpretation ? _self.interpretation : interpretation // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,advice: freezed == advice ? _self.advice : advice // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,journeyRecall: freezed == journeyRecall ? _self.journeyRecall : journeyRecall // ignore: cast_nullable_to_non_nullable
as String?,elementalChemistry: freezed == elementalChemistry ? _self.elementalChemistry : elementalChemistry // ignore: cast_nullable_to_non_nullable
as String?,cosmicWeather: freezed == cosmicWeather ? _self.cosmicWeather : cosmicWeather // ignore: cast_nullable_to_non_nullable
as String?,scryingPrompts: null == scryingPrompts ? _self.scryingPrompts : scryingPrompts // ignore: cast_nullable_to_non_nullable
as List<String>,personaId: freezed == personaId ? _self.personaId : personaId // ignore: cast_nullable_to_non_nullable
as String?,altarConsecration: freezed == altarConsecration ? _self.altarConsecration : altarConsecration // ignore: cast_nullable_to_non_nullable
as String?,microRitual: freezed == microRitual ? _self.microRitual : microRitual // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Reading].
extension ReadingPatterns on Reading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reading value)  $default,){
final _that = this;
switch (_that) {
case _Reading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reading value)?  $default,){
final _that = this;
switch (_that) {
case _Reading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String? userId,  String question, @JsonKey(name: 'spread_type')  String spreadType,  List<TarotCard> cards,  String interpretation,  String? summary,  String? advice,  String notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'journey_recall')  String? journeyRecall, @JsonKey(name: 'elemental_chemistry')  String? elementalChemistry, @JsonKey(name: 'cosmic_weather')  String? cosmicWeather, @JsonKey(name: 'scrying_prompts')  List<String> scryingPrompts, @JsonKey(name: 'persona_id')  String? personaId, @JsonKey(name: 'altar_consecration')  String? altarConsecration, @JsonKey(name: 'micro_ritual')  String? microRitual, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reading() when $default != null:
return $default(_that.id,_that.userId,_that.question,_that.spreadType,_that.cards,_that.interpretation,_that.summary,_that.advice,_that.notes,_that.isFavorite,_that.journeyRecall,_that.elementalChemistry,_that.cosmicWeather,_that.scryingPrompts,_that.personaId,_that.altarConsecration,_that.microRitual,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String? userId,  String question, @JsonKey(name: 'spread_type')  String spreadType,  List<TarotCard> cards,  String interpretation,  String? summary,  String? advice,  String notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'journey_recall')  String? journeyRecall, @JsonKey(name: 'elemental_chemistry')  String? elementalChemistry, @JsonKey(name: 'cosmic_weather')  String? cosmicWeather, @JsonKey(name: 'scrying_prompts')  List<String> scryingPrompts, @JsonKey(name: 'persona_id')  String? personaId, @JsonKey(name: 'altar_consecration')  String? altarConsecration, @JsonKey(name: 'micro_ritual')  String? microRitual, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Reading():
return $default(_that.id,_that.userId,_that.question,_that.spreadType,_that.cards,_that.interpretation,_that.summary,_that.advice,_that.notes,_that.isFavorite,_that.journeyRecall,_that.elementalChemistry,_that.cosmicWeather,_that.scryingPrompts,_that.personaId,_that.altarConsecration,_that.microRitual,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String? userId,  String question, @JsonKey(name: 'spread_type')  String spreadType,  List<TarotCard> cards,  String interpretation,  String? summary,  String? advice,  String notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'journey_recall')  String? journeyRecall, @JsonKey(name: 'elemental_chemistry')  String? elementalChemistry, @JsonKey(name: 'cosmic_weather')  String? cosmicWeather, @JsonKey(name: 'scrying_prompts')  List<String> scryingPrompts, @JsonKey(name: 'persona_id')  String? personaId, @JsonKey(name: 'altar_consecration')  String? altarConsecration, @JsonKey(name: 'micro_ritual')  String? microRitual, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Reading() when $default != null:
return $default(_that.id,_that.userId,_that.question,_that.spreadType,_that.cards,_that.interpretation,_that.summary,_that.advice,_that.notes,_that.isFavorite,_that.journeyRecall,_that.elementalChemistry,_that.cosmicWeather,_that.scryingPrompts,_that.personaId,_that.altarConsecration,_that.microRitual,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reading implements Reading {
  const _Reading({required this.id, @JsonKey(name: 'user_id') this.userId, required this.question, @JsonKey(name: 'spread_type') required this.spreadType, required  List<TarotCard> cards, required this.interpretation, this.summary, this.advice, this.notes = '', @JsonKey(name: 'is_favorite') this.isFavorite = false, @JsonKey(name: 'journey_recall') this.journeyRecall, @JsonKey(name: 'elemental_chemistry') this.elementalChemistry, @JsonKey(name: 'cosmic_weather') this.cosmicWeather, @JsonKey(name: 'scrying_prompts')  List<String> scryingPrompts = const [], @JsonKey(name: 'persona_id') this.personaId, @JsonKey(name: 'altar_consecration') this.altarConsecration, @JsonKey(name: 'micro_ritual') this.microRitual, @JsonKey(name: 'created_at') required this.createdAt}): _cards = cards,_scryingPrompts = scryingPrompts;
  factory _Reading.fromJson(Map<String, dynamic> json) => _$ReadingFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String? userId;
@override final  String question;
@override@JsonKey(name: 'spread_type') final  String spreadType;
 final  List<TarotCard> _cards;
@override List<TarotCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override final  String interpretation;
@override final  String? summary;
@override final  String? advice;
@override@JsonKey() final  String notes;
@override@JsonKey(name: 'is_favorite') final  bool isFavorite;
@override@JsonKey(name: 'journey_recall') final  String? journeyRecall;
@override@JsonKey(name: 'elemental_chemistry') final  String? elementalChemistry;
@override@JsonKey(name: 'cosmic_weather') final  String? cosmicWeather;
 final  List<String> _scryingPrompts;
@override@JsonKey(name: 'scrying_prompts') List<String> get scryingPrompts {
  if (_scryingPrompts is EqualUnmodifiableListView) return _scryingPrompts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scryingPrompts);
}

@override@JsonKey(name: 'persona_id') final  String? personaId;
@override@JsonKey(name: 'altar_consecration') final  String? altarConsecration;
@override@JsonKey(name: 'micro_ritual') final  String? microRitual;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of Reading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingCopyWith<_Reading> get copyWith => __$ReadingCopyWithImpl<_Reading>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reading&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.question, question) || other.question == question)&&(identical(other.spreadType, spreadType) || other.spreadType == spreadType)&&const DeepCollectionEquality().equals(other.cards, _cards)&&(identical(other.interpretation, interpretation) || other.interpretation == interpretation)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.advice, advice) || other.advice == advice)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.journeyRecall, journeyRecall) || other.journeyRecall == journeyRecall)&&(identical(other.elementalChemistry, elementalChemistry) || other.elementalChemistry == elementalChemistry)&&(identical(other.cosmicWeather, cosmicWeather) || other.cosmicWeather == cosmicWeather)&&const DeepCollectionEquality().equals(other.scryingPrompts, _scryingPrompts)&&(identical(other.personaId, personaId) || other.personaId == personaId)&&(identical(other.altarConsecration, altarConsecration) || other.altarConsecration == altarConsecration)&&(identical(other.microRitual, microRitual) || other.microRitual == microRitual)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,question,spreadType,const DeepCollectionEquality().hash(_cards),interpretation,summary,advice,notes,isFavorite,journeyRecall,elementalChemistry,cosmicWeather,const DeepCollectionEquality().hash(_scryingPrompts),personaId,altarConsecration,microRitual,createdAt);
}

@override
String toString() {
    return 'Reading(id: $id, userId: $userId, question: $question, spreadType: $spreadType, cards: $cards, interpretation: $interpretation, summary: $summary, advice: $advice, notes: $notes, isFavorite: $isFavorite, journeyRecall: $journeyRecall, elementalChemistry: $elementalChemistry, cosmicWeather: $cosmicWeather, scryingPrompts: $scryingPrompts, personaId: $personaId, altarConsecration: $altarConsecration, microRitual: $microRitual, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReadingCopyWith<$Res> implements $ReadingCopyWith<$Res> {
  factory _$ReadingCopyWith(_Reading value, $Res Function(_Reading) _then) = __$ReadingCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String? userId, String question,@JsonKey(name: 'spread_type') String spreadType, List<TarotCard> cards, String interpretation, String? summary, String? advice, String notes,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'journey_recall') String? journeyRecall,@JsonKey(name: 'elemental_chemistry') String? elementalChemistry,@JsonKey(name: 'cosmic_weather') String? cosmicWeather,@JsonKey(name: 'scrying_prompts') List<String> scryingPrompts,@JsonKey(name: 'persona_id') String? personaId,@JsonKey(name: 'altar_consecration') String? altarConsecration,@JsonKey(name: 'micro_ritual') String? microRitual,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$ReadingCopyWithImpl<$Res>
    implements _$ReadingCopyWith<$Res> {
  __$ReadingCopyWithImpl(this._self, this._then);

  final _Reading _self;
  final $Res Function(_Reading) _then;

/// Create a copy of Reading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? question = null,Object? spreadType = null,Object? cards = null,Object? interpretation = null,Object? summary = freezed,Object? advice = freezed,Object? notes = null,Object? isFavorite = null,Object? journeyRecall = freezed,Object? elementalChemistry = freezed,Object? cosmicWeather = freezed,Object? scryingPrompts = null,Object? personaId = freezed,Object? altarConsecration = freezed,Object? microRitual = freezed,Object? createdAt = null,}) {
  return _then(_Reading(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,spreadType: null == spreadType ? _self.spreadType : spreadType // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<TarotCard>,interpretation: null == interpretation ? _self.interpretation : interpretation // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,advice: freezed == advice ? _self.advice : advice // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,journeyRecall: freezed == journeyRecall ? _self.journeyRecall : journeyRecall // ignore: cast_nullable_to_non_nullable
as String?,elementalChemistry: freezed == elementalChemistry ? _self.elementalChemistry : elementalChemistry // ignore: cast_nullable_to_non_nullable
as String?,cosmicWeather: freezed == cosmicWeather ? _self.cosmicWeather : cosmicWeather // ignore: cast_nullable_to_non_nullable
as String?,scryingPrompts: null == scryingPrompts ? _self._scryingPrompts : scryingPrompts // ignore: cast_nullable_to_non_nullable
as List<String>,personaId: freezed == personaId ? _self.personaId : personaId // ignore: cast_nullable_to_non_nullable
as String?,altarConsecration: freezed == altarConsecration ? _self.altarConsecration : altarConsecration // ignore: cast_nullable_to_non_nullable
as String?,microRitual: freezed == microRitual ? _self.microRitual : microRitual // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
