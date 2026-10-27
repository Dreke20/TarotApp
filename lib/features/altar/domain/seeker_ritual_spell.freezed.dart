// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seeker_ritual_spell.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RitualSpellStep {

 String get id; RitualActionType get actionType; String get title; String get subtitle; String get glyph; String get parameter; int get durationSeconds;
/// Create a copy of RitualSpellStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RitualSpellStepCopyWith<RitualSpellStep> get copyWith => _$RitualSpellStepCopyWithImpl<RitualSpellStep>(this as RitualSpellStep, _$identity);

  /// Serializes this RitualSpellStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RitualSpellStep;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RitualSpellStep&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.actionType, _this.actionType) || other.actionType == _this.actionType)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.glyph, _this.glyph) || other.glyph == _this.glyph)&&(identical(other.parameter, _this.parameter) || other.parameter == _this.parameter)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RitualSpellStep;
  return Object.hash(runtimeType,_this.id,_this.actionType,_this.title,_this.subtitle,_this.glyph,_this.parameter,_this.durationSeconds);
}

@override
String toString() {
  final _this = this as RitualSpellStep;
  return 'RitualSpellStep(id: ${_this.id}, actionType: ${_this.actionType}, title: ${_this.title}, subtitle: ${_this.subtitle}, glyph: ${_this.glyph}, parameter: ${_this.parameter}, durationSeconds: ${_this.durationSeconds})';
}


}

