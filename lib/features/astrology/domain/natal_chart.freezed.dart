// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'natal_chart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanetPlacement {

 String get planet; String get symbol; String get sign; String get element; String get house; String get meaning; String get tarotCorrelation;
/// Create a copy of PlanetPlacement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanetPlacementCopyWith<PlanetPlacement> get copyWith => _$PlanetPlacementCopyWithImpl<PlanetPlacement>(this as PlanetPlacement, _$identity);

  /// Serializes this PlanetPlacement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanetPlacement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanetPlacement&&(identical(other.planet, _this.planet) || other.planet == _this.planet)&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.sign, _this.sign) || other.sign == _this.sign)&&(identical(other.element, _this.element) || other.element == _this.element)&&(identical(other.house, _this.house) || other.house == _this.house)&&(identical(other.meaning, _this.meaning) || other.meaning == _this.meaning)&&(identical(other.tarotCorrelation, _this.tarotCorrelation) || other.tarotCorrelation == _this.tarotCorrelation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanetPlacement;
  return Object.hash(runtimeType,_this.planet,_this.symbol,_this.sign,_this.element,_this.house,_this.meaning,_this.tarotCorrelation);
}

@override
String toString() {
  final _this = this as PlanetPlacement;
  return 'PlanetPlacement(planet: ${_this.planet}, symbol: ${_this.symbol}, sign: ${_this.sign}, element: ${_this.element}, house: ${_this.house}, meaning: ${_this.meaning}, tarotCorrelation: ${_this.tarotCorrelation})';
}


}

