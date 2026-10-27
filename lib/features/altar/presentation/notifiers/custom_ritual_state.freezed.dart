// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_ritual_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomRitualState {

 List<SeekerRitualSpell> get customSpells; SeekerRitualSpell? get activeRunningSpell; int get activeStepIndex; bool get isRunning; bool get isCompleted; double get stepProgress;
/// Create a copy of CustomRitualState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomRitualStateCopyWith<CustomRitualState> get copyWith => _$CustomRitualStateCopyWithImpl<CustomRitualState>(this as CustomRitualState, _$identity);

  /// Serializes this CustomRitualState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomRitualState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomRitualState&&const DeepCollectionEquality().equals(other.customSpells, _this.customSpells)&&(identical(other.activeRunningSpell, _this.activeRunningSpell) || other.activeRunningSpell == _this.activeRunningSpell)&&(identical(other.activeStepIndex, _this.activeStepIndex) || other.activeStepIndex == _this.activeStepIndex)&&(identical(other.isRunning, _this.isRunning) || other.isRunning == _this.isRunning)&&(identical(other.isCompleted, _this.isCompleted) || other.isCompleted == _this.isCompleted)&&(identical(other.stepProgress, _this.stepProgress) || other.stepProgress == _this.stepProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomRitualState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.customSpells),_this.activeRunningSpell,_this.activeStepIndex,_this.isRunning,_this.isCompleted,_this.stepProgress);
}

@override
String toString() {
  final _this = this as CustomRitualState;
  return 'CustomRitualState(customSpells: ${_this.customSpells}, activeRunningSpell: ${_this.activeRunningSpell}, activeStepIndex: ${_this.activeStepIndex}, isRunning: ${_this.isRunning}, isCompleted: ${_this.isCompleted}, stepProgress: ${_this.stepProgress})';
}


}