/// @nodoc
abstract mixin class $RitualSpellStepCopyWith<$Res>  {
  factory $RitualSpellStepCopyWith(RitualSpellStep value, $Res Function(RitualSpellStep) _then) = _$RitualSpellStepCopyWithImpl;
@useResult
$Res call({
 String id, RitualActionType actionType, String title, String subtitle, String glyph, String parameter, int durationSeconds
});




}
/// @nodoc
class _$RitualSpellStepCopyWithImpl<$Res>
    implements $RitualSpellStepCopyWith<$Res> {
  _$RitualSpellStepCopyWithImpl(this._self, this._then);

  final RitualSpellStep _self;
  final $Res Function(RitualSpellStep) _then;

/// Create a copy of RitualSpellStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? actionType = null,Object? title = null,Object? subtitle = null,Object? glyph = null,Object? parameter = null,Object? durationSeconds = null,}) {
  return _then(RitualSpellStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as RitualActionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,glyph: null == glyph ? _self.glyph : glyph // ignore: cast_nullable_to_non_nullable
as String,parameter: null == parameter ? _self.parameter : parameter // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RitualSpellStep].
extension RitualSpellStepPatterns on RitualSpellStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RitualSpellStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RitualSpellStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RitualSpellStep value)  $default,){
final _that = this;
switch (_that) {
case _RitualSpellStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RitualSpellStep value)?  $default,){
final _that = this;
switch (_that) {
case _RitualSpellStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  RitualActionType actionType,  String title,  String subtitle,  String glyph,  String parameter,  int durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RitualSpellStep() when $default != null:
return $default(_that.id,_that.actionType,_that.title,_that.subtitle,_that.glyph,_that.parameter,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  RitualActionType actionType,  String title,  String subtitle,  String glyph,  String parameter,  int durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _RitualSpellStep():
return $default(_that.id,_that.actionType,_that.title,_that.subtitle,_that.glyph,_that.parameter,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  RitualActionType actionType,  String title,  String subtitle,  String glyph,  String parameter,  int durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _RitualSpellStep() when $default != null:
return $default(_that.id,_that.actionType,_that.title,_that.subtitle,_that.glyph,_that.parameter,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RitualSpellStep implements RitualSpellStep {
  const _RitualSpellStep({required this.id, required this.actionType, required this.title, required this.subtitle, required this.glyph, this.parameter = '', this.durationSeconds = 3});
  factory _RitualSpellStep.fromJson(Map<String, dynamic> json) => _$RitualSpellStepFromJson(json);

@override final  String id;
@override final  RitualActionType actionType;
@override final  String title;
@override final  String subtitle;
@override final  String glyph;
@override@JsonKey() final  String parameter;
@override@JsonKey() final  int durationSeconds;

/// Create a copy of RitualSpellStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RitualSpellStepCopyWith<_RitualSpellStep> get copyWith => __$RitualSpellStepCopyWithImpl<_RitualSpellStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RitualSpellStepToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RitualSpellStep&&(identical(other.id, id) || other.id == id)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.glyph, glyph) || other.glyph == glyph)&&(identical(other.parameter, parameter) || other.parameter == parameter)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,actionType,title,subtitle,glyph,parameter,durationSeconds);
}

@override
String toString() {
    return 'RitualSpellStep(id: $id, actionType: $actionType, title: $title, subtitle: $subtitle, glyph: $glyph, parameter: $parameter, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$RitualSpellStepCopyWith<$Res> implements $RitualSpellStepCopyWith<$Res> {
  factory _$RitualSpellStepCopyWith(_RitualSpellStep value, $Res Function(_RitualSpellStep) _then) = __$RitualSpellStepCopyWithImpl;
@override @useResult
$Res call({
 String id, RitualActionType actionType, String title, String subtitle, String glyph, String parameter, int durationSeconds
});




}
/// @nodoc
class __$RitualSpellStepCopyWithImpl<$Res>
    implements _$RitualSpellStepCopyWith<$Res> {
  __$RitualSpellStepCopyWithImpl(this._self, this._then);

  final _RitualSpellStep _self;
  final $Res Function(_RitualSpellStep) _then;

/// Create a copy of RitualSpellStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? actionType = null,Object? title = null,Object? subtitle = null,Object? glyph = null,Object? parameter = null,Object? durationSeconds = null,}) {
  return _then(_RitualSpellStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as RitualActionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,glyph: null == glyph ? _self.glyph : glyph // ignore: cast_nullable_to_non_nullable
as String,parameter: null == parameter ? _self.parameter : parameter // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SeekerRitualSpell {

 String get id; String get name; String get description; String get glyph; String get accentColorHex; List<RitualSpellStep> get steps; bool get isCurated; DateTime get createdAt;
/// Create a copy of SeekerRitualSpell
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeekerRitualSpellCopyWith<SeekerRitualSpell> get copyWith => _$SeekerRitualSpellCopyWithImpl<SeekerRitualSpell>(this as SeekerRitualSpell, _$identity);

  /// Serializes this SeekerRitualSpell to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SeekerRitualSpell;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeekerRitualSpell&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.glyph, _this.glyph) || other.glyph == _this.glyph)&&(identical(other.accentColorHex, _this.accentColorHex) || other.accentColorHex == _this.accentColorHex)&&const DeepCollectionEquality().equals(other.steps, _this.steps)&&(identical(other.isCurated, _this.isCurated) || other.isCurated == _this.isCurated)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SeekerRitualSpell;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.glyph,_this.accentColorHex,const DeepCollectionEquality().hash(_this.steps),_this.isCurated,_this.createdAt);
}

@override
String toString() {
  final _this = this as SeekerRitualSpell;
  return 'SeekerRitualSpell(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, glyph: ${_this.glyph}, accentColorHex: ${_this.accentColorHex}, steps: ${_this.steps}, isCurated: ${_this.isCurated}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $SeekerRitualSpellCopyWith<$Res>  {
  factory $SeekerRitualSpellCopyWith(SeekerRitualSpell value, $Res Function(SeekerRitualSpell) _then) = _$SeekerRitualSpellCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String glyph, String accentColorHex, List<RitualSpellStep> steps, bool isCurated, DateTime createdAt
});




}
/// @nodoc
class _$SeekerRitualSpellCopyWithImpl<$Res>
    implements $SeekerRitualSpellCopyWith<$Res> {
  _$SeekerRitualSpellCopyWithImpl(this._self, this._then);

  final SeekerRitualSpell _self;
  final $Res Function(SeekerRitualSpell) _then;

/// Create a copy of SeekerRitualSpell
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? glyph = null,Object? accentColorHex = null,Object? steps = null,Object? isCurated = null,Object? createdAt = null,}) {
  return _then(SeekerRitualSpell(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,glyph: null == glyph ? _self.glyph : glyph // ignore: cast_nullable_to_non_nullable
as String,accentColorHex: null == accentColorHex ? _self.accentColorHex : accentColorHex // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<RitualSpellStep>,isCurated: null == isCurated ? _self.isCurated : isCurated // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SeekerRitualSpell].
extension SeekerRitualSpellPatterns on SeekerRitualSpell {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeekerRitualSpell value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeekerRitualSpell() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeekerRitualSpell value)  $default,){
final _that = this;
switch (_that) {
case _SeekerRitualSpell():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeekerRitualSpell value)?  $default,){
final _that = this;
switch (_that) {
case _SeekerRitualSpell() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String glyph,  String accentColorHex,  List<RitualSpellStep> steps,  bool isCurated,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeekerRitualSpell() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.glyph,_that.accentColorHex,_that.steps,_that.isCurated,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String glyph,  String accentColorHex,  List<RitualSpellStep> steps,  bool isCurated,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SeekerRitualSpell():
return $default(_that.id,_that.name,_that.description,_that.glyph,_that.accentColorHex,_that.steps,_that.isCurated,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String glyph,  String accentColorHex,  List<RitualSpellStep> steps,  bool isCurated,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SeekerRitualSpell() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.glyph,_that.accentColorHex,_that.steps,_that.isCurated,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeekerRitualSpell extends SeekerRitualSpell {
  const _SeekerRitualSpell({required this.id, required this.name, required this.description, required this.glyph, this.accentColorHex = '#D4AF37', required  List<RitualSpellStep> steps, this.isCurated = false, required this.createdAt}): _steps = steps,super._();
  factory _SeekerRitualSpell.fromJson(Map<String, dynamic> json) => _$SeekerRitualSpellFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String glyph;
@override@JsonKey() final  String accentColorHex;
 final  List<RitualSpellStep> _steps;
@override List<RitualSpellStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override@JsonKey() final  bool isCurated;
@override final  DateTime createdAt;

/// Create a copy of SeekerRitualSpell
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeekerRitualSpellCopyWith<_SeekerRitualSpell> get copyWith => __$SeekerRitualSpellCopyWithImpl<_SeekerRitualSpell>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeekerRitualSpellToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeekerRitualSpell&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.glyph, glyph) || other.glyph == glyph)&&(identical(other.accentColorHex, accentColorHex) || other.accentColorHex == accentColorHex)&&const DeepCollectionEquality().equals(other.steps, _steps)&&(identical(other.isCurated, isCurated) || other.isCurated == isCurated)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,glyph,accentColorHex,const DeepCollectionEquality().hash(_steps),isCurated,createdAt);
}

@override
String toString() {
    return 'SeekerRitualSpell(id: $id, name: $name, description: $description, glyph: $glyph, accentColorHex: $accentColorHex, steps: $steps, isCurated: $isCurated, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SeekerRitualSpellCopyWith<$Res> implements $SeekerRitualSpellCopyWith<$Res> {
  factory _$SeekerRitualSpellCopyWith(_SeekerRitualSpell value, $Res Function(_SeekerRitualSpell) _then) = __$SeekerRitualSpellCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String glyph, String accentColorHex, List<RitualSpellStep> steps, bool isCurated, DateTime createdAt
});




}
/// @nodoc
class __$SeekerRitualSpellCopyWithImpl<$Res>
    implements _$SeekerRitualSpellCopyWith<$Res> {
  __$SeekerRitualSpellCopyWithImpl(this._self, this._then);

  final _SeekerRitualSpell _self;
  final $Res Function(_SeekerRitualSpell) _then;

/// Create a copy of SeekerRitualSpell
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? glyph = null,Object? accentColorHex = null,Object? steps = null,Object? isCurated = null,Object? createdAt = null,}) {
  return _then(_SeekerRitualSpell(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,glyph: null == glyph ? _self.glyph : glyph // ignore: cast_nullable_to_non_nullable
as String,accentColorHex: null == accentColorHex ? _self.accentColorHex : accentColorHex // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<RitualSpellStep>,isCurated: null == isCurated ? _self.isCurated : isCurated // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