/// @nodoc
abstract mixin class $PlanetPlacementCopyWith<$Res>  {
  factory $PlanetPlacementCopyWith(PlanetPlacement value, $Res Function(PlanetPlacement) _then) = _$PlanetPlacementCopyWithImpl;
@useResult
$Res call({
 String planet, String symbol, String sign, String element, String house, String meaning, String tarotCorrelation
});




}
/// @nodoc
class _$PlanetPlacementCopyWithImpl<$Res>
    implements $PlanetPlacementCopyWith<$Res> {
  _$PlanetPlacementCopyWithImpl(this._self, this._then);

  final PlanetPlacement _self;
  final $Res Function(PlanetPlacement) _then;

/// Create a copy of PlanetPlacement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planet = null,Object? symbol = null,Object? sign = null,Object? element = null,Object? house = null,Object? meaning = null,Object? tarotCorrelation = null,}) {
  return _then(PlanetPlacement(
planet: null == planet ? _self.planet : planet // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,house: null == house ? _self.house : house // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,tarotCorrelation: null == tarotCorrelation ? _self.tarotCorrelation : tarotCorrelation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanetPlacement].
extension PlanetPlacementPatterns on PlanetPlacement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanetPlacement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanetPlacement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanetPlacement value)  $default,){
final _that = this;
switch (_that) {
case _PlanetPlacement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanetPlacement value)?  $default,){
final _that = this;
switch (_that) {
case _PlanetPlacement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String planet,  String symbol,  String sign,  String element,  String house,  String meaning,  String tarotCorrelation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanetPlacement() when $default != null:
return $default(_that.planet,_that.symbol,_that.sign,_that.element,_that.house,_that.meaning,_that.tarotCorrelation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String planet,  String symbol,  String sign,  String element,  String house,  String meaning,  String tarotCorrelation)  $default,) {final _that = this;
switch (_that) {
case _PlanetPlacement():
return $default(_that.planet,_that.symbol,_that.sign,_that.element,_that.house,_that.meaning,_that.tarotCorrelation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String planet,  String symbol,  String sign,  String element,  String house,  String meaning,  String tarotCorrelation)?  $default,) {final _that = this;
switch (_that) {
case _PlanetPlacement() when $default != null:
return $default(_that.planet,_that.symbol,_that.sign,_that.element,_that.house,_that.meaning,_that.tarotCorrelation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanetPlacement implements PlanetPlacement {
  const _PlanetPlacement({required this.planet, required this.symbol, required this.sign, required this.element, required this.house, required this.meaning, required this.tarotCorrelation});
  factory _PlanetPlacement.fromJson(Map<String, dynamic> json) => _$PlanetPlacementFromJson(json);

@override final  String planet;
@override final  String symbol;
@override final  String sign;
@override final  String element;
@override final  String house;
@override final  String meaning;
@override final  String tarotCorrelation;

/// Create a copy of PlanetPlacement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanetPlacementCopyWith<_PlanetPlacement> get copyWith => __$PlanetPlacementCopyWithImpl<_PlanetPlacement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanetPlacementToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanetPlacement&&(identical(other.planet, planet) || other.planet == planet)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.element, element) || other.element == element)&&(identical(other.house, house) || other.house == house)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.tarotCorrelation, tarotCorrelation) || other.tarotCorrelation == tarotCorrelation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,planet,symbol,sign,element,house,meaning,tarotCorrelation);
}

@override
String toString() {
    return 'PlanetPlacement(planet: $planet, symbol: $symbol, sign: $sign, element: $element, house: $house, meaning: $meaning, tarotCorrelation: $tarotCorrelation)';
}


}

/// @nodoc
abstract mixin class _$PlanetPlacementCopyWith<$Res> implements $PlanetPlacementCopyWith<$Res> {
  factory _$PlanetPlacementCopyWith(_PlanetPlacement value, $Res Function(_PlanetPlacement) _then) = __$PlanetPlacementCopyWithImpl;
@override @useResult
$Res call({
 String planet, String symbol, String sign, String element, String house, String meaning, String tarotCorrelation
});




}
/// @nodoc
class __$PlanetPlacementCopyWithImpl<$Res>
    implements _$PlanetPlacementCopyWith<$Res> {
  __$PlanetPlacementCopyWithImpl(this._self, this._then);

  final _PlanetPlacement _self;
  final $Res Function(_PlanetPlacement) _then;

/// Create a copy of PlanetPlacement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planet = null,Object? symbol = null,Object? sign = null,Object? element = null,Object? house = null,Object? meaning = null,Object? tarotCorrelation = null,}) {
  return _then(_PlanetPlacement(
planet: null == planet ? _self.planet : planet // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as String,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,house: null == house ? _self.house : house // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,tarotCorrelation: null == tarotCorrelation ? _self.tarotCorrelation : tarotCorrelation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NatalChart {

 String get sunSign; String get moonSign; String get risingSign; List<PlanetPlacement> get placements; double get firePercent; double get earthPercent; double get airPercent; double get waterPercent; String get dominantElement; String get soulArchetype;
/// Create a copy of NatalChart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NatalChartCopyWith<NatalChart> get copyWith => _$NatalChartCopyWithImpl<NatalChart>(this as NatalChart, _$identity);

  /// Serializes this NatalChart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NatalChart;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NatalChart&&(identical(other.sunSign, _this.sunSign) || other.sunSign == _this.sunSign)&&(identical(other.moonSign, _this.moonSign) || other.moonSign == _this.moonSign)&&(identical(other.risingSign, _this.risingSign) || other.risingSign == _this.risingSign)&&const DeepCollectionEquality().equals(other.placements, _this.placements)&&(identical(other.firePercent, _this.firePercent) || other.firePercent == _this.firePercent)&&(identical(other.earthPercent, _this.earthPercent) || other.earthPercent == _this.earthPercent)&&(identical(other.airPercent, _this.airPercent) || other.airPercent == _this.airPercent)&&(identical(other.waterPercent, _this.waterPercent) || other.waterPercent == _this.waterPercent)&&(identical(other.dominantElement, _this.dominantElement) || other.dominantElement == _this.dominantElement)&&(identical(other.soulArchetype, _this.soulArchetype) || other.soulArchetype == _this.soulArchetype));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NatalChart;
  return Object.hash(runtimeType,_this.sunSign,_this.moonSign,_this.risingSign,const DeepCollectionEquality().hash(_this.placements),_this.firePercent,_this.earthPercent,_this.airPercent,_this.waterPercent,_this.dominantElement,_this.soulArchetype);
}

@override
String toString() {
  final _this = this as NatalChart;
  return 'NatalChart(sunSign: ${_this.sunSign}, moonSign: ${_this.moonSign}, risingSign: ${_this.risingSign}, placements: ${_this.placements}, firePercent: ${_this.firePercent}, earthPercent: ${_this.earthPercent}, airPercent: ${_this.airPercent}, waterPercent: ${_this.waterPercent}, dominantElement: ${_this.dominantElement}, soulArchetype: ${_this.soulArchetype})';
}


}

/// @nodoc
abstract mixin class $NatalChartCopyWith<$Res>  {
  factory $NatalChartCopyWith(NatalChart value, $Res Function(NatalChart) _then) = _$NatalChartCopyWithImpl;
@useResult
$Res call({
 String sunSign, String moonSign, String risingSign, List<PlanetPlacement> placements, double firePercent, double earthPercent, double airPercent, double waterPercent, String dominantElement, String soulArchetype
});




}
/// @nodoc
class _$NatalChartCopyWithImpl<$Res>
    implements $NatalChartCopyWith<$Res> {
  _$NatalChartCopyWithImpl(this._self, this._then);

  final NatalChart _self;
  final $Res Function(NatalChart) _then;

/// Create a copy of NatalChart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sunSign = null,Object? moonSign = null,Object? risingSign = null,Object? placements = null,Object? firePercent = null,Object? earthPercent = null,Object? airPercent = null,Object? waterPercent = null,Object? dominantElement = null,Object? soulArchetype = null,}) {
  return _then(NatalChart(
sunSign: null == sunSign ? _self.sunSign : sunSign // ignore: cast_nullable_to_non_nullable
as String,moonSign: null == moonSign ? _self.moonSign : moonSign // ignore: cast_nullable_to_non_nullable
as String,risingSign: null == risingSign ? _self.risingSign : risingSign // ignore: cast_nullable_to_non_nullable
as String,placements: null == placements ? _self.placements : placements // ignore: cast_nullable_to_non_nullable
as List<PlanetPlacement>,firePercent: null == firePercent ? _self.firePercent : firePercent // ignore: cast_nullable_to_non_nullable
as double,earthPercent: null == earthPercent ? _self.earthPercent : earthPercent // ignore: cast_nullable_to_non_nullable
as double,airPercent: null == airPercent ? _self.airPercent : airPercent // ignore: cast_nullable_to_non_nullable
as double,waterPercent: null == waterPercent ? _self.waterPercent : waterPercent // ignore: cast_nullable_to_non_nullable
as double,dominantElement: null == dominantElement ? _self.dominantElement : dominantElement // ignore: cast_nullable_to_non_nullable
as String,soulArchetype: null == soulArchetype ? _self.soulArchetype : soulArchetype // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NatalChart].
extension NatalChartPatterns on NatalChart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NatalChart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NatalChart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NatalChart value)  $default,){
final _that = this;
switch (_that) {
case _NatalChart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NatalChart value)?  $default,){
final _that = this;
switch (_that) {
case _NatalChart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sunSign,  String moonSign,  String risingSign,  List<PlanetPlacement> placements,  double firePercent,  double earthPercent,  double airPercent,  double waterPercent,  String dominantElement,  String soulArchetype)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NatalChart() when $default != null:
return $default(_that.sunSign,_that.moonSign,_that.risingSign,_that.placements,_that.firePercent,_that.earthPercent,_that.airPercent,_that.waterPercent,_that.dominantElement,_that.soulArchetype);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sunSign,  String moonSign,  String risingSign,  List<PlanetPlacement> placements,  double firePercent,  double earthPercent,  double airPercent,  double waterPercent,  String dominantElement,  String soulArchetype)  $default,) {final _that = this;
switch (_that) {
case _NatalChart():
return $default(_that.sunSign,_that.moonSign,_that.risingSign,_that.placements,_that.firePercent,_that.earthPercent,_that.airPercent,_that.waterPercent,_that.dominantElement,_that.soulArchetype);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sunSign,  String moonSign,  String risingSign,  List<PlanetPlacement> placements,  double firePercent,  double earthPercent,  double airPercent,  double waterPercent,  String dominantElement,  String soulArchetype)?  $default,) {final _that = this;
switch (_that) {
case _NatalChart() when $default != null:
return $default(_that.sunSign,_that.moonSign,_that.risingSign,_that.placements,_that.firePercent,_that.earthPercent,_that.airPercent,_that.waterPercent,_that.dominantElement,_that.soulArchetype);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NatalChart implements NatalChart {
  const _NatalChart({required this.sunSign, required this.moonSign, required this.risingSign, required  List<PlanetPlacement> placements, required this.firePercent, required this.earthPercent, required this.airPercent, required this.waterPercent, required this.dominantElement, required this.soulArchetype}): _placements = placements;
  factory _NatalChart.fromJson(Map<String, dynamic> json) => _$NatalChartFromJson(json);

@override final  String sunSign;
@override final  String moonSign;
@override final  String risingSign;
 final  List<PlanetPlacement> _placements;
@override List<PlanetPlacement> get placements {
  if (_placements is EqualUnmodifiableListView) return _placements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placements);
}

@override final  double firePercent;
@override final  double earthPercent;
@override final  double airPercent;
@override final  double waterPercent;
@override final  String dominantElement;
@override final  String soulArchetype;

/// Create a copy of NatalChart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NatalChartCopyWith<_NatalChart> get copyWith => __$NatalChartCopyWithImpl<_NatalChart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NatalChartToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NatalChart&&(identical(other.sunSign, sunSign) || other.sunSign == sunSign)&&(identical(other.moonSign, moonSign) || other.moonSign == moonSign)&&(identical(other.risingSign, risingSign) || other.risingSign == risingSign)&&const DeepCollectionEquality().equals(other.placements, _placements)&&(identical(other.firePercent, firePercent) || other.firePercent == firePercent)&&(identical(other.earthPercent, earthPercent) || other.earthPercent == earthPercent)&&(identical(other.airPercent, airPercent) || other.airPercent == airPercent)&&(identical(other.waterPercent, waterPercent) || other.waterPercent == waterPercent)&&(identical(other.dominantElement, dominantElement) || other.dominantElement == dominantElement)&&(identical(other.soulArchetype, soulArchetype) || other.soulArchetype == soulArchetype));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sunSign,moonSign,risingSign,const DeepCollectionEquality().hash(_placements),firePercent,earthPercent,airPercent,waterPercent,dominantElement,soulArchetype);
}

@override
String toString() {
    return 'NatalChart(sunSign: $sunSign, moonSign: $moonSign, risingSign: $risingSign, placements: $placements, firePercent: $firePercent, earthPercent: $earthPercent, airPercent: $airPercent, waterPercent: $waterPercent, dominantElement: $dominantElement, soulArchetype: $soulArchetype)';
}


}

/// @nodoc
abstract mixin class _$NatalChartCopyWith<$Res> implements $NatalChartCopyWith<$Res> {
  factory _$NatalChartCopyWith(_NatalChart value, $Res Function(_NatalChart) _then) = __$NatalChartCopyWithImpl;
@override @useResult
$Res call({
 String sunSign, String moonSign, String risingSign, List<PlanetPlacement> placements, double firePercent, double earthPercent, double airPercent, double waterPercent, String dominantElement, String soulArchetype
});




}
/// @nodoc
class __$NatalChartCopyWithImpl<$Res>
    implements _$NatalChartCopyWith<$Res> {
  __$NatalChartCopyWithImpl(this._self, this._then);

  final _NatalChart _self;
  final $Res Function(_NatalChart) _then;

/// Create a copy of NatalChart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sunSign = null,Object? moonSign = null,Object? risingSign = null,Object? placements = null,Object? firePercent = null,Object? earthPercent = null,Object? airPercent = null,Object? waterPercent = null,Object? dominantElement = null,Object? soulArchetype = null,}) {
  return _then(_NatalChart(
sunSign: null == sunSign ? _self.sunSign : sunSign // ignore: cast_nullable_to_non_nullable
as String,moonSign: null == moonSign ? _self.moonSign : moonSign // ignore: cast_nullable_to_non_nullable
as String,risingSign: null == risingSign ? _self.risingSign : risingSign // ignore: cast_nullable_to_non_nullable
as String,placements: null == placements ? _self._placements : placements // ignore: cast_nullable_to_non_nullable
as List<PlanetPlacement>,firePercent: null == firePercent ? _self.firePercent : firePercent // ignore: cast_nullable_to_non_nullable
as double,earthPercent: null == earthPercent ? _self.earthPercent : earthPercent // ignore: cast_nullable_to_non_nullable
as double,airPercent: null == airPercent ? _self.airPercent : airPercent // ignore: cast_nullable_to_non_nullable
as double,waterPercent: null == waterPercent ? _self.waterPercent : waterPercent // ignore: cast_nullable_to_non_nullable
as double,dominantElement: null == dominantElement ? _self.dominantElement : dominantElement // ignore: cast_nullable_to_non_nullable
as String,soulArchetype: null == soulArchetype ? _self.soulArchetype : soulArchetype // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
