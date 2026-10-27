// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'celestial_transit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CelestialTransitBody {

 String get name; String get glyph; String get sign; double get degree; String get element; bool get isRetrograde; int get house; String get tarotArchetype;
/// Create a copy of CelestialTransitBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CelestialTransitBodyCopyWith<CelestialTransitBody> get copyWith => _$CelestialTransitBodyCopyWithImpl<CelestialTransitBody>(this as CelestialTransitBody, _$identity);

  /// Serializes this CelestialTransitBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CelestialTransitBody;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CelestialTransitBody&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.glyph, _this.glyph) || other.glyph == _this.glyph)&&(identical(other.sign, _this.sign) || other.sign == _this.sign)&&(identical(other.degree, _this.degree) || other.degree == _this.degree)&&(identical(other.element, _this.element) || other.element == _this.element)&&(identical(other.isRetrograde, _this.isRetrograde) || other.isRetrograde == _this.isRetrograde)&&(identical(other.house, _this.house) || other.house == _this.house)&&(identical(other.tarotArchetype, _this.tarotArchetype) || other.tarotArchetype == _this.tarotArchetype));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CelestialTransitBody;
  return Object.hash(runtimeType,_this.name,_this.glyph,_this.sign,_this.degree,_this.element,_this.isRetrograde,_this.house,_this.tarotArchetype);
}

@override
String toString() {
  final _this = this as CelestialTransitBody;
  return 'CelestialTransitBody(name: ${_this.name}, glyph: ${_this.glyph}, sign: ${_this.sign}, degree: ${_this.degree}, element: ${_this.element}, isRetrograde: ${_this.isRetrograde}, house: ${_this.house}, tarotArchetype: ${_this.tarotArchetype})';
}


}

