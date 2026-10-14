// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tarot_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TarotCard {

 String get id; String get name; String get arcana; String? get suit; int? get number; String get meaningUpright; String get meaningReversed; List<String> get keywords; String? get element; String? get astrology; bool get isReversed; String? get positionName; String? get assetPath; String? get imageUrl;
/// Create a copy of TarotCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TarotCardCopyWith<TarotCard> get copyWith => _$TarotCardCopyWithImpl<TarotCard>(this as TarotCard, _$identity);

  /// Serializes this TarotCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TarotCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TarotCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.arcana, _this.arcana) || other.arcana == _this.arcana)&&(identical(other.suit, _this.suit) || other.suit == _this.suit)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.meaningUpright, _this.meaningUpright) || other.meaningUpright == _this.meaningUpright)&&(identical(other.meaningReversed, _this.meaningReversed) || other.meaningReversed == _this.meaningReversed)&&const DeepCollectionEquality().equals(other.keywords, _this.keywords)&&(identical(other.element, _this.element) || other.element == _this.element)&&(identical(other.astrology, _this.astrology) || other.astrology == _this.astrology)&&(identical(other.isReversed, _this.isReversed) || other.isReversed == _this.isReversed)&&(identical(other.positionName, _this.positionName) || other.positionName == _this.positionName)&&(identical(other.assetPath, _this.assetPath) || other.assetPath == _this.assetPath)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TarotCard;
  return Object.hash(runtimeType,_this.id,_this.name,_this.arcana,_this.suit,_this.number,_this.meaningUpright,_this.meaningReversed,const DeepCollectionEquality().hash(_this.keywords),_this.element,_this.astrology,_this.isReversed,_this.positionName,_this.assetPath,_this.imageUrl);
}

@override
String toString() {
  final _this = this as TarotCard;
  return 'TarotCard(id: ${_this.id}, name: ${_this.name}, arcana: ${_this.arcana}, suit: ${_this.suit}, number: ${_this.number}, meaningUpright: ${_this.meaningUpright}, meaningReversed: ${_this.meaningReversed}, keywords: ${_this.keywords}, element: ${_this.element}, astrology: ${_this.astrology}, isReversed: ${_this.isReversed}, positionName: ${_this.positionName}, assetPath: ${_this.assetPath}, imageUrl: ${_this.imageUrl})';
}


}

