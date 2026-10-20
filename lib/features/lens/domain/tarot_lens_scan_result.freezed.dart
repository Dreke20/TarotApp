// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tarot_lens_scan_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TarotLensScanResult {

 TarotCard get card; int get confidencePercent; bool get isReversed; List<String> get detectedSymbols; String get scryingAnalysis; String get physicalAltarRitual; String? get capturedImagePath; bool get isHighConfidence;
/// Create a copy of TarotLensScanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TarotLensScanResultCopyWith<TarotLensScanResult> get copyWith => _$TarotLensScanResultCopyWithImpl<TarotLensScanResult>(this as TarotLensScanResult, _$identity);

  /// Serializes this TarotLensScanResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TarotLensScanResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TarotLensScanResult&&(identical(other.card, _this.card) || other.card == _this.card)&&(identical(other.confidencePercent, _this.confidencePercent) || other.confidencePercent == _this.confidencePercent)&&(identical(other.isReversed, _this.isReversed) || other.isReversed == _this.isReversed)&&const DeepCollectionEquality().equals(other.detectedSymbols, _this.detectedSymbols)&&(identical(other.scryingAnalysis, _this.scryingAnalysis) || other.scryingAnalysis == _this.scryingAnalysis)&&(identical(other.physicalAltarRitual, _this.physicalAltarRitual) || other.physicalAltarRitual == _this.physicalAltarRitual)&&(identical(other.capturedImagePath, _this.capturedImagePath) || other.capturedImagePath == _this.capturedImagePath)&&(identical(other.isHighConfidence, _this.isHighConfidence) || other.isHighConfidence == _this.isHighConfidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TarotLensScanResult;
  return Object.hash(runtimeType,_this.card,_this.confidencePercent,_this.isReversed,const DeepCollectionEquality().hash(_this.detectedSymbols),_this.scryingAnalysis,_this.physicalAltarRitual,_this.capturedImagePath,_this.isHighConfidence);
}

@override
String toString() {
  final _this = this as TarotLensScanResult;
  return 'TarotLensScanResult(card: ${_this.card}, confidencePercent: ${_this.confidencePercent}, isReversed: ${_this.isReversed}, detectedSymbols: ${_this.detectedSymbols}, scryingAnalysis: ${_this.scryingAnalysis}, physicalAltarRitual: ${_this.physicalAltarRitual}, capturedImagePath: ${_this.capturedImagePath}, isHighConfidence: ${_this.isHighConfidence})';
}


}