/// @nodoc
abstract mixin class $CelestialTransitBodyCopyWith<$Res>  {
  factory $CelestialTransitBodyCopyWith(CelestialTransitBody value, $Res Function(CelestialTransitBody) _then) = _$CelestialTransitBodyCopyWithImpl;
@useResult
$Res call({
 String name, String glyph, String sign, double degree, String element, bool isRetrograde, int house, String tarotArchetype
});




}
/// @nodoc
class _$CelestialTransitBodyCopyWithImpl<$Res>
    implements $CelestialTransitBodyCopyWith<$Res> {
  _$CelestialTransitBodyCopyWithImpl(this._self, this._then);

  final CelestialTransitBody _self;
  final $Res Function(CelestialTransitBody) _then;

/// Create a copy of CelestialTransitBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? glyph = null,Object? sign = null,Object? degree = null,Object? element = null,Object? isRetrograde = null,Object? house = null,Object? tarotArchetype = null,}) {
  return _then(CelestialTransitBody(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,glyph: null == glyph ? _self.glyph : glyph // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as double,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,isRetrograde: null == isRetrograde ? _self.isRetrograde : isRetrograde // ignore: cast_nullable_to_non_nullable
as bool,house: null == house ? _self.house : house // ignore: cast_nullable_to_non_nullable
as int,tarotArchetype: null == tarotArchetype ? _self.tarotArchetype : tarotArchetype // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CelestialTransitBody].
extension CelestialTransitBodyPatterns on CelestialTransitBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CelestialTransitBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CelestialTransitBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CelestialTransitBody value)  $default,){
final _that = this;
switch (_that) {
case _CelestialTransitBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CelestialTransitBody value)?  $default,){
final _that = this;
switch (_that) {
case _CelestialTransitBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String glyph,  String sign,  double degree,  String element,  bool isRetrograde,  int house,  String tarotArchetype)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CelestialTransitBody() when $default != null:
return $default(_that.name,_that.glyph,_that.sign,_that.degree,_that.element,_that.isRetrograde,_that.house,_that.tarotArchetype);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String glyph,  String sign,  double degree,  String element,  bool isRetrograde,  int house,  String tarotArchetype)  $default,) {final _that = this;
switch (_that) {
case _CelestialTransitBody():
return $default(_that.name,_that.glyph,_that.sign,_that.degree,_that.element,_that.isRetrograde,_that.house,_that.tarotArchetype);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String glyph,  String sign,  double degree,  String element,  bool isRetrograde,  int house,  String tarotArchetype)?  $default,) {final _that = this;
switch (_that) {
case _CelestialTransitBody() when $default != null:
return $default(_that.name,_that.glyph,_that.sign,_that.degree,_that.element,_that.isRetrograde,_that.house,_that.tarotArchetype);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CelestialTransitBody implements CelestialTransitBody {
  const _CelestialTransitBody({required this.name, required this.glyph, required this.sign, required this.degree, required this.element, this.isRetrograde = false, this.house = 1, required this.tarotArchetype});
  factory _CelestialTransitBody.fromJson(Map<String, dynamic> json) => _$CelestialTransitBodyFromJson(json);

@override final  String name;
@override final  String glyph;
@override final  String sign;
@override final  double degree;
@override final  String element;
@override@JsonKey() final  bool isRetrograde;
@override@JsonKey() final  int house;
@override final  String tarotArchetype;

/// Create a copy of CelestialTransitBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CelestialTransitBodyCopyWith<_CelestialTransitBody> get copyWith => __$CelestialTransitBodyCopyWithImpl<_CelestialTransitBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CelestialTransitBodyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CelestialTransitBody&&(identical(other.name, name) || other.name == name)&&(identical(other.glyph, glyph) || other.glyph == glyph)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.element, element) || other.element == element)&&(identical(other.isRetrograde, isRetrograde) || other.isRetrograde == isRetrograde)&&(identical(other.house, house) || other.house == house)&&(identical(other.tarotArchetype, tarotArchetype) || other.tarotArchetype == tarotArchetype));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,glyph,sign,degree,element,isRetrograde,house,tarotArchetype);
}

@override
String toString() {
    return 'CelestialTransitBody(name: $name, glyph: $glyph, sign: $sign, degree: $degree, element: $element, isRetrograde: $isRetrograde, house: $house, tarotArchetype: $tarotArchetype)';
}


}

/// @nodoc
abstract mixin class _$CelestialTransitBodyCopyWith<$Res> implements $CelestialTransitBodyCopyWith<$Res> {
  factory _$CelestialTransitBodyCopyWith(_CelestialTransitBody value, $Res Function(_CelestialTransitBody) _then) = __$CelestialTransitBodyCopyWithImpl;
@override @useResult
$Res call({
 String name, String glyph, String sign, double degree, String element, bool isRetrograde, int house, String tarotArchetype
});




}
/// @nodoc
class __$CelestialTransitBodyCopyWithImpl<$Res>
    implements _$CelestialTransitBodyCopyWith<$Res> {
  __$CelestialTransitBodyCopyWithImpl(this._self, this._then);

  final _CelestialTransitBody _self;
  final $Res Function(_CelestialTransitBody) _then;

/// Create a copy of CelestialTransitBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? glyph = null,Object? sign = null,Object? degree = null,Object? element = null,Object? isRetrograde = null,Object? house = null,Object? tarotArchetype = null,}) {
  return _then(_CelestialTransitBody(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,glyph: null == glyph ? _self.glyph : glyph // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as double,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,isRetrograde: null == isRetrograde ? _self.isRetrograde : isRetrograde // ignore: cast_nullable_to_non_nullable
as bool,house: null == house ? _self.house : house // ignore: cast_nullable_to_non_nullable
as int,tarotArchetype: null == tarotArchetype ? _self.tarotArchetype : tarotArchetype // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TransitAspect {

 String get transitingPlanet; String get transitingGlyph; String get natalPlacement; String get natalGlyph; String get aspectType; String get aspectGlyph; double get orbDegrees; bool get isHarmonious; String get channelingGuidance;
/// Create a copy of TransitAspect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitAspectCopyWith<TransitAspect> get copyWith => _$TransitAspectCopyWithImpl<TransitAspect>(this as TransitAspect, _$identity);

  /// Serializes this TransitAspect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TransitAspect;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitAspect&&(identical(other.transitingPlanet, _this.transitingPlanet) || other.transitingPlanet == _this.transitingPlanet)&&(identical(other.transitingGlyph, _this.transitingGlyph) || other.transitingGlyph == _this.transitingGlyph)&&(identical(other.natalPlacement, _this.natalPlacement) || other.natalPlacement == _this.natalPlacement)&&(identical(other.natalGlyph, _this.natalGlyph) || other.natalGlyph == _this.natalGlyph)&&(identical(other.aspectType, _this.aspectType) || other.aspectType == _this.aspectType)&&(identical(other.aspectGlyph, _this.aspectGlyph) || other.aspectGlyph == _this.aspectGlyph)&&(identical(other.orbDegrees, _this.orbDegrees) || other.orbDegrees == _this.orbDegrees)&&(identical(other.isHarmonious, _this.isHarmonious) || other.isHarmonious == _this.isHarmonious)&&(identical(other.channelingGuidance, _this.channelingGuidance) || other.channelingGuidance == _this.channelingGuidance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TransitAspect;
  return Object.hash(runtimeType,_this.transitingPlanet,_this.transitingGlyph,_this.natalPlacement,_this.natalGlyph,_this.aspectType,_this.aspectGlyph,_this.orbDegrees,_this.isHarmonious,_this.channelingGuidance);
}

@override
String toString() {
  final _this = this as TransitAspect;
  return 'TransitAspect(transitingPlanet: ${_this.transitingPlanet}, transitingGlyph: ${_this.transitingGlyph}, natalPlacement: ${_this.natalPlacement}, natalGlyph: ${_this.natalGlyph}, aspectType: ${_this.aspectType}, aspectGlyph: ${_this.aspectGlyph}, orbDegrees: ${_this.orbDegrees}, isHarmonious: ${_this.isHarmonious}, channelingGuidance: ${_this.channelingGuidance})';
}


}

/// @nodoc
abstract mixin class $TransitAspectCopyWith<$Res>  {
  factory $TransitAspectCopyWith(TransitAspect value, $Res Function(TransitAspect) _then) = _$TransitAspectCopyWithImpl;
@useResult
$Res call({
 String transitingPlanet, String transitingGlyph, String natalPlacement, String natalGlyph, String aspectType, String aspectGlyph, double orbDegrees, bool isHarmonious, String channelingGuidance
});




}
/// @nodoc
class _$TransitAspectCopyWithImpl<$Res>
    implements $TransitAspectCopyWith<$Res> {
  _$TransitAspectCopyWithImpl(this._self, this._then);

  final TransitAspect _self;
  final $Res Function(TransitAspect) _then;

/// Create a copy of TransitAspect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transitingPlanet = null,Object? transitingGlyph = null,Object? natalPlacement = null,Object? natalGlyph = null,Object? aspectType = null,Object? aspectGlyph = null,Object? orbDegrees = null,Object? isHarmonious = null,Object? channelingGuidance = null,}) {
  return _then(TransitAspect(
transitingPlanet: null == transitingPlanet ? _self.transitingPlanet : transitingPlanet // ignore: cast_nullable_to_non_nullable
as String,transitingGlyph: null == transitingGlyph ? _self.transitingGlyph : transitingGlyph // ignore: cast_nullable_to_non_nullable
as String,natalPlacement: null == natalPlacement ? _self.natalPlacement : natalPlacement // ignore: cast_nullable_to_non_nullable
as String,natalGlyph: null == natalGlyph ? _self.natalGlyph : natalGlyph // ignore: cast_nullable_to_non_nullable
as String,aspectType: null == aspectType ? _self.aspectType : aspectType // ignore: cast_nullable_to_non_nullable
as String,aspectGlyph: null == aspectGlyph ? _self.aspectGlyph : aspectGlyph // ignore: cast_nullable_to_non_nullable
as String,orbDegrees: null == orbDegrees ? _self.orbDegrees : orbDegrees // ignore: cast_nullable_to_non_nullable
as double,isHarmonious: null == isHarmonious ? _self.isHarmonious : isHarmonious // ignore: cast_nullable_to_non_nullable
as bool,channelingGuidance: null == channelingGuidance ? _self.channelingGuidance : channelingGuidance // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TransitAspect].
extension TransitAspectPatterns on TransitAspect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitAspect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitAspect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitAspect value)  $default,){
final _that = this;
switch (_that) {
case _TransitAspect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitAspect value)?  $default,){
final _that = this;
switch (_that) {
case _TransitAspect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transitingPlanet,  String transitingGlyph,  String natalPlacement,  String natalGlyph,  String aspectType,  String aspectGlyph,  double orbDegrees,  bool isHarmonious,  String channelingGuidance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitAspect() when $default != null:
return $default(_that.transitingPlanet,_that.transitingGlyph,_that.natalPlacement,_that.natalGlyph,_that.aspectType,_that.aspectGlyph,_that.orbDegrees,_that.isHarmonious,_that.channelingGuidance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transitingPlanet,  String transitingGlyph,  String natalPlacement,  String natalGlyph,  String aspectType,  String aspectGlyph,  double orbDegrees,  bool isHarmonious,  String channelingGuidance)  $default,) {final _that = this;
switch (_that) {
case _TransitAspect():
return $default(_that.transitingPlanet,_that.transitingGlyph,_that.natalPlacement,_that.natalGlyph,_that.aspectType,_that.aspectGlyph,_that.orbDegrees,_that.isHarmonious,_that.channelingGuidance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transitingPlanet,  String transitingGlyph,  String natalPlacement,  String natalGlyph,  String aspectType,  String aspectGlyph,  double orbDegrees,  bool isHarmonious,  String channelingGuidance)?  $default,) {final _that = this;
switch (_that) {
case _TransitAspect() when $default != null:
return $default(_that.transitingPlanet,_that.transitingGlyph,_that.natalPlacement,_that.natalGlyph,_that.aspectType,_that.aspectGlyph,_that.orbDegrees,_that.isHarmonious,_that.channelingGuidance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransitAspect implements TransitAspect {
  const _TransitAspect({required this.transitingPlanet, required this.transitingGlyph, required this.natalPlacement, required this.natalGlyph, required this.aspectType, required this.aspectGlyph, required this.orbDegrees, required this.isHarmonious, required this.channelingGuidance});
  factory _TransitAspect.fromJson(Map<String, dynamic> json) => _$TransitAspectFromJson(json);

@override final  String transitingPlanet;
@override final  String transitingGlyph;
@override final  String natalPlacement;
@override final  String natalGlyph;
@override final  String aspectType;
@override final  String aspectGlyph;
@override final  double orbDegrees;
@override final  bool isHarmonious;
@override final  String channelingGuidance;

/// Create a copy of TransitAspect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitAspectCopyWith<_TransitAspect> get copyWith => __$TransitAspectCopyWithImpl<_TransitAspect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransitAspectToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitAspect&&(identical(other.transitingPlanet, transitingPlanet) || other.transitingPlanet == transitingPlanet)&&(identical(other.transitingGlyph, transitingGlyph) || other.transitingGlyph == transitingGlyph)&&(identical(other.natalPlacement, natalPlacement) || other.natalPlacement == natalPlacement)&&(identical(other.natalGlyph, natalGlyph) || other.natalGlyph == natalGlyph)&&(identical(other.aspectType, aspectType) || other.aspectType == aspectType)&&(identical(other.aspectGlyph, aspectGlyph) || other.aspectGlyph == aspectGlyph)&&(identical(other.orbDegrees, orbDegrees) || other.orbDegrees == orbDegrees)&&(identical(other.isHarmonious, isHarmonious) || other.isHarmonious == isHarmonious)&&(identical(other.channelingGuidance, channelingGuidance) || other.channelingGuidance == channelingGuidance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,transitingPlanet,transitingGlyph,natalPlacement,natalGlyph,aspectType,aspectGlyph,orbDegrees,isHarmonious,channelingGuidance);
}

@override
String toString() {
    return 'TransitAspect(transitingPlanet: $transitingPlanet, transitingGlyph: $transitingGlyph, natalPlacement: $natalPlacement, natalGlyph: $natalGlyph, aspectType: $aspectType, aspectGlyph: $aspectGlyph, orbDegrees: $orbDegrees, isHarmonious: $isHarmonious, channelingGuidance: $channelingGuidance)';
}


}

/// @nodoc
abstract mixin class _$TransitAspectCopyWith<$Res> implements $TransitAspectCopyWith<$Res> {
  factory _$TransitAspectCopyWith(_TransitAspect value, $Res Function(_TransitAspect) _then) = __$TransitAspectCopyWithImpl;
@override @useResult
$Res call({
 String transitingPlanet, String transitingGlyph, String natalPlacement, String natalGlyph, String aspectType, String aspectGlyph, double orbDegrees, bool isHarmonious, String channelingGuidance
});




}
/// @nodoc
class __$TransitAspectCopyWithImpl<$Res>
    implements _$TransitAspectCopyWith<$Res> {
  __$TransitAspectCopyWithImpl(this._self, this._then);

  final _TransitAspect _self;
  final $Res Function(_TransitAspect) _then;

/// Create a copy of TransitAspect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transitingPlanet = null,Object? transitingGlyph = null,Object? natalPlacement = null,Object? natalGlyph = null,Object? aspectType = null,Object? aspectGlyph = null,Object? orbDegrees = null,Object? isHarmonious = null,Object? channelingGuidance = null,}) {
  return _then(_TransitAspect(
transitingPlanet: null == transitingPlanet ? _self.transitingPlanet : transitingPlanet // ignore: cast_nullable_to_non_nullable
as String,transitingGlyph: null == transitingGlyph ? _self.transitingGlyph : transitingGlyph // ignore: cast_nullable_to_non_nullable
as String,natalPlacement: null == natalPlacement ? _self.natalPlacement : natalPlacement // ignore: cast_nullable_to_non_nullable
as String,natalGlyph: null == natalGlyph ? _self.natalGlyph : natalGlyph // ignore: cast_nullable_to_non_nullable
as String,aspectType: null == aspectType ? _self.aspectType : aspectType // ignore: cast_nullable_to_non_nullable
as String,aspectGlyph: null == aspectGlyph ? _self.aspectGlyph : aspectGlyph // ignore: cast_nullable_to_non_nullable
as String,orbDegrees: null == orbDegrees ? _self.orbDegrees : orbDegrees // ignore: cast_nullable_to_non_nullable
as double,isHarmonious: null == isHarmonious ? _self.isHarmonious : isHarmonious // ignore: cast_nullable_to_non_nullable
as bool,channelingGuidance: null == channelingGuidance ? _self.channelingGuidance : channelingGuidance // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PlanetaryHour {

 String get planetName; String get planetGlyph; String get dayRuler; int get hourIndex; bool get isDayHour; String get rulingElement; String get sacredVibration; String get consecrationMantra; String get recommendedSpread;
/// Create a copy of PlanetaryHour
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanetaryHourCopyWith<PlanetaryHour> get copyWith => _$PlanetaryHourCopyWithImpl<PlanetaryHour>(this as PlanetaryHour, _$identity);

  /// Serializes this PlanetaryHour to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanetaryHour;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanetaryHour&&(identical(other.planetName, _this.planetName) || other.planetName == _this.planetName)&&(identical(other.planetGlyph, _this.planetGlyph) || other.planetGlyph == _this.planetGlyph)&&(identical(other.dayRuler, _this.dayRuler) || other.dayRuler == _this.dayRuler)&&(identical(other.hourIndex, _this.hourIndex) || other.hourIndex == _this.hourIndex)&&(identical(other.isDayHour, _this.isDayHour) || other.isDayHour == _this.isDayHour)&&(identical(other.rulingElement, _this.rulingElement) || other.rulingElement == _this.rulingElement)&&(identical(other.sacredVibration, _this.sacredVibration) || other.sacredVibration == _this.sacredVibration)&&(identical(other.consecrationMantra, _this.consecrationMantra) || other.consecrationMantra == _this.consecrationMantra)&&(identical(other.recommendedSpread, _this.recommendedSpread) || other.recommendedSpread == _this.recommendedSpread));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanetaryHour;
  return Object.hash(runtimeType,_this.planetName,_this.planetGlyph,_this.dayRuler,_this.hourIndex,_this.isDayHour,_this.rulingElement,_this.sacredVibration,_this.consecrationMantra,_this.recommendedSpread);
}

@override
String toString() {
  final _this = this as PlanetaryHour;
  return 'PlanetaryHour(planetName: ${_this.planetName}, planetGlyph: ${_this.planetGlyph}, dayRuler: ${_this.dayRuler}, hourIndex: ${_this.hourIndex}, isDayHour: ${_this.isDayHour}, rulingElement: ${_this.rulingElement}, sacredVibration: ${_this.sacredVibration}, consecrationMantra: ${_this.consecrationMantra}, recommendedSpread: ${_this.recommendedSpread})';
}


}

/// @nodoc
abstract mixin class $PlanetaryHourCopyWith<$Res>  {
  factory $PlanetaryHourCopyWith(PlanetaryHour value, $Res Function(PlanetaryHour) _then) = _$PlanetaryHourCopyWithImpl;
@useResult
$Res call({
 String planetName, String planetGlyph, String dayRuler, int hourIndex, bool isDayHour, String rulingElement, String sacredVibration, String consecrationMantra, String recommendedSpread
});




}
/// @nodoc
class _$PlanetaryHourCopyWithImpl<$Res>
    implements $PlanetaryHourCopyWith<$Res> {
  _$PlanetaryHourCopyWithImpl(this._self, this._then);

  final PlanetaryHour _self;
  final $Res Function(PlanetaryHour) _then;

/// Create a copy of PlanetaryHour
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planetName = null,Object? planetGlyph = null,Object? dayRuler = null,Object? hourIndex = null,Object? isDayHour = null,Object? rulingElement = null,Object? sacredVibration = null,Object? consecrationMantra = null,Object? recommendedSpread = null,}) {
  return _then(PlanetaryHour(
planetName: null == planetName ? _self.planetName : planetName // ignore: cast_nullable_to_non_nullable
as String,planetGlyph: null == planetGlyph ? _self.planetGlyph : planetGlyph // ignore: cast_nullable_to_non_nullable
as String,dayRuler: null == dayRuler ? _self.dayRuler : dayRuler // ignore: cast_nullable_to_non_nullable
as String,hourIndex: null == hourIndex ? _self.hourIndex : hourIndex // ignore: cast_nullable_to_non_nullable
as int,isDayHour: null == isDayHour ? _self.isDayHour : isDayHour // ignore: cast_nullable_to_non_nullable
as bool,rulingElement: null == rulingElement ? _self.rulingElement : rulingElement // ignore: cast_nullable_to_non_nullable
as String,sacredVibration: null == sacredVibration ? _self.sacredVibration : sacredVibration // ignore: cast_nullable_to_non_nullable
as String,consecrationMantra: null == consecrationMantra ? _self.consecrationMantra : consecrationMantra // ignore: cast_nullable_to_non_nullable
as String,recommendedSpread: null == recommendedSpread ? _self.recommendedSpread : recommendedSpread // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanetaryHour].
extension PlanetaryHourPatterns on PlanetaryHour {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanetaryHour value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanetaryHour() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanetaryHour value)  $default,){
final _that = this;
switch (_that) {
case _PlanetaryHour():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanetaryHour value)?  $default,){
final _that = this;
switch (_that) {
case _PlanetaryHour() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String planetName,  String planetGlyph,  String dayRuler,  int hourIndex,  bool isDayHour,  String rulingElement,  String sacredVibration,  String consecrationMantra,  String recommendedSpread)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanetaryHour() when $default != null:
return $default(_that.planetName,_that.planetGlyph,_that.dayRuler,_that.hourIndex,_that.isDayHour,_that.rulingElement,_that.sacredVibration,_that.consecrationMantra,_that.recommendedSpread);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String planetName,  String planetGlyph,  String dayRuler,  int hourIndex,  bool isDayHour,  String rulingElement,  String sacredVibration,  String consecrationMantra,  String recommendedSpread)  $default,) {final _that = this;
switch (_that) {
case _PlanetaryHour():
return $default(_that.planetName,_that.planetGlyph,_that.dayRuler,_that.hourIndex,_that.isDayHour,_that.rulingElement,_that.sacredVibration,_that.consecrationMantra,_that.recommendedSpread);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String planetName,  String planetGlyph,  String dayRuler,  int hourIndex,  bool isDayHour,  String rulingElement,  String sacredVibration,  String consecrationMantra,  String recommendedSpread)?  $default,) {final _that = this;
switch (_that) {
case _PlanetaryHour() when $default != null:
return $default(_that.planetName,_that.planetGlyph,_that.dayRuler,_that.hourIndex,_that.isDayHour,_that.rulingElement,_that.sacredVibration,_that.consecrationMantra,_that.recommendedSpread);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanetaryHour implements PlanetaryHour {
  const _PlanetaryHour({required this.planetName, required this.planetGlyph, required this.dayRuler, required this.hourIndex, required this.isDayHour, required this.rulingElement, required this.sacredVibration, required this.consecrationMantra, required this.recommendedSpread});
  factory _PlanetaryHour.fromJson(Map<String, dynamic> json) => _$PlanetaryHourFromJson(json);

@override final  String planetName;
@override final  String planetGlyph;
@override final  String dayRuler;
@override final  int hourIndex;
@override final  bool isDayHour;
@override final  String rulingElement;
@override final  String sacredVibration;
@override final  String consecrationMantra;
@override final  String recommendedSpread;

/// Create a copy of PlanetaryHour
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanetaryHourCopyWith<_PlanetaryHour> get copyWith => __$PlanetaryHourCopyWithImpl<_PlanetaryHour>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanetaryHourToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanetaryHour&&(identical(other.planetName, planetName) || other.planetName == planetName)&&(identical(other.planetGlyph, planetGlyph) || other.planetGlyph == planetGlyph)&&(identical(other.dayRuler, dayRuler) || other.dayRuler == dayRuler)&&(identical(other.hourIndex, hourIndex) || other.hourIndex == hourIndex)&&(identical(other.isDayHour, isDayHour) || other.isDayHour == isDayHour)&&(identical(other.rulingElement, rulingElement) || other.rulingElement == rulingElement)&&(identical(other.sacredVibration, sacredVibration) || other.sacredVibration == sacredVibration)&&(identical(other.consecrationMantra, consecrationMantra) || other.consecrationMantra == consecrationMantra)&&(identical(other.recommendedSpread, recommendedSpread) || other.recommendedSpread == recommendedSpread));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,planetName,planetGlyph,dayRuler,hourIndex,isDayHour,rulingElement,sacredVibration,consecrationMantra,recommendedSpread);
}

@override
String toString() {
    return 'PlanetaryHour(planetName: $planetName, planetGlyph: $planetGlyph, dayRuler: $dayRuler, hourIndex: $hourIndex, isDayHour: $isDayHour, rulingElement: $rulingElement, sacredVibration: $sacredVibration, consecrationMantra: $consecrationMantra, recommendedSpread: $recommendedSpread)';
}


}

/// @nodoc
abstract mixin class _$PlanetaryHourCopyWith<$Res> implements $PlanetaryHourCopyWith<$Res> {
  factory _$PlanetaryHourCopyWith(_PlanetaryHour value, $Res Function(_PlanetaryHour) _then) = __$PlanetaryHourCopyWithImpl;
@override @useResult
$Res call({
 String planetName, String planetGlyph, String dayRuler, int hourIndex, bool isDayHour, String rulingElement, String sacredVibration, String consecrationMantra, String recommendedSpread
});




}
/// @nodoc
class __$PlanetaryHourCopyWithImpl<$Res>
    implements _$PlanetaryHourCopyWith<$Res> {
  __$PlanetaryHourCopyWithImpl(this._self, this._then);

  final _PlanetaryHour _self;
  final $Res Function(_PlanetaryHour) _then;

/// Create a copy of PlanetaryHour
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planetName = null,Object? planetGlyph = null,Object? dayRuler = null,Object? hourIndex = null,Object? isDayHour = null,Object? rulingElement = null,Object? sacredVibration = null,Object? consecrationMantra = null,Object? recommendedSpread = null,}) {
  return _then(_PlanetaryHour(
planetName: null == planetName ? _self.planetName : planetName // ignore: cast_nullable_to_non_nullable
as String,planetGlyph: null == planetGlyph ? _self.planetGlyph : planetGlyph // ignore: cast_nullable_to_non_nullable
as String,dayRuler: null == dayRuler ? _self.dayRuler : dayRuler // ignore: cast_nullable_to_non_nullable
as String,hourIndex: null == hourIndex ? _self.hourIndex : hourIndex // ignore: cast_nullable_to_non_nullable
as int,isDayHour: null == isDayHour ? _self.isDayHour : isDayHour // ignore: cast_nullable_to_non_nullable
as bool,rulingElement: null == rulingElement ? _self.rulingElement : rulingElement // ignore: cast_nullable_to_non_nullable
as String,sacredVibration: null == sacredVibration ? _self.sacredVibration : sacredVibration // ignore: cast_nullable_to_non_nullable
as String,consecrationMantra: null == consecrationMantra ? _self.consecrationMantra : consecrationMantra // ignore: cast_nullable_to_non_nullable
as String,recommendedSpread: null == recommendedSpread ? _self.recommendedSpread : recommendedSpread // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CelestialTransitSnapshot {

 DateTime get timestamp; PlanetaryHour get planetaryHour; List<CelestialTransitBody> get bodies; List<TransitAspect> get aspects; String get lunarPhase; double get lunarIllumination;
/// Create a copy of CelestialTransitSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CelestialTransitSnapshotCopyWith<CelestialTransitSnapshot> get copyWith => _$CelestialTransitSnapshotCopyWithImpl<CelestialTransitSnapshot>(this as CelestialTransitSnapshot, _$identity);

  /// Serializes this CelestialTransitSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CelestialTransitSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CelestialTransitSnapshot&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.planetaryHour, _this.planetaryHour) || other.planetaryHour == _this.planetaryHour)&&const DeepCollectionEquality().equals(other.bodies, _this.bodies)&&const DeepCollectionEquality().equals(other.aspects, _this.aspects)&&(identical(other.lunarPhase, _this.lunarPhase) || other.lunarPhase == _this.lunarPhase)&&(identical(other.lunarIllumination, _this.lunarIllumination) || other.lunarIllumination == _this.lunarIllumination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CelestialTransitSnapshot;
  return Object.hash(runtimeType,_this.timestamp,_this.planetaryHour,const DeepCollectionEquality().hash(_this.bodies),const DeepCollectionEquality().hash(_this.aspects),_this.lunarPhase,_this.lunarIllumination);
}

@override
String toString() {
  final _this = this as CelestialTransitSnapshot;
  return 'CelestialTransitSnapshot(timestamp: ${_this.timestamp}, planetaryHour: ${_this.planetaryHour}, bodies: ${_this.bodies}, aspects: ${_this.aspects}, lunarPhase: ${_this.lunarPhase}, lunarIllumination: ${_this.lunarIllumination})';
}


}

/// @nodoc
abstract mixin class $CelestialTransitSnapshotCopyWith<$Res>  {
  factory $CelestialTransitSnapshotCopyWith(CelestialTransitSnapshot value, $Res Function(CelestialTransitSnapshot) _then) = _$CelestialTransitSnapshotCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, PlanetaryHour planetaryHour, List<CelestialTransitBody> bodies, List<TransitAspect> aspects, String lunarPhase, double lunarIllumination
});


$PlanetaryHourCopyWith<$Res> get planetaryHour;

}
/// @nodoc
class _$CelestialTransitSnapshotCopyWithImpl<$Res>
    implements $CelestialTransitSnapshotCopyWith<$Res> {
  _$CelestialTransitSnapshotCopyWithImpl(this._self, this._then);

  final CelestialTransitSnapshot _self;
  final $Res Function(CelestialTransitSnapshot) _then;

/// Create a copy of CelestialTransitSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? planetaryHour = null,Object? bodies = null,Object? aspects = null,Object? lunarPhase = null,Object? lunarIllumination = null,}) {
  return _then(CelestialTransitSnapshot(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,planetaryHour: null == planetaryHour ? _self.planetaryHour : planetaryHour // ignore: cast_nullable_to_non_nullable
as PlanetaryHour,bodies: null == bodies ? _self.bodies : bodies // ignore: cast_nullable_to_non_nullable
as List<CelestialTransitBody>,aspects: null == aspects ? _self.aspects : aspects // ignore: cast_nullable_to_non_nullable
as List<TransitAspect>,lunarPhase: null == lunarPhase ? _self.lunarPhase : lunarPhase // ignore: cast_nullable_to_non_nullable
as String,lunarIllumination: null == lunarIllumination ? _self.lunarIllumination : lunarIllumination // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of CelestialTransitSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetaryHourCopyWith<$Res> get planetaryHour {
  
  return $PlanetaryHourCopyWith<$Res>(_self.planetaryHour, (value) {
    return _then(_self.copyWith(planetaryHour: value));
  });
}
}


/// Adds pattern-matching-related methods to [CelestialTransitSnapshot].
extension CelestialTransitSnapshotPatterns on CelestialTransitSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CelestialTransitSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CelestialTransitSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CelestialTransitSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _CelestialTransitSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CelestialTransitSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _CelestialTransitSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  PlanetaryHour planetaryHour,  List<CelestialTransitBody> bodies,  List<TransitAspect> aspects,  String lunarPhase,  double lunarIllumination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CelestialTransitSnapshot() when $default != null:
return $default(_that.timestamp,_that.planetaryHour,_that.bodies,_that.aspects,_that.lunarPhase,_that.lunarIllumination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  PlanetaryHour planetaryHour,  List<CelestialTransitBody> bodies,  List<TransitAspect> aspects,  String lunarPhase,  double lunarIllumination)  $default,) {final _that = this;
switch (_that) {
case _CelestialTransitSnapshot():
return $default(_that.timestamp,_that.planetaryHour,_that.bodies,_that.aspects,_that.lunarPhase,_that.lunarIllumination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  PlanetaryHour planetaryHour,  List<CelestialTransitBody> bodies,  List<TransitAspect> aspects,  String lunarPhase,  double lunarIllumination)?  $default,) {final _that = this;
switch (_that) {
case _CelestialTransitSnapshot() when $default != null:
return $default(_that.timestamp,_that.planetaryHour,_that.bodies,_that.aspects,_that.lunarPhase,_that.lunarIllumination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CelestialTransitSnapshot implements CelestialTransitSnapshot {
  const _CelestialTransitSnapshot({required this.timestamp, required this.planetaryHour, required  List<CelestialTransitBody> bodies, required  List<TransitAspect> aspects, required this.lunarPhase, required this.lunarIllumination}): _bodies = bodies,_aspects = aspects;
  factory _CelestialTransitSnapshot.fromJson(Map<String, dynamic> json) => _$CelestialTransitSnapshotFromJson(json);

@override final  DateTime timestamp;
@override final  PlanetaryHour planetaryHour;
 final  List<CelestialTransitBody> _bodies;
@override List<CelestialTransitBody> get bodies {
  if (_bodies is EqualUnmodifiableListView) return _bodies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodies);
}

 final  List<TransitAspect> _aspects;
@override List<TransitAspect> get aspects {
  if (_aspects is EqualUnmodifiableListView) return _aspects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aspects);
}

@override final  String lunarPhase;
@override final  double lunarIllumination;

/// Create a copy of CelestialTransitSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CelestialTransitSnapshotCopyWith<_CelestialTransitSnapshot> get copyWith => __$CelestialTransitSnapshotCopyWithImpl<_CelestialTransitSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CelestialTransitSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CelestialTransitSnapshot&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.planetaryHour, planetaryHour) || other.planetaryHour == planetaryHour)&&const DeepCollectionEquality().equals(other.bodies, _bodies)&&const DeepCollectionEquality().equals(other.aspects, _aspects)&&(identical(other.lunarPhase, lunarPhase) || other.lunarPhase == lunarPhase)&&(identical(other.lunarIllumination, lunarIllumination) || other.lunarIllumination == lunarIllumination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,timestamp,planetaryHour,const DeepCollectionEquality().hash(_bodies),const DeepCollectionEquality().hash(_aspects),lunarPhase,lunarIllumination);
}

@override
String toString() {
    return 'CelestialTransitSnapshot(timestamp: $timestamp, planetaryHour: $planetaryHour, bodies: $bodies, aspects: $aspects, lunarPhase: $lunarPhase, lunarIllumination: $lunarIllumination)';
}


}

/// @nodoc
abstract mixin class _$CelestialTransitSnapshotCopyWith<$Res> implements $CelestialTransitSnapshotCopyWith<$Res> {
  factory _$CelestialTransitSnapshotCopyWith(_CelestialTransitSnapshot value, $Res Function(_CelestialTransitSnapshot) _then) = __$CelestialTransitSnapshotCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, PlanetaryHour planetaryHour, List<CelestialTransitBody> bodies, List<TransitAspect> aspects, String lunarPhase, double lunarIllumination
});


@override $PlanetaryHourCopyWith<$Res> get planetaryHour;

}
/// @nodoc
class __$CelestialTransitSnapshotCopyWithImpl<$Res>
    implements _$CelestialTransitSnapshotCopyWith<$Res> {
  __$CelestialTransitSnapshotCopyWithImpl(this._self, this._then);

  final _CelestialTransitSnapshot _self;
  final $Res Function(_CelestialTransitSnapshot) _then;

/// Create a copy of CelestialTransitSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? planetaryHour = null,Object? bodies = null,Object? aspects = null,Object? lunarPhase = null,Object? lunarIllumination = null,}) {
  return _then(_CelestialTransitSnapshot(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,planetaryHour: null == planetaryHour ? _self.planetaryHour : planetaryHour // ignore: cast_nullable_to_non_nullable
as PlanetaryHour,bodies: null == bodies ? _self._bodies : bodies // ignore: cast_nullable_to_non_nullable
as List<CelestialTransitBody>,aspects: null == aspects ? _self._aspects : aspects // ignore: cast_nullable_to_non_nullable
as List<TransitAspect>,lunarPhase: null == lunarPhase ? _self.lunarPhase : lunarPhase // ignore: cast_nullable_to_non_nullable
as String,lunarIllumination: null == lunarIllumination ? _self.lunarIllumination : lunarIllumination // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of CelestialTransitSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetaryHourCopyWith<$Res> get planetaryHour {
  
  return $PlanetaryHourCopyWith<$Res>(_self.planetaryHour, (value) {
    return _then(_self.copyWith(planetaryHour: value));
  });
}
}

// dart format on
