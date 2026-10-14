// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rune.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Rune {

 String get id; String get name; String get symbol; String get englishMeaning; String get aett; String get uprightMeaning; String get reversedMeaning; bool get isReversed; String? get positionName;
/// Create a copy of Rune
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuneCopyWith<Rune> get copyWith => _$RuneCopyWithImpl<Rune>(this as Rune, _$identity);

  /// Serializes this Rune to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Rune;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rune&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.englishMeaning, _this.englishMeaning) || other.englishMeaning == _this.englishMeaning)&&(identical(other.aett, _this.aett) || other.aett == _this.aett)&&(identical(other.uprightMeaning, _this.uprightMeaning) || other.uprightMeaning == _this.uprightMeaning)&&(identical(other.reversedMeaning, _this.reversedMeaning) || other.reversedMeaning == _this.reversedMeaning)&&(identical(other.isReversed, _this.isReversed) || other.isReversed == _this.isReversed)&&(identical(other.positionName, _this.positionName) || other.positionName == _this.positionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Rune;
  return Object.hash(runtimeType,_this.id,_this.name,_this.symbol,_this.englishMeaning,_this.aett,_this.uprightMeaning,_this.reversedMeaning,_this.isReversed,_this.positionName);
}

@override
String toString() {
  final _this = this as Rune;
  return 'Rune(id: ${_this.id}, name: ${_this.name}, symbol: ${_this.symbol}, englishMeaning: ${_this.englishMeaning}, aett: ${_this.aett}, uprightMeaning: ${_this.uprightMeaning}, reversedMeaning: ${_this.reversedMeaning}, isReversed: ${_this.isReversed}, positionName: ${_this.positionName})';
}


}

/// @nodoc
abstract mixin class $RuneCopyWith<$Res>  {
  factory $RuneCopyWith(Rune value, $Res Function(Rune) _then) = _$RuneCopyWithImpl;
@useResult
$Res call({
 String id, String name, String symbol, String englishMeaning, String aett, String uprightMeaning, String reversedMeaning, bool isReversed, String? positionName
});




}
/// @nodoc
class _$RuneCopyWithImpl<$Res>
    implements $RuneCopyWith<$Res> {
  _$RuneCopyWithImpl(this._self, this._then);

  final Rune _self;
  final $Res Function(Rune) _then;

/// Create a copy of Rune
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? symbol = null,Object? englishMeaning = null,Object? aett = null,Object? uprightMeaning = null,Object? reversedMeaning = null,Object? isReversed = null,Object? positionName = freezed,}) {
  return _then(Rune(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,englishMeaning: null == englishMeaning ? _self.englishMeaning : englishMeaning // ignore: cast_nullable_to_non_nullable
as String,aett: null == aett ? _self.aett : aett // ignore: cast_nullable_to_non_nullable
as String,uprightMeaning: null == uprightMeaning ? _self.uprightMeaning : uprightMeaning // ignore: cast_nullable_to_non_nullable
as String,reversedMeaning: null == reversedMeaning ? _self.reversedMeaning : reversedMeaning // ignore: cast_nullable_to_non_nullable
as String,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,positionName: freezed == positionName ? _self.positionName : positionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Rune].
extension RunePatterns on Rune {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Rune value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Rune() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Rune value)  $default,){
final _that = this;
switch (_that) {
case _Rune():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Rune value)?  $default,){
final _that = this;
switch (_that) {
case _Rune() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String symbol,  String englishMeaning,  String aett,  String uprightMeaning,  String reversedMeaning,  bool isReversed,  String? positionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Rune() when $default != null:
return $default(_that.id,_that.name,_that.symbol,_that.englishMeaning,_that.aett,_that.uprightMeaning,_that.reversedMeaning,_that.isReversed,_that.positionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String symbol,  String englishMeaning,  String aett,  String uprightMeaning,  String reversedMeaning,  bool isReversed,  String? positionName)  $default,) {final _that = this;
switch (_that) {
case _Rune():
return $default(_that.id,_that.name,_that.symbol,_that.englishMeaning,_that.aett,_that.uprightMeaning,_that.reversedMeaning,_that.isReversed,_that.positionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String symbol,  String englishMeaning,  String aett,  String uprightMeaning,  String reversedMeaning,  bool isReversed,  String? positionName)?  $default,) {final _that = this;
switch (_that) {
case _Rune() when $default != null:
return $default(_that.id,_that.name,_that.symbol,_that.englishMeaning,_that.aett,_that.uprightMeaning,_that.reversedMeaning,_that.isReversed,_that.positionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Rune implements Rune {
  const _Rune({required this.id, required this.name, required this.symbol, required this.englishMeaning, required this.aett, required this.uprightMeaning, required this.reversedMeaning, this.isReversed = false, this.positionName});
  factory _Rune.fromJson(Map<String, dynamic> json) => _$RuneFromJson(json);

@override final  String id;
@override final  String name;
@override final  String symbol;
@override final  String englishMeaning;
@override final  String aett;
@override final  String uprightMeaning;
@override final  String reversedMeaning;
@override@JsonKey() final  bool isReversed;
@override final  String? positionName;

/// Create a copy of Rune
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuneCopyWith<_Rune> get copyWith => __$RuneCopyWithImpl<_Rune>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RuneToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rune&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.englishMeaning, englishMeaning) || other.englishMeaning == englishMeaning)&&(identical(other.aett, aett) || other.aett == aett)&&(identical(other.uprightMeaning, uprightMeaning) || other.uprightMeaning == uprightMeaning)&&(identical(other.reversedMeaning, reversedMeaning) || other.reversedMeaning == reversedMeaning)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed)&&(identical(other.positionName, positionName) || other.positionName == positionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,symbol,englishMeaning,aett,uprightMeaning,reversedMeaning,isReversed,positionName);
}

@override
String toString() {
    return 'Rune(id: $id, name: $name, symbol: $symbol, englishMeaning: $englishMeaning, aett: $aett, uprightMeaning: $uprightMeaning, reversedMeaning: $reversedMeaning, isReversed: $isReversed, positionName: $positionName)';
}


}

/// @nodoc
abstract mixin class _$RuneCopyWith<$Res> implements $RuneCopyWith<$Res> {
  factory _$RuneCopyWith(_Rune value, $Res Function(_Rune) _then) = __$RuneCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String symbol, String englishMeaning, String aett, String uprightMeaning, String reversedMeaning, bool isReversed, String? positionName
});




}
/// @nodoc
class __$RuneCopyWithImpl<$Res>
    implements _$RuneCopyWith<$Res> {
  __$RuneCopyWithImpl(this._self, this._then);

  final _Rune _self;
  final $Res Function(_Rune) _then;

/// Create a copy of Rune
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? symbol = null,Object? englishMeaning = null,Object? aett = null,Object? uprightMeaning = null,Object? reversedMeaning = null,Object? isReversed = null,Object? positionName = freezed,}) {
  return _then(_Rune(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,englishMeaning: null == englishMeaning ? _self.englishMeaning : englishMeaning // ignore: cast_nullable_to_non_nullable
as String,aett: null == aett ? _self.aett : aett // ignore: cast_nullable_to_non_nullable
as String,uprightMeaning: null == uprightMeaning ? _self.uprightMeaning : uprightMeaning // ignore: cast_nullable_to_non_nullable
as String,reversedMeaning: null == reversedMeaning ? _self.reversedMeaning : reversedMeaning // ignore: cast_nullable_to_non_nullable
as String,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,positionName: freezed == positionName ? _self.positionName : positionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
