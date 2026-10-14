// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_spread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomSpread {

 String get id; String get title; String get description; List<String> get positions; String get layoutType; bool get isUserCreated;
/// Create a copy of CustomSpread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomSpreadCopyWith<CustomSpread> get copyWith => _$CustomSpreadCopyWithImpl<CustomSpread>(this as CustomSpread, _$identity);

  /// Serializes this CustomSpread to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomSpread;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomSpread&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&const DeepCollectionEquality().equals(other.positions, _this.positions)&&(identical(other.layoutType, _this.layoutType) || other.layoutType == _this.layoutType)&&(identical(other.isUserCreated, _this.isUserCreated) || other.isUserCreated == _this.isUserCreated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomSpread;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,const DeepCollectionEquality().hash(_this.positions),_this.layoutType,_this.isUserCreated);
}

@override
String toString() {
  final _this = this as CustomSpread;
  return 'CustomSpread(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, positions: ${_this.positions}, layoutType: ${_this.layoutType}, isUserCreated: ${_this.isUserCreated})';
}


}

/// @nodoc
abstract mixin class $CustomSpreadCopyWith<$Res>  {
  factory $CustomSpreadCopyWith(CustomSpread value, $Res Function(CustomSpread) _then) = _$CustomSpreadCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, List<String> positions, String layoutType, bool isUserCreated
});




}
/// @nodoc
class _$CustomSpreadCopyWithImpl<$Res>
    implements $CustomSpreadCopyWith<$Res> {
  _$CustomSpreadCopyWithImpl(this._self, this._then);

  final CustomSpread _self;
  final $Res Function(CustomSpread) _then;

/// Create a copy of CustomSpread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? positions = null,Object? layoutType = null,Object? isUserCreated = null,}) {
  return _then(CustomSpread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,positions: null == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as List<String>,layoutType: null == layoutType ? _self.layoutType : layoutType // ignore: cast_nullable_to_non_nullable
as String,isUserCreated: null == isUserCreated ? _self.isUserCreated : isUserCreated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomSpread].
extension CustomSpreadPatterns on CustomSpread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomSpread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomSpread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomSpread value)  $default,){
final _that = this;
switch (_that) {
case _CustomSpread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomSpread value)?  $default,){
final _that = this;
switch (_that) {
case _CustomSpread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  List<String> positions,  String layoutType,  bool isUserCreated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomSpread() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.positions,_that.layoutType,_that.isUserCreated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  List<String> positions,  String layoutType,  bool isUserCreated)  $default,) {final _that = this;
switch (_that) {
case _CustomSpread():
return $default(_that.id,_that.title,_that.description,_that.positions,_that.layoutType,_that.isUserCreated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  List<String> positions,  String layoutType,  bool isUserCreated)?  $default,) {final _that = this;
switch (_that) {
case _CustomSpread() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.positions,_that.layoutType,_that.isUserCreated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomSpread implements CustomSpread {
  const _CustomSpread({required this.id, required this.title, required this.description, required  List<String> positions, this.layoutType = 'custom', this.isUserCreated = true}): _positions = positions;
  factory _CustomSpread.fromJson(Map<String, dynamic> json) => _$CustomSpreadFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
 final  List<String> _positions;
@override List<String> get positions {
  if (_positions is EqualUnmodifiableListView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positions);
}

@override@JsonKey() final  String layoutType;
@override@JsonKey() final  bool isUserCreated;

/// Create a copy of CustomSpread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomSpreadCopyWith<_CustomSpread> get copyWith => __$CustomSpreadCopyWithImpl<_CustomSpread>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomSpreadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomSpread&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.positions, _positions)&&(identical(other.layoutType, layoutType) || other.layoutType == layoutType)&&(identical(other.isUserCreated, isUserCreated) || other.isUserCreated == isUserCreated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,const DeepCollectionEquality().hash(_positions),layoutType,isUserCreated);
}

@override
String toString() {
    return 'CustomSpread(id: $id, title: $title, description: $description, positions: $positions, layoutType: $layoutType, isUserCreated: $isUserCreated)';
}


}

/// @nodoc
abstract mixin class _$CustomSpreadCopyWith<$Res> implements $CustomSpreadCopyWith<$Res> {
  factory _$CustomSpreadCopyWith(_CustomSpread value, $Res Function(_CustomSpread) _then) = __$CustomSpreadCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, List<String> positions, String layoutType, bool isUserCreated
});




}
/// @nodoc
class __$CustomSpreadCopyWithImpl<$Res>
    implements _$CustomSpreadCopyWith<$Res> {
  __$CustomSpreadCopyWithImpl(this._self, this._then);

  final _CustomSpread _self;
  final $Res Function(_CustomSpread) _then;

/// Create a copy of CustomSpread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? positions = null,Object? layoutType = null,Object? isUserCreated = null,}) {
  return _then(_CustomSpread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,positions: null == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as List<String>,layoutType: null == layoutType ? _self.layoutType : layoutType // ignore: cast_nullable_to_non_nullable
as String,isUserCreated: null == isUserCreated ? _self.isUserCreated : isUserCreated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
