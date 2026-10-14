// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hexagram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hexagram {

 int get number; String get name; String get englishTitle; String get chineseCharacter; String get upperTrigram; String get lowerTrigram; List<int> get lines; String get judgment; String get image; String get guidance;
/// Create a copy of Hexagram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HexagramCopyWith<Hexagram> get copyWith => _$HexagramCopyWithImpl<Hexagram>(this as Hexagram, _$identity);

  /// Serializes this Hexagram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Hexagram;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hexagram&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.englishTitle, _this.englishTitle) || other.englishTitle == _this.englishTitle)&&(identical(other.chineseCharacter, _this.chineseCharacter) || other.chineseCharacter == _this.chineseCharacter)&&(identical(other.upperTrigram, _this.upperTrigram) || other.upperTrigram == _this.upperTrigram)&&(identical(other.lowerTrigram, _this.lowerTrigram) || other.lowerTrigram == _this.lowerTrigram)&&const DeepCollectionEquality().equals(other.lines, _this.lines)&&(identical(other.judgment, _this.judgment) || other.judgment == _this.judgment)&&(identical(other.image, _this.image) || other.image == _this.image)&&(identical(other.guidance, _this.guidance) || other.guidance == _this.guidance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Hexagram;
  return Object.hash(runtimeType,_this.number,_this.name,_this.englishTitle,_this.chineseCharacter,_this.upperTrigram,_this.lowerTrigram,const DeepCollectionEquality().hash(_this.lines),_this.judgment,_this.image,_this.guidance);
}

@override
String toString() {
  final _this = this as Hexagram;
  return 'Hexagram(number: ${_this.number}, name: ${_this.name}, englishTitle: ${_this.englishTitle}, chineseCharacter: ${_this.chineseCharacter}, upperTrigram: ${_this.upperTrigram}, lowerTrigram: ${_this.lowerTrigram}, lines: ${_this.lines}, judgment: ${_this.judgment}, image: ${_this.image}, guidance: ${_this.guidance})';
}


}