/// @nodoc
abstract mixin class $TarotLensScanResultCopyWith<$Res>  {
  factory $TarotLensScanResultCopyWith(TarotLensScanResult value, $Res Function(TarotLensScanResult) _then) = _$TarotLensScanResultCopyWithImpl;
@useResult
$Res call({
 TarotCard card, int confidencePercent, bool isReversed, List<String> detectedSymbols, String scryingAnalysis, String physicalAltarRitual, String? capturedImagePath, bool isHighConfidence
});


$TarotCardCopyWith<$Res> get card;

}
/// @nodoc
class _$TarotLensScanResultCopyWithImpl<$Res>
    implements $TarotLensScanResultCopyWith<$Res> {
  _$TarotLensScanResultCopyWithImpl(this._self, this._then);

  final TarotLensScanResult _self;
  final $Res Function(TarotLensScanResult) _then;

/// Create a copy of TarotLensScanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? card = null,Object? confidencePercent = null,Object? isReversed = null,Object? detectedSymbols = null,Object? scryingAnalysis = null,Object? physicalAltarRitual = null,Object? capturedImagePath = freezed,Object? isHighConfidence = null,}) {
  return _then(TarotLensScanResult(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as TarotCard,confidencePercent: null == confidencePercent ? _self.confidencePercent : confidencePercent // ignore: cast_nullable_to_non_nullable
as int,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,detectedSymbols: null == detectedSymbols ? _self.detectedSymbols : detectedSymbols // ignore: cast_nullable_to_non_nullable
as List<String>,scryingAnalysis: null == scryingAnalysis ? _self.scryingAnalysis : scryingAnalysis // ignore: cast_nullable_to_non_nullable
as String,physicalAltarRitual: null == physicalAltarRitual ? _self.physicalAltarRitual : physicalAltarRitual // ignore: cast_nullable_to_non_nullable
as String,capturedImagePath: freezed == capturedImagePath ? _self.capturedImagePath : capturedImagePath // ignore: cast_nullable_to_non_nullable
as String?,isHighConfidence: null == isHighConfidence ? _self.isHighConfidence : isHighConfidence // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of TarotLensScanResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotCardCopyWith<$Res> get card {
  
  return $TarotCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}


/// Adds pattern-matching-related methods to [TarotLensScanResult].
extension TarotLensScanResultPatterns on TarotLensScanResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TarotLensScanResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TarotLensScanResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TarotLensScanResult value)  $default,){
final _that = this;
switch (_that) {
case _TarotLensScanResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TarotLensScanResult value)?  $default,){
final _that = this;
switch (_that) {
case _TarotLensScanResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TarotCard card,  int confidencePercent,  bool isReversed,  List<String> detectedSymbols,  String scryingAnalysis,  String physicalAltarRitual,  String? capturedImagePath,  bool isHighConfidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TarotLensScanResult() when $default != null:
return $default(_that.card,_that.confidencePercent,_that.isReversed,_that.detectedSymbols,_that.scryingAnalysis,_that.physicalAltarRitual,_that.capturedImagePath,_that.isHighConfidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TarotCard card,  int confidencePercent,  bool isReversed,  List<String> detectedSymbols,  String scryingAnalysis,  String physicalAltarRitual,  String? capturedImagePath,  bool isHighConfidence)  $default,) {final _that = this;
switch (_that) {
case _TarotLensScanResult():
return $default(_that.card,_that.confidencePercent,_that.isReversed,_that.detectedSymbols,_that.scryingAnalysis,_that.physicalAltarRitual,_that.capturedImagePath,_that.isHighConfidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TarotCard card,  int confidencePercent,  bool isReversed,  List<String> detectedSymbols,  String scryingAnalysis,  String physicalAltarRitual,  String? capturedImagePath,  bool isHighConfidence)?  $default,) {final _that = this;
switch (_that) {
case _TarotLensScanResult() when $default != null:
return $default(_that.card,_that.confidencePercent,_that.isReversed,_that.detectedSymbols,_that.scryingAnalysis,_that.physicalAltarRitual,_that.capturedImagePath,_that.isHighConfidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TarotLensScanResult implements TarotLensScanResult {
  const _TarotLensScanResult({required this.card, this.confidencePercent = 96, this.isReversed = false,  List<String> detectedSymbols = const [], required this.scryingAnalysis, required this.physicalAltarRitual, this.capturedImagePath, this.isHighConfidence = true}): _detectedSymbols = detectedSymbols;
  factory _TarotLensScanResult.fromJson(Map<String, dynamic> json) => _$TarotLensScanResultFromJson(json);

@override final  TarotCard card;
@override@JsonKey() final  int confidencePercent;
@override@JsonKey() final  bool isReversed;
 final  List<String> _detectedSymbols;
@override@JsonKey() List<String> get detectedSymbols {
  if (_detectedSymbols is EqualUnmodifiableListView) return _detectedSymbols;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_detectedSymbols);
}

@override final  String scryingAnalysis;
@override final  String physicalAltarRitual;
@override final  String? capturedImagePath;
@override@JsonKey() final  bool isHighConfidence;

/// Create a copy of TarotLensScanResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TarotLensScanResultCopyWith<_TarotLensScanResult> get copyWith => __$TarotLensScanResultCopyWithImpl<_TarotLensScanResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TarotLensScanResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TarotLensScanResult&&(identical(other.card, card) || other.card == card)&&(identical(other.confidencePercent, confidencePercent) || other.confidencePercent == confidencePercent)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed)&&const DeepCollectionEquality().equals(other.detectedSymbols, _detectedSymbols)&&(identical(other.scryingAnalysis, scryingAnalysis) || other.scryingAnalysis == scryingAnalysis)&&(identical(other.physicalAltarRitual, physicalAltarRitual) || other.physicalAltarRitual == physicalAltarRitual)&&(identical(other.capturedImagePath, capturedImagePath) || other.capturedImagePath == capturedImagePath)&&(identical(other.isHighConfidence, isHighConfidence) || other.isHighConfidence == isHighConfidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,card,confidencePercent,isReversed,const DeepCollectionEquality().hash(_detectedSymbols),scryingAnalysis,physicalAltarRitual,capturedImagePath,isHighConfidence);
}

@override
String toString() {
    return 'TarotLensScanResult(card: $card, confidencePercent: $confidencePercent, isReversed: $isReversed, detectedSymbols: $detectedSymbols, scryingAnalysis: $scryingAnalysis, physicalAltarRitual: $physicalAltarRitual, capturedImagePath: $capturedImagePath, isHighConfidence: $isHighConfidence)';
}


}

/// @nodoc
abstract mixin class _$TarotLensScanResultCopyWith<$Res> implements $TarotLensScanResultCopyWith<$Res> {
  factory _$TarotLensScanResultCopyWith(_TarotLensScanResult value, $Res Function(_TarotLensScanResult) _then) = __$TarotLensScanResultCopyWithImpl;
@override @useResult
$Res call({
 TarotCard card, int confidencePercent, bool isReversed, List<String> detectedSymbols, String scryingAnalysis, String physicalAltarRitual, String? capturedImagePath, bool isHighConfidence
});


@override $TarotCardCopyWith<$Res> get card;

}
/// @nodoc
class __$TarotLensScanResultCopyWithImpl<$Res>
    implements _$TarotLensScanResultCopyWith<$Res> {
  __$TarotLensScanResultCopyWithImpl(this._self, this._then);

  final _TarotLensScanResult _self;
  final $Res Function(_TarotLensScanResult) _then;

/// Create a copy of TarotLensScanResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? card = null,Object? confidencePercent = null,Object? isReversed = null,Object? detectedSymbols = null,Object? scryingAnalysis = null,Object? physicalAltarRitual = null,Object? capturedImagePath = freezed,Object? isHighConfidence = null,}) {
  return _then(_TarotLensScanResult(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as TarotCard,confidencePercent: null == confidencePercent ? _self.confidencePercent : confidencePercent // ignore: cast_nullable_to_non_nullable
as int,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,detectedSymbols: null == detectedSymbols ? _self._detectedSymbols : detectedSymbols // ignore: cast_nullable_to_non_nullable
as List<String>,scryingAnalysis: null == scryingAnalysis ? _self.scryingAnalysis : scryingAnalysis // ignore: cast_nullable_to_non_nullable
as String,physicalAltarRitual: null == physicalAltarRitual ? _self.physicalAltarRitual : physicalAltarRitual // ignore: cast_nullable_to_non_nullable
as String,capturedImagePath: freezed == capturedImagePath ? _self.capturedImagePath : capturedImagePath // ignore: cast_nullable_to_non_nullable
as String?,isHighConfidence: null == isHighConfidence ? _self.isHighConfidence : isHighConfidence // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of TarotLensScanResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TarotCardCopyWith<$Res> get card {
  
  return $TarotCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}

// dart format on
