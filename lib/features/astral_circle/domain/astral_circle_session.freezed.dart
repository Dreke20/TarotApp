// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astral_circle_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AstralCardPlacement {

 String get cardId; int get positionIndex; bool get isReversed; AstralParticipantRole get placedBy; String get placedByName; DateTime get timestamp;
/// Create a copy of AstralCardPlacement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstralCardPlacementCopyWith<AstralCardPlacement> get copyWith => _$AstralCardPlacementCopyWithImpl<AstralCardPlacement>(this as AstralCardPlacement, _$identity);

  /// Serializes this AstralCardPlacement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AstralCardPlacement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstralCardPlacement&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.positionIndex, _this.positionIndex) || other.positionIndex == _this.positionIndex)&&(identical(other.isReversed, _this.isReversed) || other.isReversed == _this.isReversed)&&(identical(other.placedBy, _this.placedBy) || other.placedBy == _this.placedBy)&&(identical(other.placedByName, _this.placedByName) || other.placedByName == _this.placedByName)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AstralCardPlacement;
  return Object.hash(runtimeType,_this.cardId,_this.positionIndex,_this.isReversed,_this.placedBy,_this.placedByName,_this.timestamp);
}

@override
String toString() {
  final _this = this as AstralCardPlacement;
  return 'AstralCardPlacement(cardId: ${_this.cardId}, positionIndex: ${_this.positionIndex}, isReversed: ${_this.isReversed}, placedBy: ${_this.placedBy}, placedByName: ${_this.placedByName}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $AstralCardPlacementCopyWith<$Res>  {
  factory $AstralCardPlacementCopyWith(AstralCardPlacement value, $Res Function(AstralCardPlacement) _then) = _$AstralCardPlacementCopyWithImpl;
@useResult
$Res call({
 String cardId, int positionIndex, bool isReversed, AstralParticipantRole placedBy, String placedByName, DateTime timestamp
});




}
/// @nodoc
class _$AstralCardPlacementCopyWithImpl<$Res>
    implements $AstralCardPlacementCopyWith<$Res> {
  _$AstralCardPlacementCopyWithImpl(this._self, this._then);

  final AstralCardPlacement _self;
  final $Res Function(AstralCardPlacement) _then;

/// Create a copy of AstralCardPlacement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardId = null,Object? positionIndex = null,Object? isReversed = null,Object? placedBy = null,Object? placedByName = null,Object? timestamp = null,}) {
  return _then(AstralCardPlacement(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,positionIndex: null == positionIndex ? _self.positionIndex : positionIndex // ignore: cast_nullable_to_non_nullable
as int,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,placedBy: null == placedBy ? _self.placedBy : placedBy // ignore: cast_nullable_to_non_nullable
as AstralParticipantRole,placedByName: null == placedByName ? _self.placedByName : placedByName // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AstralCardPlacement].
extension AstralCardPlacementPatterns on AstralCardPlacement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AstralCardPlacement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AstralCardPlacement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AstralCardPlacement value)  $default,){
final _that = this;
switch (_that) {
case _AstralCardPlacement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AstralCardPlacement value)?  $default,){
final _that = this;
switch (_that) {
case _AstralCardPlacement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cardId,  int positionIndex,  bool isReversed,  AstralParticipantRole placedBy,  String placedByName,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AstralCardPlacement() when $default != null:
return $default(_that.cardId,_that.positionIndex,_that.isReversed,_that.placedBy,_that.placedByName,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cardId,  int positionIndex,  bool isReversed,  AstralParticipantRole placedBy,  String placedByName,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _AstralCardPlacement():
return $default(_that.cardId,_that.positionIndex,_that.isReversed,_that.placedBy,_that.placedByName,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cardId,  int positionIndex,  bool isReversed,  AstralParticipantRole placedBy,  String placedByName,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _AstralCardPlacement() when $default != null:
return $default(_that.cardId,_that.positionIndex,_that.isReversed,_that.placedBy,_that.placedByName,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AstralCardPlacement implements AstralCardPlacement {
  const _AstralCardPlacement({required this.cardId, required this.positionIndex, this.isReversed = false, required this.placedBy, required this.placedByName, required this.timestamp});
  factory _AstralCardPlacement.fromJson(Map<String, dynamic> json) => _$AstralCardPlacementFromJson(json);

@override final  String cardId;
@override final  int positionIndex;
@override@JsonKey() final  bool isReversed;
@override final  AstralParticipantRole placedBy;
@override final  String placedByName;
@override final  DateTime timestamp;

/// Create a copy of AstralCardPlacement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstralCardPlacementCopyWith<_AstralCardPlacement> get copyWith => __$AstralCardPlacementCopyWithImpl<_AstralCardPlacement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AstralCardPlacementToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstralCardPlacement&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.positionIndex, positionIndex) || other.positionIndex == positionIndex)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed)&&(identical(other.placedBy, placedBy) || other.placedBy == placedBy)&&(identical(other.placedByName, placedByName) || other.placedByName == placedByName)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,cardId,positionIndex,isReversed,placedBy,placedByName,timestamp);
}

@override
String toString() {
    return 'AstralCardPlacement(cardId: $cardId, positionIndex: $positionIndex, isReversed: $isReversed, placedBy: $placedBy, placedByName: $placedByName, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$AstralCardPlacementCopyWith<$Res> implements $AstralCardPlacementCopyWith<$Res> {
  factory _$AstralCardPlacementCopyWith(_AstralCardPlacement value, $Res Function(_AstralCardPlacement) _then) = __$AstralCardPlacementCopyWithImpl;
@override @useResult
$Res call({
 String cardId, int positionIndex, bool isReversed, AstralParticipantRole placedBy, String placedByName, DateTime timestamp
});




}
/// @nodoc
class __$AstralCardPlacementCopyWithImpl<$Res>
    implements _$AstralCardPlacementCopyWith<$Res> {
  __$AstralCardPlacementCopyWithImpl(this._self, this._then);

  final _AstralCardPlacement _self;
  final $Res Function(_AstralCardPlacement) _then;

/// Create a copy of AstralCardPlacement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardId = null,Object? positionIndex = null,Object? isReversed = null,Object? placedBy = null,Object? placedByName = null,Object? timestamp = null,}) {
  return _then(_AstralCardPlacement(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,positionIndex: null == positionIndex ? _self.positionIndex : positionIndex // ignore: cast_nullable_to_non_nullable
as int,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,placedBy: null == placedBy ? _self.placedBy : placedBy // ignore: cast_nullable_to_non_nullable
as AstralParticipantRole,placedByName: null == placedByName ? _self.placedByName : placedByName // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$AstralCircleSession {

 String get id; String get roomCode; String get hostId; String get hostName; String? get guestId; String? get guestName; String get spreadType; List<AstralCardPlacement> get drawnCards; AstralParticipantRole get activeTurn; String? get oracleSynthesis; AstralCircleStatus get status; DateTime get createdAt;
/// Create a copy of AstralCircleSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstralCircleSessionCopyWith<AstralCircleSession> get copyWith => _$AstralCircleSessionCopyWithImpl<AstralCircleSession>(this as AstralCircleSession, _$identity);

  /// Serializes this AstralCircleSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AstralCircleSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstralCircleSession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomCode, _this.roomCode) || other.roomCode == _this.roomCode)&&(identical(other.hostId, _this.hostId) || other.hostId == _this.hostId)&&(identical(other.hostName, _this.hostName) || other.hostName == _this.hostName)&&(identical(other.guestId, _this.guestId) || other.guestId == _this.guestId)&&(identical(other.guestName, _this.guestName) || other.guestName == _this.guestName)&&(identical(other.spreadType, _this.spreadType) || other.spreadType == _this.spreadType)&&const DeepCollectionEquality().equals(other.drawnCards, _this.drawnCards)&&(identical(other.activeTurn, _this.activeTurn) || other.activeTurn == _this.activeTurn)&&(identical(other.oracleSynthesis, _this.oracleSynthesis) || other.oracleSynthesis == _this.oracleSynthesis)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AstralCircleSession;
  return Object.hash(runtimeType,_this.id,_this.roomCode,_this.hostId,_this.hostName,_this.guestId,_this.guestName,_this.spreadType,const DeepCollectionEquality().hash(_this.drawnCards),_this.activeTurn,_this.oracleSynthesis,_this.status,_this.createdAt);
}

@override
String toString() {
  final _this = this as AstralCircleSession;
  return 'AstralCircleSession(id: ${_this.id}, roomCode: ${_this.roomCode}, hostId: ${_this.hostId}, hostName: ${_this.hostName}, guestId: ${_this.guestId}, guestName: ${_this.guestName}, spreadType: ${_this.spreadType}, drawnCards: ${_this.drawnCards}, activeTurn: ${_this.activeTurn}, oracleSynthesis: ${_this.oracleSynthesis}, status: ${_this.status}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $AstralCircleSessionCopyWith<$Res>  {
  factory $AstralCircleSessionCopyWith(AstralCircleSession value, $Res Function(AstralCircleSession) _then) = _$AstralCircleSessionCopyWithImpl;
@useResult
$Res call({
 String id, String roomCode, String hostId, String hostName, String? guestId, String? guestName, String spreadType, List<AstralCardPlacement> drawnCards, AstralParticipantRole activeTurn, String? oracleSynthesis, AstralCircleStatus status, DateTime createdAt
});




}
/// @nodoc
class _$AstralCircleSessionCopyWithImpl<$Res>
    implements $AstralCircleSessionCopyWith<$Res> {
  _$AstralCircleSessionCopyWithImpl(this._self, this._then);

  final AstralCircleSession _self;
  final $Res Function(AstralCircleSession) _then;

/// Create a copy of AstralCircleSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomCode = null,Object? hostId = null,Object? hostName = null,Object? guestId = freezed,Object? guestName = freezed,Object? spreadType = null,Object? drawnCards = null,Object? activeTurn = null,Object? oracleSynthesis = freezed,Object? status = null,Object? createdAt = null,}) {
  return _then(AstralCircleSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomCode: null == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as String,hostId: null == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String,hostName: null == hostName ? _self.hostName : hostName // ignore: cast_nullable_to_non_nullable
as String,guestId: freezed == guestId ? _self.guestId : guestId // ignore: cast_nullable_to_non_nullable
as String?,guestName: freezed == guestName ? _self.guestName : guestName // ignore: cast_nullable_to_non_nullable
as String?,spreadType: null == spreadType ? _self.spreadType : spreadType // ignore: cast_nullable_to_non_nullable
as String,drawnCards: null == drawnCards ? _self.drawnCards : drawnCards // ignore: cast_nullable_to_non_nullable
as List<AstralCardPlacement>,activeTurn: null == activeTurn ? _self.activeTurn : activeTurn // ignore: cast_nullable_to_non_nullable
as AstralParticipantRole,oracleSynthesis: freezed == oracleSynthesis ? _self.oracleSynthesis : oracleSynthesis // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AstralCircleStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AstralCircleSession].
extension AstralCircleSessionPatterns on AstralCircleSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AstralCircleSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AstralCircleSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AstralCircleSession value)  $default,){
final _that = this;
switch (_that) {
case _AstralCircleSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AstralCircleSession value)?  $default,){
final _that = this;
switch (_that) {
case _AstralCircleSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomCode,  String hostId,  String hostName,  String? guestId,  String? guestName,  String spreadType,  List<AstralCardPlacement> drawnCards,  AstralParticipantRole activeTurn,  String? oracleSynthesis,  AstralCircleStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AstralCircleSession() when $default != null:
return $default(_that.id,_that.roomCode,_that.hostId,_that.hostName,_that.guestId,_that.guestName,_that.spreadType,_that.drawnCards,_that.activeTurn,_that.oracleSynthesis,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomCode,  String hostId,  String hostName,  String? guestId,  String? guestName,  String spreadType,  List<AstralCardPlacement> drawnCards,  AstralParticipantRole activeTurn,  String? oracleSynthesis,  AstralCircleStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AstralCircleSession():
return $default(_that.id,_that.roomCode,_that.hostId,_that.hostName,_that.guestId,_that.guestName,_that.spreadType,_that.drawnCards,_that.activeTurn,_that.oracleSynthesis,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomCode,  String hostId,  String hostName,  String? guestId,  String? guestName,  String spreadType,  List<AstralCardPlacement> drawnCards,  AstralParticipantRole activeTurn,  String? oracleSynthesis,  AstralCircleStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AstralCircleSession() when $default != null:
return $default(_that.id,_that.roomCode,_that.hostId,_that.hostName,_that.guestId,_that.guestName,_that.spreadType,_that.drawnCards,_that.activeTurn,_that.oracleSynthesis,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AstralCircleSession implements AstralCircleSession {
  const _AstralCircleSession({required this.id, required this.roomCode, required this.hostId, required this.hostName, this.guestId, this.guestName, this.spreadType = 'threeCard',  List<AstralCardPlacement> drawnCards = const [], this.activeTurn = AstralParticipantRole.host, this.oracleSynthesis, this.status = AstralCircleStatus.waiting, required this.createdAt}): _drawnCards = drawnCards;
  factory _AstralCircleSession.fromJson(Map<String, dynamic> json) => _$AstralCircleSessionFromJson(json);

@override final  String id;
@override final  String roomCode;
@override final  String hostId;
@override final  String hostName;
@override final  String? guestId;
@override final  String? guestName;
@override@JsonKey() final  String spreadType;
 final  List<AstralCardPlacement> _drawnCards;
@override@JsonKey() List<AstralCardPlacement> get drawnCards {
  if (_drawnCards is EqualUnmodifiableListView) return _drawnCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drawnCards);
}

@override@JsonKey() final  AstralParticipantRole activeTurn;
@override final  String? oracleSynthesis;
@override@JsonKey() final  AstralCircleStatus status;
@override final  DateTime createdAt;

/// Create a copy of AstralCircleSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstralCircleSessionCopyWith<_AstralCircleSession> get copyWith => __$AstralCircleSessionCopyWithImpl<_AstralCircleSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AstralCircleSessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstralCircleSession&&(identical(other.id, id) || other.id == id)&&(identical(other.roomCode, roomCode) || other.roomCode == roomCode)&&(identical(other.hostId, hostId) || other.hostId == hostId)&&(identical(other.hostName, hostName) || other.hostName == hostName)&&(identical(other.guestId, guestId) || other.guestId == guestId)&&(identical(other.guestName, guestName) || other.guestName == guestName)&&(identical(other.spreadType, spreadType) || other.spreadType == spreadType)&&const DeepCollectionEquality().equals(other.drawnCards, _drawnCards)&&(identical(other.activeTurn, activeTurn) || other.activeTurn == activeTurn)&&(identical(other.oracleSynthesis, oracleSynthesis) || other.oracleSynthesis == oracleSynthesis)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomCode,hostId,hostName,guestId,guestName,spreadType,const DeepCollectionEquality().hash(_drawnCards),activeTurn,oracleSynthesis,status,createdAt);
}

@override
String toString() {
    return 'AstralCircleSession(id: $id, roomCode: $roomCode, hostId: $hostId, hostName: $hostName, guestId: $guestId, guestName: $guestName, spreadType: $spreadType, drawnCards: $drawnCards, activeTurn: $activeTurn, oracleSynthesis: $oracleSynthesis, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AstralCircleSessionCopyWith<$Res> implements $AstralCircleSessionCopyWith<$Res> {
  factory _$AstralCircleSessionCopyWith(_AstralCircleSession value, $Res Function(_AstralCircleSession) _then) = __$AstralCircleSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomCode, String hostId, String hostName, String? guestId, String? guestName, String spreadType, List<AstralCardPlacement> drawnCards, AstralParticipantRole activeTurn, String? oracleSynthesis, AstralCircleStatus status, DateTime createdAt
});




}
/// @nodoc
class __$AstralCircleSessionCopyWithImpl<$Res>
    implements _$AstralCircleSessionCopyWith<$Res> {
  __$AstralCircleSessionCopyWithImpl(this._self, this._then);

  final _AstralCircleSession _self;
  final $Res Function(_AstralCircleSession) _then;

/// Create a copy of AstralCircleSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomCode = null,Object? hostId = null,Object? hostName = null,Object? guestId = freezed,Object? guestName = freezed,Object? spreadType = null,Object? drawnCards = null,Object? activeTurn = null,Object? oracleSynthesis = freezed,Object? status = null,Object? createdAt = null,}) {
  return _then(_AstralCircleSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomCode: null == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as String,hostId: null == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String,hostName: null == hostName ? _self.hostName : hostName // ignore: cast_nullable_to_non_nullable
as String,guestId: freezed == guestId ? _self.guestId : guestId // ignore: cast_nullable_to_non_nullable
as String?,guestName: freezed == guestName ? _self.guestName : guestName // ignore: cast_nullable_to_non_nullable
as String?,spreadType: null == spreadType ? _self.spreadType : spreadType // ignore: cast_nullable_to_non_nullable
as String,drawnCards: null == drawnCards ? _self._drawnCards : drawnCards // ignore: cast_nullable_to_non_nullable
as List<AstralCardPlacement>,activeTurn: null == activeTurn ? _self.activeTurn : activeTurn // ignore: cast_nullable_to_non_nullable
as AstralParticipantRole,oracleSynthesis: freezed == oracleSynthesis ? _self.oracleSynthesis : oracleSynthesis // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AstralCircleStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
