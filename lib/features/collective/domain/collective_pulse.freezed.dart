// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collective_pulse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollectiveWish {

 String get id; String get intention; String get zodiacSign; DateTime get createdAt;
/// Create a copy of CollectiveWish
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectiveWishCopyWith<CollectiveWish> get copyWith => _$CollectiveWishCopyWithImpl<CollectiveWish>(this as CollectiveWish, _$identity);

  /// Serializes this CollectiveWish to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CollectiveWish;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectiveWish&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.intention, _this.intention) || other.intention == _this.intention)&&(identical(other.zodiacSign, _this.zodiacSign) || other.zodiacSign == _this.zodiacSign)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CollectiveWish;
  return Object.hash(runtimeType,_this.id,_this.intention,_this.zodiacSign,_this.createdAt);
}

@override
String toString() {
  final _this = this as CollectiveWish;
  return 'CollectiveWish(id: ${_this.id}, intention: ${_this.intention}, zodiacSign: ${_this.zodiacSign}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CollectiveWishCopyWith<$Res>  {
  factory $CollectiveWishCopyWith(CollectiveWish value, $Res Function(CollectiveWish) _then) = _$CollectiveWishCopyWithImpl;
@useResult
$Res call({
 String id, String intention, String zodiacSign, DateTime createdAt
});




}
/// @nodoc
class _$CollectiveWishCopyWithImpl<$Res>
    implements $CollectiveWishCopyWith<$Res> {
  _$CollectiveWishCopyWithImpl(this._self, this._then);

  final CollectiveWish _self;
  final $Res Function(CollectiveWish) _then;

/// Create a copy of CollectiveWish
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? intention = null,Object? zodiacSign = null,Object? createdAt = null,}) {
  return _then(CollectiveWish(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,intention: null == intention ? _self.intention : intention // ignore: cast_nullable_to_non_nullable
as String,zodiacSign: null == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectiveWish].
extension CollectiveWishPatterns on CollectiveWish {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectiveWish value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectiveWish() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectiveWish value)  $default,){
final _that = this;
switch (_that) {
case _CollectiveWish():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectiveWish value)?  $default,){
final _that = this;
switch (_that) {
case _CollectiveWish() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String intention,  String zodiacSign,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectiveWish() when $default != null:
return $default(_that.id,_that.intention,_that.zodiacSign,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String intention,  String zodiacSign,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CollectiveWish():
return $default(_that.id,_that.intention,_that.zodiacSign,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String intention,  String zodiacSign,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CollectiveWish() when $default != null:
return $default(_that.id,_that.intention,_that.zodiacSign,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectiveWish implements CollectiveWish {
  const _CollectiveWish({required this.id, required this.intention, required this.zodiacSign, required this.createdAt});
  factory _CollectiveWish.fromJson(Map<String, dynamic> json) => _$CollectiveWishFromJson(json);

@override final  String id;
@override final  String intention;
@override final  String zodiacSign;
@override final  DateTime createdAt;

/// Create a copy of CollectiveWish
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectiveWishCopyWith<_CollectiveWish> get copyWith => __$CollectiveWishCopyWithImpl<_CollectiveWish>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectiveWishToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectiveWish&&(identical(other.id, id) || other.id == id)&&(identical(other.intention, intention) || other.intention == intention)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,intention,zodiacSign,createdAt);
}

@override
String toString() {
    return 'CollectiveWish(id: $id, intention: $intention, zodiacSign: $zodiacSign, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CollectiveWishCopyWith<$Res> implements $CollectiveWishCopyWith<$Res> {
  factory _$CollectiveWishCopyWith(_CollectiveWish value, $Res Function(_CollectiveWish) _then) = __$CollectiveWishCopyWithImpl;
@override @useResult
$Res call({
 String id, String intention, String zodiacSign, DateTime createdAt
});




}
/// @nodoc
class __$CollectiveWishCopyWithImpl<$Res>
    implements _$CollectiveWishCopyWith<$Res> {
  __$CollectiveWishCopyWithImpl(this._self, this._then);

  final _CollectiveWish _self;
  final $Res Function(_CollectiveWish) _then;

/// Create a copy of CollectiveWish
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? intention = null,Object? zodiacSign = null,Object? createdAt = null,}) {
  return _then(_CollectiveWish(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,intention: null == intention ? _self.intention : intention // ignore: cast_nullable_to_non_nullable
as String,zodiacSign: null == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CollectivePulse {

 String get dominantGlobalCardName; String get dominantCardArcana; String get dominantAuraEnergy; int get totalReadingsToday; List<String> get topDrawnCards; List<CollectiveWish> get recentWishes;
/// Create a copy of CollectivePulse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectivePulseCopyWith<CollectivePulse> get copyWith => _$CollectivePulseCopyWithImpl<CollectivePulse>(this as CollectivePulse, _$identity);

  /// Serializes this CollectivePulse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CollectivePulse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectivePulse&&(identical(other.dominantGlobalCardName, _this.dominantGlobalCardName) || other.dominantGlobalCardName == _this.dominantGlobalCardName)&&(identical(other.dominantCardArcana, _this.dominantCardArcana) || other.dominantCardArcana == _this.dominantCardArcana)&&(identical(other.dominantAuraEnergy, _this.dominantAuraEnergy) || other.dominantAuraEnergy == _this.dominantAuraEnergy)&&(identical(other.totalReadingsToday, _this.totalReadingsToday) || other.totalReadingsToday == _this.totalReadingsToday)&&const DeepCollectionEquality().equals(other.topDrawnCards, _this.topDrawnCards)&&const DeepCollectionEquality().equals(other.recentWishes, _this.recentWishes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CollectivePulse;
  return Object.hash(runtimeType,_this.dominantGlobalCardName,_this.dominantCardArcana,_this.dominantAuraEnergy,_this.totalReadingsToday,const DeepCollectionEquality().hash(_this.topDrawnCards),const DeepCollectionEquality().hash(_this.recentWishes));
}

@override
String toString() {
  final _this = this as CollectivePulse;
  return 'CollectivePulse(dominantGlobalCardName: ${_this.dominantGlobalCardName}, dominantCardArcana: ${_this.dominantCardArcana}, dominantAuraEnergy: ${_this.dominantAuraEnergy}, totalReadingsToday: ${_this.totalReadingsToday}, topDrawnCards: ${_this.topDrawnCards}, recentWishes: ${_this.recentWishes})';
}


}

/// @nodoc
abstract mixin class $CollectivePulseCopyWith<$Res>  {
  factory $CollectivePulseCopyWith(CollectivePulse value, $Res Function(CollectivePulse) _then) = _$CollectivePulseCopyWithImpl;
@useResult
$Res call({
 String dominantGlobalCardName, String dominantCardArcana, String dominantAuraEnergy, int totalReadingsToday, List<String> topDrawnCards, List<CollectiveWish> recentWishes
});




}
/// @nodoc
class _$CollectivePulseCopyWithImpl<$Res>
    implements $CollectivePulseCopyWith<$Res> {
  _$CollectivePulseCopyWithImpl(this._self, this._then);

  final CollectivePulse _self;
  final $Res Function(CollectivePulse) _then;

/// Create a copy of CollectivePulse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dominantGlobalCardName = null,Object? dominantCardArcana = null,Object? dominantAuraEnergy = null,Object? totalReadingsToday = null,Object? topDrawnCards = null,Object? recentWishes = null,}) {
  return _then(CollectivePulse(
dominantGlobalCardName: null == dominantGlobalCardName ? _self.dominantGlobalCardName : dominantGlobalCardName // ignore: cast_nullable_to_non_nullable
as String,dominantCardArcana: null == dominantCardArcana ? _self.dominantCardArcana : dominantCardArcana // ignore: cast_nullable_to_non_nullable
as String,dominantAuraEnergy: null == dominantAuraEnergy ? _self.dominantAuraEnergy : dominantAuraEnergy // ignore: cast_nullable_to_non_nullable
as String,totalReadingsToday: null == totalReadingsToday ? _self.totalReadingsToday : totalReadingsToday // ignore: cast_nullable_to_non_nullable
as int,topDrawnCards: null == topDrawnCards ? _self.topDrawnCards : topDrawnCards // ignore: cast_nullable_to_non_nullable
as List<String>,recentWishes: null == recentWishes ? _self.recentWishes : recentWishes // ignore: cast_nullable_to_non_nullable
as List<CollectiveWish>,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectivePulse].
extension CollectivePulsePatterns on CollectivePulse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectivePulse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectivePulse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectivePulse value)  $default,){
final _that = this;
switch (_that) {
case _CollectivePulse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectivePulse value)?  $default,){
final _that = this;
switch (_that) {
case _CollectivePulse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dominantGlobalCardName,  String dominantCardArcana,  String dominantAuraEnergy,  int totalReadingsToday,  List<String> topDrawnCards,  List<CollectiveWish> recentWishes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectivePulse() when $default != null:
return $default(_that.dominantGlobalCardName,_that.dominantCardArcana,_that.dominantAuraEnergy,_that.totalReadingsToday,_that.topDrawnCards,_that.recentWishes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dominantGlobalCardName,  String dominantCardArcana,  String dominantAuraEnergy,  int totalReadingsToday,  List<String> topDrawnCards,  List<CollectiveWish> recentWishes)  $default,) {final _that = this;
switch (_that) {
case _CollectivePulse():
return $default(_that.dominantGlobalCardName,_that.dominantCardArcana,_that.dominantAuraEnergy,_that.totalReadingsToday,_that.topDrawnCards,_that.recentWishes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dominantGlobalCardName,  String dominantCardArcana,  String dominantAuraEnergy,  int totalReadingsToday,  List<String> topDrawnCards,  List<CollectiveWish> recentWishes)?  $default,) {final _that = this;
switch (_that) {
case _CollectivePulse() when $default != null:
return $default(_that.dominantGlobalCardName,_that.dominantCardArcana,_that.dominantAuraEnergy,_that.totalReadingsToday,_that.topDrawnCards,_that.recentWishes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectivePulse implements CollectivePulse {
  const _CollectivePulse({required this.dominantGlobalCardName, required this.dominantCardArcana, required this.dominantAuraEnergy, required this.totalReadingsToday, required  List<String> topDrawnCards, required  List<CollectiveWish> recentWishes}): _topDrawnCards = topDrawnCards,_recentWishes = recentWishes;
  factory _CollectivePulse.fromJson(Map<String, dynamic> json) => _$CollectivePulseFromJson(json);

@override final  String dominantGlobalCardName;
@override final  String dominantCardArcana;
@override final  String dominantAuraEnergy;
@override final  int totalReadingsToday;
 final  List<String> _topDrawnCards;
@override List<String> get topDrawnCards {
  if (_topDrawnCards is EqualUnmodifiableListView) return _topDrawnCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topDrawnCards);
}

 final  List<CollectiveWish> _recentWishes;
@override List<CollectiveWish> get recentWishes {
  if (_recentWishes is EqualUnmodifiableListView) return _recentWishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentWishes);
}


/// Create a copy of CollectivePulse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectivePulseCopyWith<_CollectivePulse> get copyWith => __$CollectivePulseCopyWithImpl<_CollectivePulse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectivePulseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectivePulse&&(identical(other.dominantGlobalCardName, dominantGlobalCardName) || other.dominantGlobalCardName == dominantGlobalCardName)&&(identical(other.dominantCardArcana, dominantCardArcana) || other.dominantCardArcana == dominantCardArcana)&&(identical(other.dominantAuraEnergy, dominantAuraEnergy) || other.dominantAuraEnergy == dominantAuraEnergy)&&(identical(other.totalReadingsToday, totalReadingsToday) || other.totalReadingsToday == totalReadingsToday)&&const DeepCollectionEquality().equals(other.topDrawnCards, _topDrawnCards)&&const DeepCollectionEquality().equals(other.recentWishes, _recentWishes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dominantGlobalCardName,dominantCardArcana,dominantAuraEnergy,totalReadingsToday,const DeepCollectionEquality().hash(_topDrawnCards),const DeepCollectionEquality().hash(_recentWishes));
}

@override
String toString() {
    return 'CollectivePulse(dominantGlobalCardName: $dominantGlobalCardName, dominantCardArcana: $dominantCardArcana, dominantAuraEnergy: $dominantAuraEnergy, totalReadingsToday: $totalReadingsToday, topDrawnCards: $topDrawnCards, recentWishes: $recentWishes)';
}


}

/// @nodoc
abstract mixin class _$CollectivePulseCopyWith<$Res> implements $CollectivePulseCopyWith<$Res> {
  factory _$CollectivePulseCopyWith(_CollectivePulse value, $Res Function(_CollectivePulse) _then) = __$CollectivePulseCopyWithImpl;
@override @useResult
$Res call({
 String dominantGlobalCardName, String dominantCardArcana, String dominantAuraEnergy, int totalReadingsToday, List<String> topDrawnCards, List<CollectiveWish> recentWishes
});




}
/// @nodoc
class __$CollectivePulseCopyWithImpl<$Res>
    implements _$CollectivePulseCopyWith<$Res> {
  __$CollectivePulseCopyWithImpl(this._self, this._then);

  final _CollectivePulse _self;
  final $Res Function(_CollectivePulse) _then;

/// Create a copy of CollectivePulse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dominantGlobalCardName = null,Object? dominantCardArcana = null,Object? dominantAuraEnergy = null,Object? totalReadingsToday = null,Object? topDrawnCards = null,Object? recentWishes = null,}) {
  return _then(_CollectivePulse(
dominantGlobalCardName: null == dominantGlobalCardName ? _self.dominantGlobalCardName : dominantGlobalCardName // ignore: cast_nullable_to_non_nullable
as String,dominantCardArcana: null == dominantCardArcana ? _self.dominantCardArcana : dominantCardArcana // ignore: cast_nullable_to_non_nullable
as String,dominantAuraEnergy: null == dominantAuraEnergy ? _self.dominantAuraEnergy : dominantAuraEnergy // ignore: cast_nullable_to_non_nullable
as String,totalReadingsToday: null == totalReadingsToday ? _self.totalReadingsToday : totalReadingsToday // ignore: cast_nullable_to_non_nullable
as int,topDrawnCards: null == topDrawnCards ? _self._topDrawnCards : topDrawnCards // ignore: cast_nullable_to_non_nullable
as List<String>,recentWishes: null == recentWishes ? _self._recentWishes : recentWishes // ignore: cast_nullable_to_non_nullable
as List<CollectiveWish>,
  ));
}


}

// dart format on