/// @nodoc
abstract mixin class $CustomRitualStateCopyWith<$Res>  {
  factory $CustomRitualStateCopyWith(CustomRitualState value, $Res Function(CustomRitualState) _then) = _$CustomRitualStateCopyWithImpl;
@useResult
$Res call({
 List<SeekerRitualSpell> customSpells, SeekerRitualSpell? activeRunningSpell, int activeStepIndex, bool isRunning, bool isCompleted, double stepProgress
});


$SeekerRitualSpellCopyWith<$Res>? get activeRunningSpell;

}
/// @nodoc
class _$CustomRitualStateCopyWithImpl<$Res>
    implements $CustomRitualStateCopyWith<$Res> {
  _$CustomRitualStateCopyWithImpl(this._self, this._then);

  final CustomRitualState _self;
  final $Res Function(CustomRitualState) _then;

/// Create a copy of CustomRitualState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customSpells = null,Object? activeRunningSpell = freezed,Object? activeStepIndex = null,Object? isRunning = null,Object? isCompleted = null,Object? stepProgress = null,}) {
  return _then(CustomRitualState(
customSpells: null == customSpells ? _self.customSpells : customSpells // ignore: cast_nullable_to_non_nullable
as List<SeekerRitualSpell>,activeRunningSpell: freezed == activeRunningSpell ? _self.activeRunningSpell : activeRunningSpell // ignore: cast_nullable_to_non_nullable
as SeekerRitualSpell?,activeStepIndex: null == activeStepIndex ? _self.activeStepIndex : activeStepIndex // ignore: cast_nullable_to_non_nullable
as int,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,stepProgress: null == stepProgress ? _self.stepProgress : stepProgress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of CustomRitualState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeekerRitualSpellCopyWith<$Res>? get activeRunningSpell {
    if (_self.activeRunningSpell == null) {
    return null;
  }

  return $SeekerRitualSpellCopyWith<$Res>(_self.activeRunningSpell!, (value) {
    return _then(_self.copyWith(activeRunningSpell: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomRitualState].
extension CustomRitualStatePatterns on CustomRitualState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomRitualState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomRitualState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomRitualState value)  $default,){
final _that = this;
switch (_that) {
case _CustomRitualState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomRitualState value)?  $default,){
final _that = this;
switch (_that) {
case _CustomRitualState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SeekerRitualSpell> customSpells,  SeekerRitualSpell? activeRunningSpell,  int activeStepIndex,  bool isRunning,  bool isCompleted,  double stepProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomRitualState() when $default != null:
return $default(_that.customSpells,_that.activeRunningSpell,_that.activeStepIndex,_that.isRunning,_that.isCompleted,_that.stepProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SeekerRitualSpell> customSpells,  SeekerRitualSpell? activeRunningSpell,  int activeStepIndex,  bool isRunning,  bool isCompleted,  double stepProgress)  $default,) {final _that = this;
switch (_that) {
case _CustomRitualState():
return $default(_that.customSpells,_that.activeRunningSpell,_that.activeStepIndex,_that.isRunning,_that.isCompleted,_that.stepProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SeekerRitualSpell> customSpells,  SeekerRitualSpell? activeRunningSpell,  int activeStepIndex,  bool isRunning,  bool isCompleted,  double stepProgress)?  $default,) {final _that = this;
switch (_that) {
case _CustomRitualState() when $default != null:
return $default(_that.customSpells,_that.activeRunningSpell,_that.activeStepIndex,_that.isRunning,_that.isCompleted,_that.stepProgress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomRitualState extends CustomRitualState {
  const _CustomRitualState({ List<SeekerRitualSpell> customSpells = const [], this.activeRunningSpell, this.activeStepIndex = 0, this.isRunning = false, this.isCompleted = false, this.stepProgress = 0.0}): _customSpells = customSpells,super._();
  factory _CustomRitualState.fromJson(Map<String, dynamic> json) => _$CustomRitualStateFromJson(json);

 final  List<SeekerRitualSpell> _customSpells;
@override@JsonKey() List<SeekerRitualSpell> get customSpells {
  if (_customSpells is EqualUnmodifiableListView) return _customSpells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customSpells);
}

@override final  SeekerRitualSpell? activeRunningSpell;
@override@JsonKey() final  int activeStepIndex;
@override@JsonKey() final  bool isRunning;
@override@JsonKey() final  bool isCompleted;
@override@JsonKey() final  double stepProgress;

/// Create a copy of CustomRitualState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomRitualStateCopyWith<_CustomRitualState> get copyWith => __$CustomRitualStateCopyWithImpl<_CustomRitualState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomRitualStateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomRitualState&&const DeepCollectionEquality().equals(other.customSpells, _customSpells)&&(identical(other.activeRunningSpell, activeRunningSpell) || other.activeRunningSpell == activeRunningSpell)&&(identical(other.activeStepIndex, activeStepIndex) || other.activeStepIndex == activeStepIndex)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.stepProgress, stepProgress) || other.stepProgress == stepProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_customSpells),activeRunningSpell,activeStepIndex,isRunning,isCompleted,stepProgress);
}

@override
String toString() {
    return 'CustomRitualState(customSpells: $customSpells, activeRunningSpell: $activeRunningSpell, activeStepIndex: $activeStepIndex, isRunning: $isRunning, isCompleted: $isCompleted, stepProgress: $stepProgress)';
}


}

/// @nodoc
abstract mixin class _$CustomRitualStateCopyWith<$Res> implements $CustomRitualStateCopyWith<$Res> {
  factory _$CustomRitualStateCopyWith(_CustomRitualState value, $Res Function(_CustomRitualState) _then) = __$CustomRitualStateCopyWithImpl;
@override @useResult
$Res call({
 List<SeekerRitualSpell> customSpells, SeekerRitualSpell? activeRunningSpell, int activeStepIndex, bool isRunning, bool isCompleted, double stepProgress
});


@override $SeekerRitualSpellCopyWith<$Res>? get activeRunningSpell;

}
/// @nodoc
class __$CustomRitualStateCopyWithImpl<$Res>
    implements _$CustomRitualStateCopyWith<$Res> {
  __$CustomRitualStateCopyWithImpl(this._self, this._then);

  final _CustomRitualState _self;
  final $Res Function(_CustomRitualState) _then;

/// Create a copy of CustomRitualState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customSpells = null,Object? activeRunningSpell = freezed,Object? activeStepIndex = null,Object? isRunning = null,Object? isCompleted = null,Object? stepProgress = null,}) {
  return _then(_CustomRitualState(
customSpells: null == customSpells ? _self._customSpells : customSpells // ignore: cast_nullable_to_non_nullable
as List<SeekerRitualSpell>,activeRunningSpell: freezed == activeRunningSpell ? _self.activeRunningSpell : activeRunningSpell // ignore: cast_nullable_to_non_nullable
as SeekerRitualSpell?,activeStepIndex: null == activeStepIndex ? _self.activeStepIndex : activeStepIndex // ignore: cast_nullable_to_non_nullable
as int,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,stepProgress: null == stepProgress ? _self.stepProgress : stepProgress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of CustomRitualState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeekerRitualSpellCopyWith<$Res>? get activeRunningSpell {
    if (_self.activeRunningSpell == null) {
    return null;
  }

  return $SeekerRitualSpellCopyWith<$Res>(_self.activeRunningSpell!, (value) {
    return _then(_self.copyWith(activeRunningSpell: value));
  });
}
}

// dart format on