/// @nodoc
abstract mixin class $TarotCardCopyWith<$Res>  {
  factory $TarotCardCopyWith(TarotCard value, $Res Function(TarotCard) _then) = _$TarotCardCopyWithImpl;
@useResult
$Res call({
 String id, String name, String arcana, String? suit, int? number, String meaningUpright, String meaningReversed, List<String> keywords, String? element, String? astrology, bool isReversed, String? positionName, String? assetPath, String? imageUrl
});




}
/// @nodoc
class _$TarotCardCopyWithImpl<$Res>
    implements $TarotCardCopyWith<$Res> {
  _$TarotCardCopyWithImpl(this._self, this._then);

  final TarotCard _self;
  final $Res Function(TarotCard) _then;

/// Create a copy of TarotCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? arcana = null,Object? suit = freezed,Object? number = freezed,Object? meaningUpright = null,Object? meaningReversed = null,Object? keywords = null,Object? element = freezed,Object? astrology = freezed,Object? isReversed = null,Object? positionName = freezed,Object? assetPath = freezed,Object? imageUrl = freezed,}) {
  return _then(TarotCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,arcana: null == arcana ? _self.arcana : arcana // ignore: cast_nullable_to_non_nullable
as String,suit: freezed == suit ? _self.suit : suit // ignore: cast_nullable_to_non_nullable
as String?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int?,meaningUpright: null == meaningUpright ? _self.meaningUpright : meaningUpright // ignore: cast_nullable_to_non_nullable
as String,meaningReversed: null == meaningReversed ? _self.meaningReversed : meaningReversed // ignore: cast_nullable_to_non_nullable
as String,keywords: null == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,element: freezed == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String?,astrology: freezed == astrology ? _self.astrology : astrology // ignore: cast_nullable_to_non_nullable
as String?,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,positionName: freezed == positionName ? _self.positionName : positionName // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TarotCard].
extension TarotCardPatterns on TarotCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TarotCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TarotCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TarotCard value)  $default,){
final _that = this;
switch (_that) {
case _TarotCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TarotCard value)?  $default,){
final _that = this;
switch (_that) {
case _TarotCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String arcana,  String? suit,  int? number,  String meaningUpright,  String meaningReversed,  List<String> keywords,  String? element,  String? astrology,  bool isReversed,  String? positionName,  String? assetPath,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TarotCard() when $default != null:
return $default(_that.id,_that.name,_that.arcana,_that.suit,_that.number,_that.meaningUpright,_that.meaningReversed,_that.keywords,_that.element,_that.astrology,_that.isReversed,_that.positionName,_that.assetPath,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String arcana,  String? suit,  int? number,  String meaningUpright,  String meaningReversed,  List<String> keywords,  String? element,  String? astrology,  bool isReversed,  String? positionName,  String? assetPath,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _TarotCard():
return $default(_that.id,_that.name,_that.arcana,_that.suit,_that.number,_that.meaningUpright,_that.meaningReversed,_that.keywords,_that.element,_that.astrology,_that.isReversed,_that.positionName,_that.assetPath,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String arcana,  String? suit,  int? number,  String meaningUpright,  String meaningReversed,  List<String> keywords,  String? element,  String? astrology,  bool isReversed,  String? positionName,  String? assetPath,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _TarotCard() when $default != null:
return $default(_that.id,_that.name,_that.arcana,_that.suit,_that.number,_that.meaningUpright,_that.meaningReversed,_that.keywords,_that.element,_that.astrology,_that.isReversed,_that.positionName,_that.assetPath,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TarotCard implements TarotCard {
  const _TarotCard({required this.id, required this.name, required this.arcana, this.suit, this.number, required this.meaningUpright, required this.meaningReversed,  List<String> keywords = const [], this.element, this.astrology, this.isReversed = false, this.positionName, this.assetPath, this.imageUrl}): _keywords = keywords;
  factory _TarotCard.fromJson(Map<String, dynamic> json) => _$TarotCardFromJson(json);

@override final  String id;
@override final  String name;
@override final  String arcana;
@override final  String? suit;
@override final  int? number;
@override final  String meaningUpright;
@override final  String meaningReversed;
 final  List<String> _keywords;
@override@JsonKey() List<String> get keywords {
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keywords);
}

@override final  String? element;
@override final  String? astrology;
@override@JsonKey() final  bool isReversed;
@override final  String? positionName;
@override final  String? assetPath;
@override final  String? imageUrl;

/// Create a copy of TarotCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TarotCardCopyWith<_TarotCard> get copyWith => __$TarotCardCopyWithImpl<_TarotCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TarotCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TarotCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.arcana, arcana) || other.arcana == arcana)&&(identical(other.suit, suit) || other.suit == suit)&&(identical(other.number, number) || other.number == number)&&(identical(other.meaningUpright, meaningUpright) || other.meaningUpright == meaningUpright)&&(identical(other.meaningReversed, meaningReversed) || other.meaningReversed == meaningReversed)&&const DeepCollectionEquality().equals(other.keywords, _keywords)&&(identical(other.element, element) || other.element == element)&&(identical(other.astrology, astrology) || other.astrology == astrology)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed)&&(identical(other.positionName, positionName) || other.positionName == positionName)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,arcana,suit,number,meaningUpright,meaningReversed,const DeepCollectionEquality().hash(_keywords),element,astrology,isReversed,positionName,assetPath,imageUrl);
}

@override
String toString() {
    return 'TarotCard(id: $id, name: $name, arcana: $arcana, suit: $suit, number: $number, meaningUpright: $meaningUpright, meaningReversed: $meaningReversed, keywords: $keywords, element: $element, astrology: $astrology, isReversed: $isReversed, positionName: $positionName, assetPath: $assetPath, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$TarotCardCopyWith<$Res> implements $TarotCardCopyWith<$Res> {
  factory _$TarotCardCopyWith(_TarotCard value, $Res Function(_TarotCard) _then) = __$TarotCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String arcana, String? suit, int? number, String meaningUpright, String meaningReversed, List<String> keywords, String? element, String? astrology, bool isReversed, String? positionName, String? assetPath, String? imageUrl
});




}
/// @nodoc
class __$TarotCardCopyWithImpl<$Res>
    implements _$TarotCardCopyWith<$Res> {
  __$TarotCardCopyWithImpl(this._self, this._then);

  final _TarotCard _self;
  final $Res Function(_TarotCard) _then;

/// Create a copy of TarotCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? arcana = null,Object? suit = freezed,Object? number = freezed,Object? meaningUpright = null,Object? meaningReversed = null,Object? keywords = null,Object? element = freezed,Object? astrology = freezed,Object? isReversed = null,Object? positionName = freezed,Object? assetPath = freezed,Object? imageUrl = freezed,}) {
  return _then(_TarotCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,arcana: null == arcana ? _self.arcana : arcana // ignore: cast_nullable_to_non_nullable
as String,suit: freezed == suit ? _self.suit : suit // ignore: cast_nullable_to_non_nullable
as String?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int?,meaningUpright: null == meaningUpright ? _self.meaningUpright : meaningUpright // ignore: cast_nullable_to_non_nullable
as String,meaningReversed: null == meaningReversed ? _self.meaningReversed : meaningReversed // ignore: cast_nullable_to_non_nullable
as String,keywords: null == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,element: freezed == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String?,astrology: freezed == astrology ? _self.astrology : astrology // ignore: cast_nullable_to_non_nullable
as String?,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,positionName: freezed == positionName ? _self.positionName : positionName // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
