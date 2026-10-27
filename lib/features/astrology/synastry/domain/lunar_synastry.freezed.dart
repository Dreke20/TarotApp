// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lunar_synastry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SynastryPartner {

 String get name; DateTime get birthDate; String get sunSign; String get moonSign; String get risingSign; String get dominantElement; int get soulCardNumber; String get soulCardName;
/// Create a copy of SynastryPartner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SynastryPartnerCopyWith<SynastryPartner> get copyWith => _$SynastryPartnerCopyWithImpl<SynastryPartner>(this as SynastryPartner, _$identity);

  /// Serializes this SynastryPartner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SynastryPartner;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SynastryPartner&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.sunSign, _this.sunSign) || other.sunSign == _this.sunSign)&&(identical(other.moonSign, _this.moonSign) || other.moonSign == _this.moonSign)&&(identical(other.risingSign, _this.risingSign) || other.risingSign == _this.risingSign)&&(identical(other.dominantElement, _this.dominantElement) || other.dominantElement == _this.dominantElement)&&(identical(other.soulCardNumber, _this.soulCardNumber) || other.soulCardNumber == _this.soulCardNumber)&&(identical(other.soulCardName, _this.soulCardName) || other.soulCardName == _this.soulCardName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SynastryPartner;
  return Object.hash(runtimeType,_this.name,_this.birthDate,_this.sunSign,_this.moonSign,_this.risingSign,_this.dominantElement,_this.soulCardNumber,_this.soulCardName);
}

@override
String toString() {
  final _this = this as SynastryPartner;
  return 'SynastryPartner(name: ${_this.name}, birthDate: ${_this.birthDate}, sunSign: ${_this.sunSign}, moonSign: ${_this.moonSign}, risingSign: ${_this.risingSign}, dominantElement: ${_this.dominantElement}, soulCardNumber: ${_this.soulCardNumber}, soulCardName: ${_this.soulCardName})';
}


}

