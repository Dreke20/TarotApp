// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'celestial_bazaar_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActiveSanctuaryCandle {

 String get id; CandleType get type; String get intention; DateTime get litAt; DateTime get expiresAt;
/// Create a copy of ActiveSanctuaryCandle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveSanctuaryCandleCopyWith<ActiveSanctuaryCandle> get copyWith => _$ActiveSanctuaryCandleCopyWithImpl<ActiveSanctuaryCandle>(this as ActiveSanctuaryCandle, _$identity);

  /// Serializes this ActiveSanctuaryCandle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActiveSanctuaryCandle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSanctuaryCandle&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.intention, _this.intention) || other.intention == _this.intention)&&(identical(other.litAt, _this.litAt) || other.litAt == _this.litAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActiveSanctuaryCandle;
  return Object.hash(runtimeType,_this.id,_this.type,_this.intention,_this.litAt,_this.expiresAt);
}

@override
String toString() {
  final _this = this as ActiveSanctuaryCandle;
  return 'ActiveSanctuaryCandle(id: ${_this.id}, type: ${_this.type}, intention: ${_this.intention}, litAt: ${_this.litAt}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $ActiveSanctuaryCandleCopyWith<$Res>  {
  factory $ActiveSanctuaryCandleCopyWith(ActiveSanctuaryCandle value, $Res Function(ActiveSanctuaryCandle) _then) = _$ActiveSanctuaryCandleCopyWithImpl;
@useResult
$Res call({
 String id, CandleType type, String intention, DateTime litAt, DateTime expiresAt
});




}
/// @nodoc
class _$ActiveSanctuaryCandleCopyWithImpl<$Res>
    implements $ActiveSanctuaryCandleCopyWith<$Res> {
  _$ActiveSanctuaryCandleCopyWithImpl(this._self, this._then);

  final ActiveSanctuaryCandle _self;
  final $Res Function(ActiveSanctuaryCandle) _then;

/// Create a copy of ActiveSanctuaryCandle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? intention = null,Object? litAt = null,Object? expiresAt = null,}) {
  return _then(ActiveSanctuaryCandle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CandleType,intention: null == intention ? _self.intention : intention // ignore: cast_nullable_to_non_nullable
as String,litAt: null == litAt ? _self.litAt : litAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveSanctuaryCandle].
extension ActiveSanctuaryCandlePatterns on ActiveSanctuaryCandle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveSanctuaryCandle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveSanctuaryCandle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveSanctuaryCandle value)  $default,){
final _that = this;
switch (_that) {
case _ActiveSanctuaryCandle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveSanctuaryCandle value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveSanctuaryCandle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  CandleType type,  String intention,  DateTime litAt,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveSanctuaryCandle() when $default != null:
return $default(_that.id,_that.type,_that.intention,_that.litAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  CandleType type,  String intention,  DateTime litAt,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _ActiveSanctuaryCandle():
return $default(_that.id,_that.type,_that.intention,_that.litAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  CandleType type,  String intention,  DateTime litAt,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _ActiveSanctuaryCandle() when $default != null:
return $default(_that.id,_that.type,_that.intention,_that.litAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveSanctuaryCandle extends ActiveSanctuaryCandle {
  const _ActiveSanctuaryCandle({required this.id, required this.type, required this.intention, required this.litAt, required this.expiresAt}): super._();
  factory _ActiveSanctuaryCandle.fromJson(Map<String, dynamic> json) => _$ActiveSanctuaryCandleFromJson(json);

@override final  String id;
@override final  CandleType type;
@override final  String intention;
@override final  DateTime litAt;
@override final  DateTime expiresAt;

/// Create a copy of ActiveSanctuaryCandle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveSanctuaryCandleCopyWith<_ActiveSanctuaryCandle> get copyWith => __$ActiveSanctuaryCandleCopyWithImpl<_ActiveSanctuaryCandle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveSanctuaryCandleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveSanctuaryCandle&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.intention, intention) || other.intention == intention)&&(identical(other.litAt, litAt) || other.litAt == litAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,intention,litAt,expiresAt);
}

@override
String toString() {
    return 'ActiveSanctuaryCandle(id: $id, type: $type, intention: $intention, litAt: $litAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$ActiveSanctuaryCandleCopyWith<$Res> implements $ActiveSanctuaryCandleCopyWith<$Res> {
  factory _$ActiveSanctuaryCandleCopyWith(_ActiveSanctuaryCandle value, $Res Function(_ActiveSanctuaryCandle) _then) = __$ActiveSanctuaryCandleCopyWithImpl;
@override @useResult
$Res call({
 String id, CandleType type, String intention, DateTime litAt, DateTime expiresAt
});




}
/// @nodoc
class __$ActiveSanctuaryCandleCopyWithImpl<$Res>
    implements _$ActiveSanctuaryCandleCopyWith<$Res> {
  __$ActiveSanctuaryCandleCopyWithImpl(this._self, this._then);

  final _ActiveSanctuaryCandle _self;
  final $Res Function(_ActiveSanctuaryCandle) _then;

/// Create a copy of ActiveSanctuaryCandle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? intention = null,Object? litAt = null,Object? expiresAt = null,}) {
  return _then(_ActiveSanctuaryCandle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CandleType,intention: null == intention ? _self.intention : intention // ignore: cast_nullable_to_non_nullable
as String,litAt: null == litAt ? _self.litAt : litAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CelestialFlashDiscount {

 String get title; String get subtitle; String get badgeText; int get discountPercent; DateTime get expiresAt; int get primaryColorHex;
/// Create a copy of CelestialFlashDiscount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CelestialFlashDiscountCopyWith<CelestialFlashDiscount> get copyWith => _$CelestialFlashDiscountCopyWithImpl<CelestialFlashDiscount>(this as CelestialFlashDiscount, _$identity);

  /// Serializes this CelestialFlashDiscount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CelestialFlashDiscount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CelestialFlashDiscount&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.badgeText, _this.badgeText) || other.badgeText == _this.badgeText)&&(identical(other.discountPercent, _this.discountPercent) || other.discountPercent == _this.discountPercent)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.primaryColorHex, _this.primaryColorHex) || other.primaryColorHex == _this.primaryColorHex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CelestialFlashDiscount;
  return Object.hash(runtimeType,_this.title,_this.subtitle,_this.badgeText,_this.discountPercent,_this.expiresAt,_this.primaryColorHex);
}

@override
String toString() {
  final _this = this as CelestialFlashDiscount;
  return 'CelestialFlashDiscount(title: ${_this.title}, subtitle: ${_this.subtitle}, badgeText: ${_this.badgeText}, discountPercent: ${_this.discountPercent}, expiresAt: ${_this.expiresAt}, primaryColorHex: ${_this.primaryColorHex})';
}


}

/// @nodoc
abstract mixin class $CelestialFlashDiscountCopyWith<$Res>  {
  factory $CelestialFlashDiscountCopyWith(CelestialFlashDiscount value, $Res Function(CelestialFlashDiscount) _then) = _$CelestialFlashDiscountCopyWithImpl;
@useResult
$Res call({
 String title, String subtitle, String badgeText, int discountPercent, DateTime expiresAt, int primaryColorHex
});




}
/// @nodoc
class _$CelestialFlashDiscountCopyWithImpl<$Res>
    implements $CelestialFlashDiscountCopyWith<$Res> {
  _$CelestialFlashDiscountCopyWithImpl(this._self, this._then);

  final CelestialFlashDiscount _self;
  final $Res Function(CelestialFlashDiscount) _then;

/// Create a copy of CelestialFlashDiscount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subtitle = null,Object? badgeText = null,Object? discountPercent = null,Object? expiresAt = null,Object? primaryColorHex = null,}) {
  return _then(CelestialFlashDiscount(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,badgeText: null == badgeText ? _self.badgeText : badgeText // ignore: cast_nullable_to_non_nullable
as String,discountPercent: null == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,primaryColorHex: null == primaryColorHex ? _self.primaryColorHex : primaryColorHex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CelestialFlashDiscount].
extension CelestialFlashDiscountPatterns on CelestialFlashDiscount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CelestialFlashDiscount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CelestialFlashDiscount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CelestialFlashDiscount value)  $default,){
final _that = this;
switch (_that) {
case _CelestialFlashDiscount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CelestialFlashDiscount value)?  $default,){
final _that = this;
switch (_that) {
case _CelestialFlashDiscount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String subtitle,  String badgeText,  int discountPercent,  DateTime expiresAt,  int primaryColorHex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CelestialFlashDiscount() when $default != null:
return $default(_that.title,_that.subtitle,_that.badgeText,_that.discountPercent,_that.expiresAt,_that.primaryColorHex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String subtitle,  String badgeText,  int discountPercent,  DateTime expiresAt,  int primaryColorHex)  $default,) {final _that = this;
switch (_that) {
case _CelestialFlashDiscount():
return $default(_that.title,_that.subtitle,_that.badgeText,_that.discountPercent,_that.expiresAt,_that.primaryColorHex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String subtitle,  String badgeText,  int discountPercent,  DateTime expiresAt,  int primaryColorHex)?  $default,) {final _that = this;
switch (_that) {
case _CelestialFlashDiscount() when $default != null:
return $default(_that.title,_that.subtitle,_that.badgeText,_that.discountPercent,_that.expiresAt,_that.primaryColorHex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CelestialFlashDiscount implements CelestialFlashDiscount {
  const _CelestialFlashDiscount({required this.title, required this.subtitle, required this.badgeText, required this.discountPercent, required this.expiresAt, required this.primaryColorHex});
  factory _CelestialFlashDiscount.fromJson(Map<String, dynamic> json) => _$CelestialFlashDiscountFromJson(json);

@override final  String title;
@override final  String subtitle;
@override final  String badgeText;
@override final  int discountPercent;
@override final  DateTime expiresAt;
@override final  int primaryColorHex;

/// Create a copy of CelestialFlashDiscount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CelestialFlashDiscountCopyWith<_CelestialFlashDiscount> get copyWith => __$CelestialFlashDiscountCopyWithImpl<_CelestialFlashDiscount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CelestialFlashDiscountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CelestialFlashDiscount&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.badgeText, badgeText) || other.badgeText == badgeText)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.primaryColorHex, primaryColorHex) || other.primaryColorHex == primaryColorHex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,subtitle,badgeText,discountPercent,expiresAt,primaryColorHex);
}

@override
String toString() {
    return 'CelestialFlashDiscount(title: $title, subtitle: $subtitle, badgeText: $badgeText, discountPercent: $discountPercent, expiresAt: $expiresAt, primaryColorHex: $primaryColorHex)';
}


}

/// @nodoc
abstract mixin class _$CelestialFlashDiscountCopyWith<$Res> implements $CelestialFlashDiscountCopyWith<$Res> {
  factory _$CelestialFlashDiscountCopyWith(_CelestialFlashDiscount value, $Res Function(_CelestialFlashDiscount) _then) = __$CelestialFlashDiscountCopyWithImpl;
@override @useResult
$Res call({
 String title, String subtitle, String badgeText, int discountPercent, DateTime expiresAt, int primaryColorHex
});




}
/// @nodoc
class __$CelestialFlashDiscountCopyWithImpl<$Res>
    implements _$CelestialFlashDiscountCopyWith<$Res> {
  __$CelestialFlashDiscountCopyWithImpl(this._self, this._then);

  final _CelestialFlashDiscount _self;
  final $Res Function(_CelestialFlashDiscount) _then;

/// Create a copy of CelestialFlashDiscount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,Object? badgeText = null,Object? discountPercent = null,Object? expiresAt = null,Object? primaryColorHex = null,}) {
  return _then(_CelestialFlashDiscount(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,badgeText: null == badgeText ? _self.badgeText : badgeText // ignore: cast_nullable_to_non_nullable
as String,discountPercent: null == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,primaryColorHex: null == primaryColorHex ? _self.primaryColorHex : primaryColorHex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SynastryDossier {

 String get id; String get seekerName; String get partnerName; String get seekerSign; String get partnerSign; int get harmonyScore; String get connectionArchetype; String get channeledReading; List<String> get coreThemes; DateTime get generatedAt;
/// Create a copy of SynastryDossier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SynastryDossierCopyWith<SynastryDossier> get copyWith => _$SynastryDossierCopyWithImpl<SynastryDossier>(this as SynastryDossier, _$identity);

  /// Serializes this SynastryDossier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SynastryDossier;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SynastryDossier&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.seekerName, _this.seekerName) || other.seekerName == _this.seekerName)&&(identical(other.partnerName, _this.partnerName) || other.partnerName == _this.partnerName)&&(identical(other.seekerSign, _this.seekerSign) || other.seekerSign == _this.seekerSign)&&(identical(other.partnerSign, _this.partnerSign) || other.partnerSign == _this.partnerSign)&&(identical(other.harmonyScore, _this.harmonyScore) || other.harmonyScore == _this.harmonyScore)&&(identical(other.connectionArchetype, _this.connectionArchetype) || other.connectionArchetype == _this.connectionArchetype)&&(identical(other.channeledReading, _this.channeledReading) || other.channeledReading == _this.channeledReading)&&const DeepCollectionEquality().equals(other.coreThemes, _this.coreThemes)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SynastryDossier;
  return Object.hash(runtimeType,_this.id,_this.seekerName,_this.partnerName,_this.seekerSign,_this.partnerSign,_this.harmonyScore,_this.connectionArchetype,_this.channeledReading,const DeepCollectionEquality().hash(_this.coreThemes),_this.generatedAt);
}

@override
String toString() {
  final _this = this as SynastryDossier;
  return 'SynastryDossier(id: ${_this.id}, seekerName: ${_this.seekerName}, partnerName: ${_this.partnerName}, seekerSign: ${_this.seekerSign}, partnerSign: ${_this.partnerSign}, harmonyScore: ${_this.harmonyScore}, connectionArchetype: ${_this.connectionArchetype}, channeledReading: ${_this.channeledReading}, coreThemes: ${_this.coreThemes}, generatedAt: ${_this.generatedAt})';
}


}

/// @nodoc
abstract mixin class $SynastryDossierCopyWith<$Res>  {
  factory $SynastryDossierCopyWith(SynastryDossier value, $Res Function(SynastryDossier) _then) = _$SynastryDossierCopyWithImpl;
@useResult
$Res call({
 String id, String seekerName, String partnerName, String seekerSign, String partnerSign, int harmonyScore, String connectionArchetype, String channeledReading, List<String> coreThemes, DateTime generatedAt
});




}
/// @nodoc
class _$SynastryDossierCopyWithImpl<$Res>
    implements $SynastryDossierCopyWith<$Res> {
  _$SynastryDossierCopyWithImpl(this._self, this._then);

  final SynastryDossier _self;
  final $Res Function(SynastryDossier) _then;

/// Create a copy of SynastryDossier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? seekerName = null,Object? partnerName = null,Object? seekerSign = null,Object? partnerSign = null,Object? harmonyScore = null,Object? connectionArchetype = null,Object? channeledReading = null,Object? coreThemes = null,Object? generatedAt = null,}) {
  return _then(SynastryDossier(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,seekerName: null == seekerName ? _self.seekerName : seekerName // ignore: cast_nullable_to_non_nullable
as String,partnerName: null == partnerName ? _self.partnerName : partnerName // ignore: cast_nullable_to_non_nullable
as String,seekerSign: null == seekerSign ? _self.seekerSign : seekerSign // ignore: cast_nullable_to_non_nullable
as String,partnerSign: null == partnerSign ? _self.partnerSign : partnerSign // ignore: cast_nullable_to_non_nullable
as String,harmonyScore: null == harmonyScore ? _self.harmonyScore : harmonyScore // ignore: cast_nullable_to_non_nullable
as int,connectionArchetype: null == connectionArchetype ? _self.connectionArchetype : connectionArchetype // ignore: cast_nullable_to_non_nullable
as String,channeledReading: null == channeledReading ? _self.channeledReading : channeledReading // ignore: cast_nullable_to_non_nullable
as String,coreThemes: null == coreThemes ? _self.coreThemes : coreThemes // ignore: cast_nullable_to_non_nullable
as List<String>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SynastryDossier].
extension SynastryDossierPatterns on SynastryDossier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SynastryDossier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SynastryDossier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SynastryDossier value)  $default,){
final _that = this;
switch (_that) {
case _SynastryDossier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SynastryDossier value)?  $default,){
final _that = this;
switch (_that) {
case _SynastryDossier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String seekerName,  String partnerName,  String seekerSign,  String partnerSign,  int harmonyScore,  String connectionArchetype,  String channeledReading,  List<String> coreThemes,  DateTime generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SynastryDossier() when $default != null:
return $default(_that.id,_that.seekerName,_that.partnerName,_that.seekerSign,_that.partnerSign,_that.harmonyScore,_that.connectionArchetype,_that.channeledReading,_that.coreThemes,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String seekerName,  String partnerName,  String seekerSign,  String partnerSign,  int harmonyScore,  String connectionArchetype,  String channeledReading,  List<String> coreThemes,  DateTime generatedAt)  $default,) {final _that = this;
switch (_that) {
case _SynastryDossier():
return $default(_that.id,_that.seekerName,_that.partnerName,_that.seekerSign,_that.partnerSign,_that.harmonyScore,_that.connectionArchetype,_that.channeledReading,_that.coreThemes,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String seekerName,  String partnerName,  String seekerSign,  String partnerSign,  int harmonyScore,  String connectionArchetype,  String channeledReading,  List<String> coreThemes,  DateTime generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SynastryDossier() when $default != null:
return $default(_that.id,_that.seekerName,_that.partnerName,_that.seekerSign,_that.partnerSign,_that.harmonyScore,_that.connectionArchetype,_that.channeledReading,_that.coreThemes,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SynastryDossier implements SynastryDossier {
  const _SynastryDossier({required this.id, required this.seekerName, required this.partnerName, required this.seekerSign, required this.partnerSign, required this.harmonyScore, required this.connectionArchetype, required this.channeledReading, required  List<String> coreThemes, required this.generatedAt}): _coreThemes = coreThemes;
  factory _SynastryDossier.fromJson(Map<String, dynamic> json) => _$SynastryDossierFromJson(json);

@override final  String id;
@override final  String seekerName;
@override final  String partnerName;
@override final  String seekerSign;
@override final  String partnerSign;
@override final  int harmonyScore;
@override final  String connectionArchetype;
@override final  String channeledReading;
 final  List<String> _coreThemes;
@override List<String> get coreThemes {
  if (_coreThemes is EqualUnmodifiableListView) return _coreThemes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coreThemes);
}

@override final  DateTime generatedAt;

/// Create a copy of SynastryDossier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SynastryDossierCopyWith<_SynastryDossier> get copyWith => __$SynastryDossierCopyWithImpl<_SynastryDossier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SynastryDossierToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SynastryDossier&&(identical(other.id, id) || other.id == id)&&(identical(other.seekerName, seekerName) || other.seekerName == seekerName)&&(identical(other.partnerName, partnerName) || other.partnerName == partnerName)&&(identical(other.seekerSign, seekerSign) || other.seekerSign == seekerSign)&&(identical(other.partnerSign, partnerSign) || other.partnerSign == partnerSign)&&(identical(other.harmonyScore, harmonyScore) || other.harmonyScore == harmonyScore)&&(identical(other.connectionArchetype, connectionArchetype) || other.connectionArchetype == connectionArchetype)&&(identical(other.channeledReading, channeledReading) || other.channeledReading == channeledReading)&&const DeepCollectionEquality().equals(other.coreThemes, _coreThemes)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,seekerName,partnerName,seekerSign,partnerSign,harmonyScore,connectionArchetype,channeledReading,const DeepCollectionEquality().hash(_coreThemes),generatedAt);
}

@override
String toString() {
    return 'SynastryDossier(id: $id, seekerName: $seekerName, partnerName: $partnerName, seekerSign: $seekerSign, partnerSign: $partnerSign, harmonyScore: $harmonyScore, connectionArchetype: $connectionArchetype, channeledReading: $channeledReading, coreThemes: $coreThemes, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$SynastryDossierCopyWith<$Res> implements $SynastryDossierCopyWith<$Res> {
  factory _$SynastryDossierCopyWith(_SynastryDossier value, $Res Function(_SynastryDossier) _then) = __$SynastryDossierCopyWithImpl;
@override @useResult
$Res call({
 String id, String seekerName, String partnerName, String seekerSign, String partnerSign, int harmonyScore, String connectionArchetype, String channeledReading, List<String> coreThemes, DateTime generatedAt
});




}
/// @nodoc
class __$SynastryDossierCopyWithImpl<$Res>
    implements _$SynastryDossierCopyWith<$Res> {
  __$SynastryDossierCopyWithImpl(this._self, this._then);

  final _SynastryDossier _self;
  final $Res Function(_SynastryDossier) _then;

/// Create a copy of SynastryDossier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? seekerName = null,Object? partnerName = null,Object? seekerSign = null,Object? partnerSign = null,Object? harmonyScore = null,Object? connectionArchetype = null,Object? channeledReading = null,Object? coreThemes = null,Object? generatedAt = null,}) {
  return _then(_SynastryDossier(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,seekerName: null == seekerName ? _self.seekerName : seekerName // ignore: cast_nullable_to_non_nullable
as String,partnerName: null == partnerName ? _self.partnerName : partnerName // ignore: cast_nullable_to_non_nullable
as String,seekerSign: null == seekerSign ? _self.seekerSign : seekerSign // ignore: cast_nullable_to_non_nullable
as String,partnerSign: null == partnerSign ? _self.partnerSign : partnerSign // ignore: cast_nullable_to_non_nullable
as String,harmonyScore: null == harmonyScore ? _self.harmonyScore : harmonyScore // ignore: cast_nullable_to_non_nullable
as int,connectionArchetype: null == connectionArchetype ? _self.connectionArchetype : connectionArchetype // ignore: cast_nullable_to_non_nullable
as String,channeledReading: null == channeledReading ? _self.channeledReading : channeledReading // ignore: cast_nullable_to_non_nullable
as String,coreThemes: null == coreThemes ? _self._coreThemes : coreThemes // ignore: cast_nullable_to_non_nullable
as List<String>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
