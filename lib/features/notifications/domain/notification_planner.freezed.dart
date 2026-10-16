// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_planner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlannedNotification {

 int get id; NotificationKind get kind; String get title; String get body; DateTime get when;
/// Create a copy of PlannedNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannedNotificationCopyWith<PlannedNotification> get copyWith => _$PlannedNotificationCopyWithImpl<PlannedNotification>(this as PlannedNotification, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlannedNotification;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannedNotification&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.when, _this.when) || other.when == _this.when));
}


@override
int get hashCode {
  final _this = this as PlannedNotification;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.title,_this.body,_this.when);
}

@override
String toString() {
  final _this = this as PlannedNotification;
  return 'PlannedNotification(id: ${_this.id}, kind: ${_this.kind}, title: ${_this.title}, body: ${_this.body}, when: ${_this.when})';
}


}

/// @nodoc
abstract mixin class $PlannedNotificationCopyWith<$Res>  {
  factory $PlannedNotificationCopyWith(PlannedNotification value, $Res Function(PlannedNotification) _then) = _$PlannedNotificationCopyWithImpl;
@useResult
$Res call({
 int id, NotificationKind kind, String title, String body, DateTime when
});




}
/// @nodoc
class _$PlannedNotificationCopyWithImpl<$Res>
    implements $PlannedNotificationCopyWith<$Res> {
  _$PlannedNotificationCopyWithImpl(this._self, this._then);

  final PlannedNotification _self;
  final $Res Function(PlannedNotification) _then;

/// Create a copy of PlannedNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? body = null,Object? when = null,}) {
  return _then(PlannedNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NotificationKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,when: null == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannedNotification].
extension PlannedNotificationPatterns on PlannedNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannedNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannedNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannedNotification value)  $default,){
final _that = this;
switch (_that) {
case _PlannedNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannedNotification value)?  $default,){
final _that = this;
switch (_that) {
case _PlannedNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  NotificationKind kind,  String title,  String body,  DateTime when)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannedNotification() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.body,_that.when);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  NotificationKind kind,  String title,  String body,  DateTime when)  $default,) {final _that = this;
switch (_that) {
case _PlannedNotification():
return $default(_that.id,_that.kind,_that.title,_that.body,_that.when);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  NotificationKind kind,  String title,  String body,  DateTime when)?  $default,) {final _that = this;
switch (_that) {
case _PlannedNotification() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.body,_that.when);case _:
  return null;

}
}

}

/// @nodoc


class _PlannedNotification implements PlannedNotification {
  const _PlannedNotification({required this.id, required this.kind, required this.title, required this.body, required this.when});
  

@override final  int id;
@override final  NotificationKind kind;
@override final  String title;
@override final  String body;
@override final  DateTime when;

/// Create a copy of PlannedNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannedNotificationCopyWith<_PlannedNotification> get copyWith => __$PlannedNotificationCopyWithImpl<_PlannedNotification>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannedNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.when, when) || other.when == when));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,title,body,when);
}

@override
String toString() {
    return 'PlannedNotification(id: $id, kind: $kind, title: $title, body: $body, when: $when)';
}


}

/// @nodoc
abstract mixin class _$PlannedNotificationCopyWith<$Res> implements $PlannedNotificationCopyWith<$Res> {
  factory _$PlannedNotificationCopyWith(_PlannedNotification value, $Res Function(_PlannedNotification) _then) = __$PlannedNotificationCopyWithImpl;
@override @useResult
$Res call({
 int id, NotificationKind kind, String title, String body, DateTime when
});




}
/// @nodoc
class __$PlannedNotificationCopyWithImpl<$Res>
    implements _$PlannedNotificationCopyWith<$Res> {
  __$PlannedNotificationCopyWithImpl(this._self, this._then);

  final _PlannedNotification _self;
  final $Res Function(_PlannedNotification) _then;

/// Create a copy of PlannedNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? body = null,Object? when = null,}) {
  return _then(_PlannedNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NotificationKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,when: null == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