/// @nodoc
abstract mixin class $SynastryPartnerCopyWith<$Res>  {
  factory $SynastryPartnerCopyWith(SynastryPartner value, $Res Function(SynastryPartner) _then) = _$SynastryPartnerCopyWithImpl;
@useResult
$Res call({
 String name, DateTime birthDate, String sunSign, String moonSign, String risingSign, String dominantElement, int soulCardNumber, String soulCardName
});




}
/// @nodoc
class _$SynastryPartnerCopyWithImpl<$Res>
    implements $SynastryPartnerCopyWith<$Res> {
  _$SynastryPartnerCopyWithImpl(this._self, this._then);

  final SynastryPartner _self;
  final $Res Function(SynastryPartner) _then;

/// Create a copy of SynastryPartner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? birthDate = null,Object? sunSign = null,Object? moonSign = null,Object? risingSign = null,Object? dominantElement = null,Object? soulCardNumber = null,Object? soulCardName = null,}) {
  return _then(SynastryPartner(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,sunSign: null == sunSign ? _self.sunSign : sunSign // ignore: cast_nullable_to_non_nullable
as String,moonSign: null == moonSign ? _self.moonSign : moonSign // ignore: cast_nullable_to_non_nullable
as String,risingSign: null == risingSign ? _self.risingSign : risingSign // ignore: cast_nullable_to_non_nullable
as String,dominantElement: null == dominantElement ? _self.dominantElement : dominantElement // ignore: cast_nullable_to_non_nullable
as String,soulCardNumber: null == soulCardNumber ? _self.soulCardNumber : soulCardNumber // ignore: cast_nullable_to_non_nullable
as int,soulCardName: null == soulCardName ? _self.soulCardName : soulCardName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SynastryPartner].
extension SynastryPartnerPatterns on SynastryPartner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SynastryPartner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SynastryPartner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SynastryPartner value)  $default,){
final _that = this;
switch (_that) {
case _SynastryPartner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SynastryPartner value)?  $default,){
final _that = this;
switch (_that) {
case _SynastryPartner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  DateTime birthDate,  String sunSign,  String moonSign,  String risingSign,  String dominantElement,  int soulCardNumber,  String soulCardName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SynastryPartner() when $default != null:
return $default(_that.name,_that.birthDate,_that.sunSign,_that.moonSign,_that.risingSign,_that.dominantElement,_that.soulCardNumber,_that.soulCardName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  DateTime birthDate,  String sunSign,  String moonSign,  String risingSign,  String dominantElement,  int soulCardNumber,  String soulCardName)  $default,) {final _that = this;
switch (_that) {
case _SynastryPartner():
return $default(_that.name,_that.birthDate,_that.sunSign,_that.moonSign,_that.risingSign,_that.dominantElement,_that.soulCardNumber,_that.soulCardName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  DateTime birthDate,  String sunSign,  String moonSign,  String risingSign,  String dominantElement,  int soulCardNumber,  String soulCardName)?  $default,) {final _that = this;
switch (_that) {
case _SynastryPartner() when $default != null:
return $default(_that.name,_that.birthDate,_that.sunSign,_that.moonSign,_that.risingSign,_that.dominantElement,_that.soulCardNumber,_that.soulCardName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SynastryPartner implements SynastryPartner {
  const _SynastryPartner({required this.name, required this.birthDate, required this.sunSign, required this.moonSign, required this.risingSign, required this.dominantElement, required this.soulCardNumber, required this.soulCardName});
  factory _SynastryPartner.fromJson(Map<String, dynamic> json) => _$SynastryPartnerFromJson(json);

@override final  String name;
@override final  DateTime birthDate;
@override final  String sunSign;
@override final  String moonSign;
@override final  String risingSign;
@override final  String dominantElement;
@override final  int soulCardNumber;
@override final  String soulCardName;

/// Create a copy of SynastryPartner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SynastryPartnerCopyWith<_SynastryPartner> get copyWith => __$SynastryPartnerCopyWithImpl<_SynastryPartner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SynastryPartnerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SynastryPartner&&(identical(other.name, name) || other.name == name)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.sunSign, sunSign) || other.sunSign == sunSign)&&(identical(other.moonSign, moonSign) || other.moonSign == moonSign)&&(identical(other.risingSign, risingSign) || other.risingSign == risingSign)&&(identical(other.dominantElement, dominantElement) || other.dominantElement == dominantElement)&&(identical(other.soulCardNumber, soulCardNumber) || other.soulCardNumber == soulCardNumber)&&(identical(other.soulCardName, soulCardName) || other.soulCardName == soulCardName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,birthDate,sunSign,moonSign,risingSign,dominantElement,soulCardNumber,soulCardName);
}

@override
String toString() {
    return 'SynastryPartner(name: $name, birthDate: $birthDate, sunSign: $sunSign, moonSign: $moonSign, risingSign: $risingSign, dominantElement: $dominantElement, soulCardNumber: $soulCardNumber, soulCardName: $soulCardName)';
}


}

/// @nodoc
abstract mixin class _$SynastryPartnerCopyWith<$Res> implements $SynastryPartnerCopyWith<$Res> {
  factory _$SynastryPartnerCopyWith(_SynastryPartner value, $Res Function(_SynastryPartner) _then) = __$SynastryPartnerCopyWithImpl;
@override @useResult
$Res call({
 String name, DateTime birthDate, String sunSign, String moonSign, String risingSign, String dominantElement, int soulCardNumber, String soulCardName
});




}
/// @nodoc
class __$SynastryPartnerCopyWithImpl<$Res>
    implements _$SynastryPartnerCopyWith<$Res> {
  __$SynastryPartnerCopyWithImpl(this._self, this._then);

  final _SynastryPartner _self;
  final $Res Function(_SynastryPartner) _then;

/// Create a copy of SynastryPartner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? birthDate = null,Object? sunSign = null,Object? moonSign = null,Object? risingSign = null,Object? dominantElement = null,Object? soulCardNumber = null,Object? soulCardName = null,}) {
  return _then(_SynastryPartner(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,sunSign: null == sunSign ? _self.sunSign : sunSign // ignore: cast_nullable_to_non_nullable
as String,moonSign: null == moonSign ? _self.moonSign : moonSign // ignore: cast_nullable_to_non_nullable
as String,risingSign: null == risingSign ? _self.risingSign : risingSign // ignore: cast_nullable_to_non_nullable
as String,dominantElement: null == dominantElement ? _self.dominantElement : dominantElement // ignore: cast_nullable_to_non_nullable
as String,soulCardNumber: null == soulCardNumber ? _self.soulCardNumber : soulCardNumber // ignore: cast_nullable_to_non_nullable
as int,soulCardName: null == soulCardName ? _self.soulCardName : soulCardName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SynastryAspect {

 String get title; String get placementA; String get placementB; String get aspectType; int get harmonyStars; String get dynamicDescription; String get tarotTalisman;
/// Create a copy of SynastryAspect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SynastryAspectCopyWith<SynastryAspect> get copyWith => _$SynastryAspectCopyWithImpl<SynastryAspect>(this as SynastryAspect, _$identity);

  /// Serializes this SynastryAspect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SynastryAspect;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SynastryAspect&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.placementA, _this.placementA) || other.placementA == _this.placementA)&&(identical(other.placementB, _this.placementB) || other.placementB == _this.placementB)&&(identical(other.aspectType, _this.aspectType) || other.aspectType == _this.aspectType)&&(identical(other.harmonyStars, _this.harmonyStars) || other.harmonyStars == _this.harmonyStars)&&(identical(other.dynamicDescription, _this.dynamicDescription) || other.dynamicDescription == _this.dynamicDescription)&&(identical(other.tarotTalisman, _this.tarotTalisman) || other.tarotTalisman == _this.tarotTalisman));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SynastryAspect;
  return Object.hash(runtimeType,_this.title,_this.placementA,_this.placementB,_this.aspectType,_this.harmonyStars,_this.dynamicDescription,_this.tarotTalisman);
}

@override
String toString() {
  final _this = this as SynastryAspect;
  return 'SynastryAspect(title: ${_this.title}, placementA: ${_this.placementA}, placementB: ${_this.placementB}, aspectType: ${_this.aspectType}, harmonyStars: ${_this.harmonyStars}, dynamicDescription: ${_this.dynamicDescription}, tarotTalisman: ${_this.tarotTalisman})';
}


}

/// @nodoc
abstract mixin class $SynastryAspectCopyWith<$Res>  {
  factory $SynastryAspectCopyWith(SynastryAspect value, $Res Function(SynastryAspect) _then) = _$SynastryAspectCopyWithImpl;
@useResult
$Res call({
 String title, String placementA, String placementB, String aspectType, int harmonyStars, String dynamicDescription, String tarotTalisman
});




}
/// @nodoc
class _$SynastryAspectCopyWithImpl<$Res>
    implements $SynastryAspectCopyWith<$Res> {
  _$SynastryAspectCopyWithImpl(this._self, this._then);

  final SynastryAspect _self;
  final $Res Function(SynastryAspect) _then;

/// Create a copy of SynastryAspect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? placementA = null,Object? placementB = null,Object? aspectType = null,Object? harmonyStars = null,Object? dynamicDescription = null,Object? tarotTalisman = null,}) {
  return _then(SynastryAspect(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,placementA: null == placementA ? _self.placementA : placementA // ignore: cast_nullable_to_non_nullable
as String,placementB: null == placementB ? _self.placementB : placementB // ignore: cast_nullable_to_non_nullable
as String,aspectType: null == aspectType ? _self.aspectType : aspectType // ignore: cast_nullable_to_non_nullable
as String,harmonyStars: null == harmonyStars ? _self.harmonyStars : harmonyStars // ignore: cast_nullable_to_non_nullable
as int,dynamicDescription: null == dynamicDescription ? _self.dynamicDescription : dynamicDescription // ignore: cast_nullable_to_non_nullable
as String,tarotTalisman: null == tarotTalisman ? _self.tarotTalisman : tarotTalisman // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SynastryAspect].
extension SynastryAspectPatterns on SynastryAspect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SynastryAspect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SynastryAspect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SynastryAspect value)  $default,){
final _that = this;
switch (_that) {
case _SynastryAspect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SynastryAspect value)?  $default,){
final _that = this;
switch (_that) {
case _SynastryAspect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String placementA,  String placementB,  String aspectType,  int harmonyStars,  String dynamicDescription,  String tarotTalisman)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SynastryAspect() when $default != null:
return $default(_that.title,_that.placementA,_that.placementB,_that.aspectType,_that.harmonyStars,_that.dynamicDescription,_that.tarotTalisman);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String placementA,  String placementB,  String aspectType,  int harmonyStars,  String dynamicDescription,  String tarotTalisman)  $default,) {final _that = this;
switch (_that) {
case _SynastryAspect():
return $default(_that.title,_that.placementA,_that.placementB,_that.aspectType,_that.harmonyStars,_that.dynamicDescription,_that.tarotTalisman);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String placementA,  String placementB,  String aspectType,  int harmonyStars,  String dynamicDescription,  String tarotTalisman)?  $default,) {final _that = this;
switch (_that) {
case _SynastryAspect() when $default != null:
return $default(_that.title,_that.placementA,_that.placementB,_that.aspectType,_that.harmonyStars,_that.dynamicDescription,_that.tarotTalisman);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SynastryAspect implements SynastryAspect {
  const _SynastryAspect({required this.title, required this.placementA, required this.placementB, required this.aspectType, required this.harmonyStars, required this.dynamicDescription, required this.tarotTalisman});
  factory _SynastryAspect.fromJson(Map<String, dynamic> json) => _$SynastryAspectFromJson(json);

@override final  String title;
@override final  String placementA;
@override final  String placementB;
@override final  String aspectType;
@override final  int harmonyStars;
@override final  String dynamicDescription;
@override final  String tarotTalisman;

/// Create a copy of SynastryAspect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SynastryAspectCopyWith<_SynastryAspect> get copyWith => __$SynastryAspectCopyWithImpl<_SynastryAspect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SynastryAspectToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SynastryAspect&&(identical(other.title, title) || other.title == title)&&(identical(other.placementA, placementA) || other.placementA == placementA)&&(identical(other.placementB, placementB) || other.placementB == placementB)&&(identical(other.aspectType, aspectType) || other.aspectType == aspectType)&&(identical(other.harmonyStars, harmonyStars) || other.harmonyStars == harmonyStars)&&(identical(other.dynamicDescription, dynamicDescription) || other.dynamicDescription == dynamicDescription)&&(identical(other.tarotTalisman, tarotTalisman) || other.tarotTalisman == tarotTalisman));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,placementA,placementB,aspectType,harmonyStars,dynamicDescription,tarotTalisman);
}

@override
String toString() {
    return 'SynastryAspect(title: $title, placementA: $placementA, placementB: $placementB, aspectType: $aspectType, harmonyStars: $harmonyStars, dynamicDescription: $dynamicDescription, tarotTalisman: $tarotTalisman)';
}


}

/// @nodoc
abstract mixin class _$SynastryAspectCopyWith<$Res> implements $SynastryAspectCopyWith<$Res> {
  factory _$SynastryAspectCopyWith(_SynastryAspect value, $Res Function(_SynastryAspect) _then) = __$SynastryAspectCopyWithImpl;
@override @useResult
$Res call({
 String title, String placementA, String placementB, String aspectType, int harmonyStars, String dynamicDescription, String tarotTalisman
});




}
/// @nodoc
class __$SynastryAspectCopyWithImpl<$Res>
    implements _$SynastryAspectCopyWith<$Res> {
  __$SynastryAspectCopyWithImpl(this._self, this._then);

  final _SynastryAspect _self;
  final $Res Function(_SynastryAspect) _then;

/// Create a copy of SynastryAspect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? placementA = null,Object? placementB = null,Object? aspectType = null,Object? harmonyStars = null,Object? dynamicDescription = null,Object? tarotTalisman = null,}) {
  return _then(_SynastryAspect(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,placementA: null == placementA ? _self.placementA : placementA // ignore: cast_nullable_to_non_nullable
as String,placementB: null == placementB ? _self.placementB : placementB // ignore: cast_nullable_to_non_nullable
as String,aspectType: null == aspectType ? _self.aspectType : aspectType // ignore: cast_nullable_to_non_nullable
as String,harmonyStars: null == harmonyStars ? _self.harmonyStars : harmonyStars // ignore: cast_nullable_to_non_nullable
as int,dynamicDescription: null == dynamicDescription ? _self.dynamicDescription : dynamicDescription // ignore: cast_nullable_to_non_nullable
as String,tarotTalisman: null == tarotTalisman ? _self.tarotTalisman : tarotTalisman // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LunarSynastryReading {

 SynastryPartner get partnerA; SynastryPartner get partnerB; int get compatibilityScore; String get bondTitle; String get relationshipArchetype; String get elementalConfluence; String get elementalDynamic; double get elementalBalancePercent; String get moonPhaseSynergy; List<SynastryAspect> get aspects; String get karmicLesson; String get soulChallenge; String get sacredRitual; String get oracleProphecy;
/// Create a copy of LunarSynastryReading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LunarSynastryReadingCopyWith<LunarSynastryReading> get copyWith => _$LunarSynastryReadingCopyWithImpl<LunarSynastryReading>(this as LunarSynastryReading, _$identity);

  /// Serializes this LunarSynastryReading to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LunarSynastryReading;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LunarSynastryReading&&(identical(other.partnerA, _this.partnerA) || other.partnerA == _this.partnerA)&&(identical(other.partnerB, _this.partnerB) || other.partnerB == _this.partnerB)&&(identical(other.compatibilityScore, _this.compatibilityScore) || other.compatibilityScore == _this.compatibilityScore)&&(identical(other.bondTitle, _this.bondTitle) || other.bondTitle == _this.bondTitle)&&(identical(other.relationshipArchetype, _this.relationshipArchetype) || other.relationshipArchetype == _this.relationshipArchetype)&&(identical(other.elementalConfluence, _this.elementalConfluence) || other.elementalConfluence == _this.elementalConfluence)&&(identical(other.elementalDynamic, _this.elementalDynamic) || other.elementalDynamic == _this.elementalDynamic)&&(identical(other.elementalBalancePercent, _this.elementalBalancePercent) || other.elementalBalancePercent == _this.elementalBalancePercent)&&(identical(other.moonPhaseSynergy, _this.moonPhaseSynergy) || other.moonPhaseSynergy == _this.moonPhaseSynergy)&&const DeepCollectionEquality().equals(other.aspects, _this.aspects)&&(identical(other.karmicLesson, _this.karmicLesson) || other.karmicLesson == _this.karmicLesson)&&(identical(other.soulChallenge, _this.soulChallenge) || other.soulChallenge == _this.soulChallenge)&&(identical(other.sacredRitual, _this.sacredRitual) || other.sacredRitual == _this.sacredRitual)&&(identical(other.oracleProphecy, _this.oracleProphecy) || other.oracleProphecy == _this.oracleProphecy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LunarSynastryReading;
  return Object.hash(runtimeType,_this.partnerA,_this.partnerB,_this.compatibilityScore,_this.bondTitle,_this.relationshipArchetype,_this.elementalConfluence,_this.elementalDynamic,_this.elementalBalancePercent,_this.moonPhaseSynergy,const DeepCollectionEquality().hash(_this.aspects),_this.karmicLesson,_this.soulChallenge,_this.sacredRitual,_this.oracleProphecy);
}

@override
String toString() {
  final _this = this as LunarSynastryReading;
  return 'LunarSynastryReading(partnerA: ${_this.partnerA}, partnerB: ${_this.partnerB}, compatibilityScore: ${_this.compatibilityScore}, bondTitle: ${_this.bondTitle}, relationshipArchetype: ${_this.relationshipArchetype}, elementalConfluence: ${_this.elementalConfluence}, elementalDynamic: ${_this.elementalDynamic}, elementalBalancePercent: ${_this.elementalBalancePercent}, moonPhaseSynergy: ${_this.moonPhaseSynergy}, aspects: ${_this.aspects}, karmicLesson: ${_this.karmicLesson}, soulChallenge: ${_this.soulChallenge}, sacredRitual: ${_this.sacredRitual}, oracleProphecy: ${_this.oracleProphecy})';
}


}

/// @nodoc
abstract mixin class $LunarSynastryReadingCopyWith<$Res>  {
  factory $LunarSynastryReadingCopyWith(LunarSynastryReading value, $Res Function(LunarSynastryReading) _then) = _$LunarSynastryReadingCopyWithImpl;
@useResult
$Res call({
 SynastryPartner partnerA, SynastryPartner partnerB, int compatibilityScore, String bondTitle, String relationshipArchetype, String elementalConfluence, String elementalDynamic, double elementalBalancePercent, String moonPhaseSynergy, List<SynastryAspect> aspects, String karmicLesson, String soulChallenge, String sacredRitual, String oracleProphecy
});


$SynastryPartnerCopyWith<$Res> get partnerA;$SynastryPartnerCopyWith<$Res> get partnerB;

}
/// @nodoc
class _$LunarSynastryReadingCopyWithImpl<$Res>
    implements $LunarSynastryReadingCopyWith<$Res> {
  _$LunarSynastryReadingCopyWithImpl(this._self, this._then);

  final LunarSynastryReading _self;
  final $Res Function(LunarSynastryReading) _then;

/// Create a copy of LunarSynastryReading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? partnerA = null,Object? partnerB = null,Object? compatibilityScore = null,Object? bondTitle = null,Object? relationshipArchetype = null,Object? elementalConfluence = null,Object? elementalDynamic = null,Object? elementalBalancePercent = null,Object? moonPhaseSynergy = null,Object? aspects = null,Object? karmicLesson = null,Object? soulChallenge = null,Object? sacredRitual = null,Object? oracleProphecy = null,}) {
  return _then(LunarSynastryReading(
partnerA: null == partnerA ? _self.partnerA : partnerA // ignore: cast_nullable_to_non_nullable
as SynastryPartner,partnerB: null == partnerB ? _self.partnerB : partnerB // ignore: cast_nullable_to_non_nullable
as SynastryPartner,compatibilityScore: null == compatibilityScore ? _self.compatibilityScore : compatibilityScore // ignore: cast_nullable_to_non_nullable
as int,bondTitle: null == bondTitle ? _self.bondTitle : bondTitle // ignore: cast_nullable_to_non_nullable
as String,relationshipArchetype: null == relationshipArchetype ? _self.relationshipArchetype : relationshipArchetype // ignore: cast_nullable_to_non_nullable
as String,elementalConfluence: null == elementalConfluence ? _self.elementalConfluence : elementalConfluence // ignore: cast_nullable_to_non_nullable
as String,elementalDynamic: null == elementalDynamic ? _self.elementalDynamic : elementalDynamic // ignore: cast_nullable_to_non_nullable
as String,elementalBalancePercent: null == elementalBalancePercent ? _self.elementalBalancePercent : elementalBalancePercent // ignore: cast_nullable_to_non_nullable
as double,moonPhaseSynergy: null == moonPhaseSynergy ? _self.moonPhaseSynergy : moonPhaseSynergy // ignore: cast_nullable_to_non_nullable
as String,aspects: null == aspects ? _self.aspects : aspects // ignore: cast_nullable_to_non_nullable
as List<SynastryAspect>,karmicLesson: null == karmicLesson ? _self.karmicLesson : karmicLesson // ignore: cast_nullable_to_non_nullable
as String,soulChallenge: null == soulChallenge ? _self.soulChallenge : soulChallenge // ignore: cast_nullable_to_non_nullable
as String,sacredRitual: null == sacredRitual ? _self.sacredRitual : sacredRitual // ignore: cast_nullable_to_non_nullable
as String,oracleProphecy: null == oracleProphecy ? _self.oracleProphecy : oracleProphecy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of LunarSynastryReading
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SynastryPartnerCopyWith<$Res> get partnerA {
  
  return $SynastryPartnerCopyWith<$Res>(_self.partnerA, (value) {
    return _then(_self.copyWith(partnerA: value));
  });
}/// Create a copy of LunarSynastryReading
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SynastryPartnerCopyWith<$Res> get partnerB {
  
  return $SynastryPartnerCopyWith<$Res>(_self.partnerB, (value) {
    return _then(_self.copyWith(partnerB: value));
  });
}
}


/// Adds pattern-matching-related methods to [LunarSynastryReading].
extension LunarSynastryReadingPatterns on LunarSynastryReading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LunarSynastryReading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LunarSynastryReading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LunarSynastryReading value)  $default,){
final _that = this;
switch (_that) {
case _LunarSynastryReading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LunarSynastryReading value)?  $default,){
final _that = this;
switch (_that) {
case _LunarSynastryReading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SynastryPartner partnerA,  SynastryPartner partnerB,  int compatibilityScore,  String bondTitle,  String relationshipArchetype,  String elementalConfluence,  String elementalDynamic,  double elementalBalancePercent,  String moonPhaseSynergy,  List<SynastryAspect> aspects,  String karmicLesson,  String soulChallenge,  String sacredRitual,  String oracleProphecy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LunarSynastryReading() when $default != null:
return $default(_that.partnerA,_that.partnerB,_that.compatibilityScore,_that.bondTitle,_that.relationshipArchetype,_that.elementalConfluence,_that.elementalDynamic,_that.elementalBalancePercent,_that.moonPhaseSynergy,_that.aspects,_that.karmicLesson,_that.soulChallenge,_that.sacredRitual,_that.oracleProphecy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SynastryPartner partnerA,  SynastryPartner partnerB,  int compatibilityScore,  String bondTitle,  String relationshipArchetype,  String elementalConfluence,  String elementalDynamic,  double elementalBalancePercent,  String moonPhaseSynergy,  List<SynastryAspect> aspects,  String karmicLesson,  String soulChallenge,  String sacredRitual,  String oracleProphecy)  $default,) {final _that = this;
switch (_that) {
case _LunarSynastryReading():
return $default(_that.partnerA,_that.partnerB,_that.compatibilityScore,_that.bondTitle,_that.relationshipArchetype,_that.elementalConfluence,_that.elementalDynamic,_that.elementalBalancePercent,_that.moonPhaseSynergy,_that.aspects,_that.karmicLesson,_that.soulChallenge,_that.sacredRitual,_that.oracleProphecy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SynastryPartner partnerA,  SynastryPartner partnerB,  int compatibilityScore,  String bondTitle,  String relationshipArchetype,  String elementalConfluence,  String elementalDynamic,  double elementalBalancePercent,  String moonPhaseSynergy,  List<SynastryAspect> aspects,  String karmicLesson,  String soulChallenge,  String sacredRitual,  String oracleProphecy)?  $default,) {final _that = this;
switch (_that) {
case _LunarSynastryReading() when $default != null:
return $default(_that.partnerA,_that.partnerB,_that.compatibilityScore,_that.bondTitle,_that.relationshipArchetype,_that.elementalConfluence,_that.elementalDynamic,_that.elementalBalancePercent,_that.moonPhaseSynergy,_that.aspects,_that.karmicLesson,_that.soulChallenge,_that.sacredRitual,_that.oracleProphecy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LunarSynastryReading implements LunarSynastryReading {
  const _LunarSynastryReading({required this.partnerA, required this.partnerB, required this.compatibilityScore, required this.bondTitle, required this.relationshipArchetype, required this.elementalConfluence, required this.elementalDynamic, required this.elementalBalancePercent, required this.moonPhaseSynergy, required  List<SynastryAspect> aspects, required this.karmicLesson, required this.soulChallenge, required this.sacredRitual, required this.oracleProphecy}): _aspects = aspects;
  factory _LunarSynastryReading.fromJson(Map<String, dynamic> json) => _$LunarSynastryReadingFromJson(json);

@override final  SynastryPartner partnerA;
@override final  SynastryPartner partnerB;
@override final  int compatibilityScore;
@override final  String bondTitle;
@override final  String relationshipArchetype;
@override final  String elementalConfluence;
@override final  String elementalDynamic;
@override final  double elementalBalancePercent;
@override final  String moonPhaseSynergy;
 final  List<SynastryAspect> _aspects;
@override List<SynastryAspect> get aspects {
  if (_aspects is EqualUnmodifiableListView) return _aspects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aspects);
}

@override final  String karmicLesson;
@override final  String soulChallenge;
@override final  String sacredRitual;
@override final  String oracleProphecy;

/// Create a copy of LunarSynastryReading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LunarSynastryReadingCopyWith<_LunarSynastryReading> get copyWith => __$LunarSynastryReadingCopyWithImpl<_LunarSynastryReading>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LunarSynastryReadingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LunarSynastryReading&&(identical(other.partnerA, partnerA) || other.partnerA == partnerA)&&(identical(other.partnerB, partnerB) || other.partnerB == partnerB)&&(identical(other.compatibilityScore, compatibilityScore) || other.compatibilityScore == compatibilityScore)&&(identical(other.bondTitle, bondTitle) || other.bondTitle == bondTitle)&&(identical(other.relationshipArchetype, relationshipArchetype) || other.relationshipArchetype == relationshipArchetype)&&(identical(other.elementalConfluence, elementalConfluence) || other.elementalConfluence == elementalConfluence)&&(identical(other.elementalDynamic, elementalDynamic) || other.elementalDynamic == elementalDynamic)&&(identical(other.elementalBalancePercent, elementalBalancePercent) || other.elementalBalancePercent == elementalBalancePercent)&&(identical(other.moonPhaseSynergy, moonPhaseSynergy) || other.moonPhaseSynergy == moonPhaseSynergy)&&const DeepCollectionEquality().equals(other.aspects, _aspects)&&(identical(other.karmicLesson, karmicLesson) || other.karmicLesson == karmicLesson)&&(identical(other.soulChallenge, soulChallenge) || other.soulChallenge == soulChallenge)&&(identical(other.sacredRitual, sacredRitual) || other.sacredRitual == sacredRitual)&&(identical(other.oracleProphecy, oracleProphecy) || other.oracleProphecy == oracleProphecy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,partnerA,partnerB,compatibilityScore,bondTitle,relationshipArchetype,elementalConfluence,elementalDynamic,elementalBalancePercent,moonPhaseSynergy,const DeepCollectionEquality().hash(_aspects),karmicLesson,soulChallenge,sacredRitual,oracleProphecy);
}

@override
String toString() {
    return 'LunarSynastryReading(partnerA: $partnerA, partnerB: $partnerB, compatibilityScore: $compatibilityScore, bondTitle: $bondTitle, relationshipArchetype: $relationshipArchetype, elementalConfluence: $elementalConfluence, elementalDynamic: $elementalDynamic, elementalBalancePercent: $elementalBalancePercent, moonPhaseSynergy: $moonPhaseSynergy, aspects: $aspects, karmicLesson: $karmicLesson, soulChallenge: $soulChallenge, sacredRitual: $sacredRitual, oracleProphecy: $oracleProphecy)';
}


}

/// @nodoc
abstract mixin class _$LunarSynastryReadingCopyWith<$Res> implements $LunarSynastryReadingCopyWith<$Res> {
  factory _$LunarSynastryReadingCopyWith(_LunarSynastryReading value, $Res Function(_LunarSynastryReading) _then) = __$LunarSynastryReadingCopyWithImpl;
@override @useResult
$Res call({
 SynastryPartner partnerA, SynastryPartner partnerB, int compatibilityScore, String bondTitle, String relationshipArchetype, String elementalConfluence, String elementalDynamic, double elementalBalancePercent, String moonPhaseSynergy, List<SynastryAspect> aspects, String karmicLesson, String soulChallenge, String sacredRitual, String oracleProphecy
});


@override $SynastryPartnerCopyWith<$Res> get partnerA;@override $SynastryPartnerCopyWith<$Res> get partnerB;

}
/// @nodoc
class __$LunarSynastryReadingCopyWithImpl<$Res>
    implements _$LunarSynastryReadingCopyWith<$Res> {
  __$LunarSynastryReadingCopyWithImpl(this._self, this._then);

  final _LunarSynastryReading _self;
  final $Res Function(_LunarSynastryReading) _then;

/// Create a copy of LunarSynastryReading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? partnerA = null,Object? partnerB = null,Object? compatibilityScore = null,Object? bondTitle = null,Object? relationshipArchetype = null,Object? elementalConfluence = null,Object? elementalDynamic = null,Object? elementalBalancePercent = null,Object? moonPhaseSynergy = null,Object? aspects = null,Object? karmicLesson = null,Object? soulChallenge = null,Object? sacredRitual = null,Object? oracleProphecy = null,}) {
  return _then(_LunarSynastryReading(
partnerA: null == partnerA ? _self.partnerA : partnerA // ignore: cast_nullable_to_non_nullable
as SynastryPartner,partnerB: null == partnerB ? _self.partnerB : partnerB // ignore: cast_nullable_to_non_nullable
as SynastryPartner,compatibilityScore: null == compatibilityScore ? _self.compatibilityScore : compatibilityScore // ignore: cast_nullable_to_non_nullable
as int,bondTitle: null == bondTitle ? _self.bondTitle : bondTitle // ignore: cast_nullable_to_non_nullable
as String,relationshipArchetype: null == relationshipArchetype ? _self.relationshipArchetype : relationshipArchetype // ignore: cast_nullable_to_non_nullable
as String,elementalConfluence: null == elementalConfluence ? _self.elementalConfluence : elementalConfluence // ignore: cast_nullable_to_non_nullable
as String,elementalDynamic: null == elementalDynamic ? _self.elementalDynamic : elementalDynamic // ignore: cast_nullable_to_non_nullable
as String,elementalBalancePercent: null == elementalBalancePercent ? _self.elementalBalancePercent : elementalBalancePercent // ignore: cast_nullable_to_non_nullable
as double,moonPhaseSynergy: null == moonPhaseSynergy ? _self.moonPhaseSynergy : moonPhaseSynergy // ignore: cast_nullable_to_non_nullable
as String,aspects: null == aspects ? _self._aspects : aspects // ignore: cast_nullable_to_non_nullable
as List<SynastryAspect>,karmicLesson: null == karmicLesson ? _self.karmicLesson : karmicLesson // ignore: cast_nullable_to_non_nullable
as String,soulChallenge: null == soulChallenge ? _self.soulChallenge : soulChallenge // ignore: cast_nullable_to_non_nullable
as String,sacredRitual: null == sacredRitual ? _self.sacredRitual : sacredRitual // ignore: cast_nullable_to_non_nullable
as String,oracleProphecy: null == oracleProphecy ? _self.oracleProphecy : oracleProphecy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of LunarSynastryReading
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SynastryPartnerCopyWith<$Res> get partnerA {
  
  return $SynastryPartnerCopyWith<$Res>(_self.partnerA, (value) {
    return _then(_self.copyWith(partnerA: value));
  });
}/// Create a copy of LunarSynastryReading
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SynastryPartnerCopyWith<$Res> get partnerB {
  
  return $SynastryPartnerCopyWith<$Res>(_self.partnerB, (value) {
    return _then(_self.copyWith(partnerB: value));
  });
}
}

// dart format on