/// @nodoc
abstract mixin class $HexagramCopyWith<$Res>  {
  factory $HexagramCopyWith(Hexagram value, $Res Function(Hexagram) _then) = _$HexagramCopyWithImpl;
@useResult
$Res call({
 int number, String name, String englishTitle, String chineseCharacter, String upperTrigram, String lowerTrigram, List<int> lines, String judgment, String image, String guidance
});




}
/// @nodoc
class _$HexagramCopyWithImpl<$Res>
    implements $HexagramCopyWith<$Res> {
  _$HexagramCopyWithImpl(this._self, this._then);

  final Hexagram _self;
  final $Res Function(Hexagram) _then;

/// Create a copy of Hexagram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? name = null,Object? englishTitle = null,Object? chineseCharacter = null,Object? upperTrigram = null,Object? lowerTrigram = null,Object? lines = null,Object? judgment = null,Object? image = null,Object? guidance = null,}) {
  return _then(Hexagram(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishTitle: null == englishTitle ? _self.englishTitle : englishTitle // ignore: cast_nullable_to_non_nullable
as String,chineseCharacter: null == chineseCharacter ? _self.chineseCharacter : chineseCharacter // ignore: cast_nullable_to_non_nullable
as String,upperTrigram: null == upperTrigram ? _self.upperTrigram : upperTrigram // ignore: cast_nullable_to_non_nullable
as String,lowerTrigram: null == lowerTrigram ? _self.lowerTrigram : lowerTrigram // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<int>,judgment: null == judgment ? _self.judgment : judgment // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,guidance: null == guidance ? _self.guidance : guidance // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Hexagram].
extension HexagramPatterns on Hexagram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hexagram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hexagram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hexagram value)  $default,){
final _that = this;
switch (_that) {
case _Hexagram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hexagram value)?  $default,){
final _that = this;
switch (_that) {
case _Hexagram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String name,  String englishTitle,  String chineseCharacter,  String upperTrigram,  String lowerTrigram,  List<int> lines,  String judgment,  String image,  String guidance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hexagram() when $default != null:
return $default(_that.number,_that.name,_that.englishTitle,_that.chineseCharacter,_that.upperTrigram,_that.lowerTrigram,_that.lines,_that.judgment,_that.image,_that.guidance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String name,  String englishTitle,  String chineseCharacter,  String upperTrigram,  String lowerTrigram,  List<int> lines,  String judgment,  String image,  String guidance)  $default,) {final _that = this;
switch (_that) {
case _Hexagram():
return $default(_that.number,_that.name,_that.englishTitle,_that.chineseCharacter,_that.upperTrigram,_that.lowerTrigram,_that.lines,_that.judgment,_that.image,_that.guidance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String name,  String englishTitle,  String chineseCharacter,  String upperTrigram,  String lowerTrigram,  List<int> lines,  String judgment,  String image,  String guidance)?  $default,) {final _that = this;
switch (_that) {
case _Hexagram() when $default != null:
return $default(_that.number,_that.name,_that.englishTitle,_that.chineseCharacter,_that.upperTrigram,_that.lowerTrigram,_that.lines,_that.judgment,_that.image,_that.guidance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hexagram implements Hexagram {
  const _Hexagram({required this.number, required this.name, required this.englishTitle, required this.chineseCharacter, required this.upperTrigram, required this.lowerTrigram, required  List<int> lines, required this.judgment, required this.image, required this.guidance}): _lines = lines;
  factory _Hexagram.fromJson(Map<String, dynamic> json) => _$HexagramFromJson(json);

@override final  int number;
@override final  String name;
@override final  String englishTitle;
@override final  String chineseCharacter;
@override final  String upperTrigram;
@override final  String lowerTrigram;
 final  List<int> _lines;
@override List<int> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  String judgment;
@override final  String image;
@override final  String guidance;

/// Create a copy of Hexagram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HexagramCopyWith<_Hexagram> get copyWith => __$HexagramCopyWithImpl<_Hexagram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HexagramToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hexagram&&(identical(other.number, number) || other.number == number)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishTitle, englishTitle) || other.englishTitle == englishTitle)&&(identical(other.chineseCharacter, chineseCharacter) || other.chineseCharacter == chineseCharacter)&&(identical(other.upperTrigram, upperTrigram) || other.upperTrigram == upperTrigram)&&(identical(other.lowerTrigram, lowerTrigram) || other.lowerTrigram == lowerTrigram)&&const DeepCollectionEquality().equals(other.lines, _lines)&&(identical(other.judgment, judgment) || other.judgment == judgment)&&(identical(other.image, image) || other.image == image)&&(identical(other.guidance, guidance) || other.guidance == guidance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,number,name,englishTitle,chineseCharacter,upperTrigram,lowerTrigram,const DeepCollectionEquality().hash(_lines),judgment,image,guidance);
}

@override
String toString() {
    return 'Hexagram(number: $number, name: $name, englishTitle: $englishTitle, chineseCharacter: $chineseCharacter, upperTrigram: $upperTrigram, lowerTrigram: $lowerTrigram, lines: $lines, judgment: $judgment, image: $image, guidance: $guidance)';
}


}

/// @nodoc
abstract mixin class _$HexagramCopyWith<$Res> implements $HexagramCopyWith<$Res> {
  factory _$HexagramCopyWith(_Hexagram value, $Res Function(_Hexagram) _then) = __$HexagramCopyWithImpl;
@override @useResult
$Res call({
 int number, String name, String englishTitle, String chineseCharacter, String upperTrigram, String lowerTrigram, List<int> lines, String judgment, String image, String guidance
});




}
/// @nodoc
class __$HexagramCopyWithImpl<$Res>
    implements _$HexagramCopyWith<$Res> {
  __$HexagramCopyWithImpl(this._self, this._then);

  final _Hexagram _self;
  final $Res Function(_Hexagram) _then;

/// Create a copy of Hexagram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? name = null,Object? englishTitle = null,Object? chineseCharacter = null,Object? upperTrigram = null,Object? lowerTrigram = null,Object? lines = null,Object? judgment = null,Object? image = null,Object? guidance = null,}) {
  return _then(_Hexagram(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishTitle: null == englishTitle ? _self.englishTitle : englishTitle // ignore: cast_nullable_to_non_nullable
as String,chineseCharacter: null == chineseCharacter ? _self.chineseCharacter : chineseCharacter // ignore: cast_nullable_to_non_nullable
as String,upperTrigram: null == upperTrigram ? _self.upperTrigram : upperTrigram // ignore: cast_nullable_to_non_nullable
as String,lowerTrigram: null == lowerTrigram ? _self.lowerTrigram : lowerTrigram // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<int>,judgment: null == judgment ? _self.judgment : judgment // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,guidance: null == guidance ? _self.guidance : guidance // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
