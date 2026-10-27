// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bazaar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BazaarState {

 int get shards; List<ActiveSanctuaryCandle> get activeCandles; Set<String> get unlockedFoils; String get equippedFoil; Set<String> get unlockedDecks; CelestialFlashDiscount? get activeFlashDiscount; List<SynastryDossier> get dossiers; bool get isLoading; bool get isProcessing; String? get message; String? get errorMessage;
/// Create a copy of BazaarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BazaarStateCopyWith<BazaarState> get copyWith => _$BazaarStateCopyWithImpl<BazaarState>(this as BazaarState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BazaarState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BazaarState&&(identical(other.shards, _this.shards) || other.shards == _this.shards)&&const DeepCollectionEquality().equals(other.activeCandles, _this.activeCandles)&&const DeepCollectionEquality().equals(other.unlockedFoils, _this.unlockedFoils)&&(identical(other.equippedFoil, _this.equippedFoil) || other.equippedFoil == _this.equippedFoil)&&const DeepCollectionEquality().equals(other.unlockedDecks, _this.unlockedDecks)&&(identical(other.activeFlashDiscount, _this.activeFlashDiscount) || other.activeFlashDiscount == _this.activeFlashDiscount)&&const DeepCollectionEquality().equals(other.dossiers, _this.dossiers)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.isProcessing, _this.isProcessing) || other.isProcessing == _this.isProcessing)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as BazaarState;
  return Object.hash(runtimeType,_this.shards,const DeepCollectionEquality().hash(_this.activeCandles),const DeepCollectionEquality().hash(_this.unlockedFoils),_this.equippedFoil,const DeepCollectionEquality().hash(_this.unlockedDecks),_this.activeFlashDiscount,const DeepCollectionEquality().hash(_this.dossiers),_this.isLoading,_this.isProcessing,_this.message,_this.errorMessage);
}

@override
String toString() {
  final _this = this as BazaarState;
  return 'BazaarState(shards: ${_this.shards}, activeCandles: ${_this.activeCandles}, unlockedFoils: ${_this.unlockedFoils}, equippedFoil: ${_this.equippedFoil}, unlockedDecks: ${_this.unlockedDecks}, activeFlashDiscount: ${_this.activeFlashDiscount}, dossiers: ${_this.dossiers}, isLoading: ${_this.isLoading}, isProcessing: ${_this.isProcessing}, message: ${_this.message}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $BazaarStateCopyWith<$Res>  {
  factory $BazaarStateCopyWith(BazaarState value, $Res Function(BazaarState) _then) = _$BazaarStateCopyWithImpl;
@useResult
$Res call({
 int shards, List<ActiveSanctuaryCandle> activeCandles, Set<String> unlockedFoils, String equippedFoil, Set<String> unlockedDecks, CelestialFlashDiscount? activeFlashDiscount, List<SynastryDossier> dossiers, bool isLoading, bool isProcessing, String? message, String? errorMessage
});


$CelestialFlashDiscountCopyWith<$Res>? get activeFlashDiscount;

}
/// @nodoc
class _$BazaarStateCopyWithImpl<$Res>
    implements $BazaarStateCopyWith<$Res> {
  _$BazaarStateCopyWithImpl(this._self, this._then);

  final BazaarState _self;
  final $Res Function(BazaarState) _then;

/// Create a copy of BazaarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shards = null,Object? activeCandles = null,Object? unlockedFoils = null,Object? equippedFoil = null,Object? unlockedDecks = null,Object? activeFlashDiscount = freezed,Object? dossiers = null,Object? isLoading = null,Object? isProcessing = null,Object? message = freezed,Object? errorMessage = freezed,}) {
  return _then(BazaarState(
shards: null == shards ? _self.shards : shards // ignore: cast_nullable_to_non_nullable
as int,activeCandles: null == activeCandles ? _self.activeCandles : activeCandles // ignore: cast_nullable_to_non_nullable
as List<ActiveSanctuaryCandle>,unlockedFoils: null == unlockedFoils ? _self.unlockedFoils : unlockedFoils // ignore: cast_nullable_to_non_nullable
as Set<String>,equippedFoil: null == equippedFoil ? _self.equippedFoil : equippedFoil // ignore: cast_nullable_to_non_nullable
as String,unlockedDecks: null == unlockedDecks ? _self.unlockedDecks : unlockedDecks // ignore: cast_nullable_to_non_nullable
as Set<String>,activeFlashDiscount: freezed == activeFlashDiscount ? _self.activeFlashDiscount : activeFlashDiscount // ignore: cast_nullable_to_non_nullable
as CelestialFlashDiscount?,dossiers: null == dossiers ? _self.dossiers : dossiers // ignore: cast_nullable_to_non_nullable
as List<SynastryDossier>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BazaarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CelestialFlashDiscountCopyWith<$Res>? get activeFlashDiscount {
    if (_self.activeFlashDiscount == null) {
    return null;
  }

  return $CelestialFlashDiscountCopyWith<$Res>(_self.activeFlashDiscount!, (value) {
    return _then(_self.copyWith(activeFlashDiscount: value));
  });
}
}


/// Adds pattern-matching-related methods to [BazaarState].
extension BazaarStatePatterns on BazaarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BazaarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BazaarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BazaarState value)  $default,){
final _that = this;
switch (_that) {
case _BazaarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BazaarState value)?  $default,){
final _that = this;
switch (_that) {
case _BazaarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int shards,  List<ActiveSanctuaryCandle> activeCandles,  Set<String> unlockedFoils,  String equippedFoil,  Set<String> unlockedDecks,  CelestialFlashDiscount? activeFlashDiscount,  List<SynastryDossier> dossiers,  bool isLoading,  bool isProcessing,  String? message,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BazaarState() when $default != null:
return $default(_that.shards,_that.activeCandles,_that.unlockedFoils,_that.equippedFoil,_that.unlockedDecks,_that.activeFlashDiscount,_that.dossiers,_that.isLoading,_that.isProcessing,_that.message,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int shards,  List<ActiveSanctuaryCandle> activeCandles,  Set<String> unlockedFoils,  String equippedFoil,  Set<String> unlockedDecks,  CelestialFlashDiscount? activeFlashDiscount,  List<SynastryDossier> dossiers,  bool isLoading,  bool isProcessing,  String? message,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BazaarState():
return $default(_that.shards,_that.activeCandles,_that.unlockedFoils,_that.equippedFoil,_that.unlockedDecks,_that.activeFlashDiscount,_that.dossiers,_that.isLoading,_that.isProcessing,_that.message,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int shards,  List<ActiveSanctuaryCandle> activeCandles,  Set<String> unlockedFoils,  String equippedFoil,  Set<String> unlockedDecks,  CelestialFlashDiscount? activeFlashDiscount,  List<SynastryDossier> dossiers,  bool isLoading,  bool isProcessing,  String? message,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BazaarState() when $default != null:
return $default(_that.shards,_that.activeCandles,_that.unlockedFoils,_that.equippedFoil,_that.unlockedDecks,_that.activeFlashDiscount,_that.dossiers,_that.isLoading,_that.isProcessing,_that.message,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BazaarState extends BazaarState {
  const _BazaarState({this.shards = 0,  List<ActiveSanctuaryCandle> activeCandles = const <ActiveSanctuaryCandle>[],  Set<String> unlockedFoils = const <String>{'foil_standard'}, this.equippedFoil = 'foil_standard',  Set<String> unlockedDecks = const <String>{}, this.activeFlashDiscount,  List<SynastryDossier> dossiers = const <SynastryDossier>[], this.isLoading = false, this.isProcessing = false, this.message, this.errorMessage}): _activeCandles = activeCandles,_unlockedFoils = unlockedFoils,_unlockedDecks = unlockedDecks,_dossiers = dossiers,super._();
  

@override@JsonKey() final  int shards;
 final  List<ActiveSanctuaryCandle> _activeCandles;
@override@JsonKey() List<ActiveSanctuaryCandle> get activeCandles {
  if (_activeCandles is EqualUnmodifiableListView) return _activeCandles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeCandles);
}

 final  Set<String> _unlockedFoils;
@override@JsonKey() Set<String> get unlockedFoils {
  if (_unlockedFoils is EqualUnmodifiableSetView) return _unlockedFoils;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_unlockedFoils);
}

@override@JsonKey() final  String equippedFoil;
 final  Set<String> _unlockedDecks;
@override@JsonKey() Set<String> get unlockedDecks {
  if (_unlockedDecks is EqualUnmodifiableSetView) return _unlockedDecks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_unlockedDecks);
}

@override final  CelestialFlashDiscount? activeFlashDiscount;
 final  List<SynastryDossier> _dossiers;
@override@JsonKey() List<SynastryDossier> get dossiers {
  if (_dossiers is EqualUnmodifiableListView) return _dossiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dossiers);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isProcessing;
@override final  String? message;
@override final  String? errorMessage;

/// Create a copy of BazaarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BazaarStateCopyWith<_BazaarState> get copyWith => __$BazaarStateCopyWithImpl<_BazaarState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BazaarState&&(identical(other.shards, shards) || other.shards == shards)&&const DeepCollectionEquality().equals(other.activeCandles, _activeCandles)&&const DeepCollectionEquality().equals(other.unlockedFoils, _unlockedFoils)&&(identical(other.equippedFoil, equippedFoil) || other.equippedFoil == equippedFoil)&&const DeepCollectionEquality().equals(other.unlockedDecks, _unlockedDecks)&&(identical(other.activeFlashDiscount, activeFlashDiscount) || other.activeFlashDiscount == activeFlashDiscount)&&const DeepCollectionEquality().equals(other.dossiers, _dossiers)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,shards,const DeepCollectionEquality().hash(_activeCandles),const DeepCollectionEquality().hash(_unlockedFoils),equippedFoil,const DeepCollectionEquality().hash(_unlockedDecks),activeFlashDiscount,const DeepCollectionEquality().hash(_dossiers),isLoading,isProcessing,message,errorMessage);
}

@override
String toString() {
    return 'BazaarState(shards: $shards, activeCandles: $activeCandles, unlockedFoils: $unlockedFoils, equippedFoil: $equippedFoil, unlockedDecks: $unlockedDecks, activeFlashDiscount: $activeFlashDiscount, dossiers: $dossiers, isLoading: $isLoading, isProcessing: $isProcessing, message: $message, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BazaarStateCopyWith<$Res> implements $BazaarStateCopyWith<$Res> {
  factory _$BazaarStateCopyWith(_BazaarState value, $Res Function(_BazaarState) _then) = __$BazaarStateCopyWithImpl;
@override @useResult
$Res call({
 int shards, List<ActiveSanctuaryCandle> activeCandles, Set<String> unlockedFoils, String equippedFoil, Set<String> unlockedDecks, CelestialFlashDiscount? activeFlashDiscount, List<SynastryDossier> dossiers, bool isLoading, bool isProcessing, String? message, String? errorMessage
});


@override $CelestialFlashDiscountCopyWith<$Res>? get activeFlashDiscount;

}
/// @nodoc
class __$BazaarStateCopyWithImpl<$Res>
    implements _$BazaarStateCopyWith<$Res> {
  __$BazaarStateCopyWithImpl(this._self, this._then);

  final _BazaarState _self;
  final $Res Function(_BazaarState) _then;

/// Create a copy of BazaarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shards = null,Object? activeCandles = null,Object? unlockedFoils = null,Object? equippedFoil = null,Object? unlockedDecks = null,Object? activeFlashDiscount = freezed,Object? dossiers = null,Object? isLoading = null,Object? isProcessing = null,Object? message = freezed,Object? errorMessage = freezed,}) {
  return _then(_BazaarState(
shards: null == shards ? _self.shards : shards // ignore: cast_nullable_to_non_nullable
as int,activeCandles: null == activeCandles ? _self._activeCandles : activeCandles // ignore: cast_nullable_to_non_nullable
as List<ActiveSanctuaryCandle>,unlockedFoils: null == unlockedFoils ? _self._unlockedFoils : unlockedFoils // ignore: cast_nullable_to_non_nullable
as Set<String>,equippedFoil: null == equippedFoil ? _self.equippedFoil : equippedFoil // ignore: cast_nullable_to_non_nullable
as String,unlockedDecks: null == unlockedDecks ? _self._unlockedDecks : unlockedDecks // ignore: cast_nullable_to_non_nullable
as Set<String>,activeFlashDiscount: freezed == activeFlashDiscount ? _self.activeFlashDiscount : activeFlashDiscount // ignore: cast_nullable_to_non_nullable
as CelestialFlashDiscount?,dossiers: null == dossiers ? _self._dossiers : dossiers // ignore: cast_nullable_to_non_nullable
as List<SynastryDossier>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BazaarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CelestialFlashDiscountCopyWith<$Res>? get activeFlashDiscount {
    if (_self.activeFlashDiscount == null) {
    return null;
  }

  return $CelestialFlashDiscountCopyWith<$Res>(_self.activeFlashDiscount!, (value) {
    return _then(_self.copyWith(activeFlashDiscount: value));
  });
}
}

// dart format on
