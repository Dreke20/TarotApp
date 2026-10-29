// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionState {

 bool get isAvailable; bool get isLoading; SubscriptionPlan get selectedPlan; bool get isSubmitting; Map<String, String> get localizedPrices; Map<String, String> get trialPhrases; Map<String, String> get offerTokens; Map<String, int> get recurringMicros; Map<String, String> get currencyCodes; String? get errorMessage; String? get successMessage;
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateCopyWith<SubscriptionState> get copyWith => _$SubscriptionStateCopyWithImpl<SubscriptionState>(this as SubscriptionState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SubscriptionState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionState&&(identical(other.isAvailable, _this.isAvailable) || other.isAvailable == _this.isAvailable)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.selectedPlan, _this.selectedPlan) || other.selectedPlan == _this.selectedPlan)&&(identical(other.isSubmitting, _this.isSubmitting) || other.isSubmitting == _this.isSubmitting)&&const DeepCollectionEquality().equals(other.localizedPrices, _this.localizedPrices)&&const DeepCollectionEquality().equals(other.trialPhrases, _this.trialPhrases)&&const DeepCollectionEquality().equals(other.offerTokens, _this.offerTokens)&&const DeepCollectionEquality().equals(other.recurringMicros, _this.recurringMicros)&&const DeepCollectionEquality().equals(other.currencyCodes, _this.currencyCodes)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.successMessage, _this.successMessage) || other.successMessage == _this.successMessage));
}


@override
int get hashCode {
  final _this = this as SubscriptionState;
  return Object.hash(runtimeType,_this.isAvailable,_this.isLoading,_this.selectedPlan,_this.isSubmitting,const DeepCollectionEquality().hash(_this.localizedPrices),const DeepCollectionEquality().hash(_this.trialPhrases),const DeepCollectionEquality().hash(_this.offerTokens),const DeepCollectionEquality().hash(_this.recurringMicros),const DeepCollectionEquality().hash(_this.currencyCodes),_this.errorMessage,_this.successMessage);
}

@override
String toString() {
  final _this = this as SubscriptionState;
  return 'SubscriptionState(isAvailable: ${_this.isAvailable}, isLoading: ${_this.isLoading}, selectedPlan: ${_this.selectedPlan}, isSubmitting: ${_this.isSubmitting}, localizedPrices: ${_this.localizedPrices}, trialPhrases: ${_this.trialPhrases}, offerTokens: ${_this.offerTokens}, recurringMicros: ${_this.recurringMicros}, currencyCodes: ${_this.currencyCodes}, errorMessage: ${_this.errorMessage}, successMessage: ${_this.successMessage})';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateCopyWith<$Res>  {
  factory $SubscriptionStateCopyWith(SubscriptionState value, $Res Function(SubscriptionState) _then) = _$SubscriptionStateCopyWithImpl;
@useResult
$Res call({
 bool isAvailable, bool isLoading, SubscriptionPlan selectedPlan, bool isSubmitting, Map<String, String> localizedPrices, Map<String, String> trialPhrases, Map<String, String> offerTokens, Map<String, int> recurringMicros, Map<String, String> currencyCodes, String? errorMessage, String? successMessage
});




}
/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._self, this._then);

  final SubscriptionState _self;
  final $Res Function(SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAvailable = null,Object? isLoading = null,Object? selectedPlan = null,Object? isSubmitting = null,Object? localizedPrices = null,Object? trialPhrases = null,Object? offerTokens = null,Object? recurringMicros = null,Object? currencyCodes = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(SubscriptionState(
isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedPlan: null == selectedPlan ? _self.selectedPlan : selectedPlan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,localizedPrices: null == localizedPrices ? _self.localizedPrices : localizedPrices // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trialPhrases: null == trialPhrases ? _self.trialPhrases : trialPhrases // ignore: cast_nullable_to_non_nullable
as Map<String, String>,offerTokens: null == offerTokens ? _self.offerTokens : offerTokens // ignore: cast_nullable_to_non_nullable
as Map<String, String>,recurringMicros: null == recurringMicros ? _self.recurringMicros : recurringMicros // ignore: cast_nullable_to_non_nullable
as Map<String, int>,currencyCodes: null == currencyCodes ? _self.currencyCodes : currencyCodes // ignore: cast_nullable_to_non_nullable
as Map<String, String>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionState].
extension SubscriptionStatePatterns on SubscriptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionState value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionState value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAvailable,  bool isLoading,  SubscriptionPlan selectedPlan,  bool isSubmitting,  Map<String, String> localizedPrices,  Map<String, String> trialPhrases,  Map<String, String> offerTokens,  Map<String, int> recurringMicros,  Map<String, String> currencyCodes,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.isAvailable,_that.isLoading,_that.selectedPlan,_that.isSubmitting,_that.localizedPrices,_that.trialPhrases,_that.offerTokens,_that.recurringMicros,_that.currencyCodes,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAvailable,  bool isLoading,  SubscriptionPlan selectedPlan,  bool isSubmitting,  Map<String, String> localizedPrices,  Map<String, String> trialPhrases,  Map<String, String> offerTokens,  Map<String, int> recurringMicros,  Map<String, String> currencyCodes,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState():
return $default(_that.isAvailable,_that.isLoading,_that.selectedPlan,_that.isSubmitting,_that.localizedPrices,_that.trialPhrases,_that.offerTokens,_that.recurringMicros,_that.currencyCodes,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAvailable,  bool isLoading,  SubscriptionPlan selectedPlan,  bool isSubmitting,  Map<String, String> localizedPrices,  Map<String, String> trialPhrases,  Map<String, String> offerTokens,  Map<String, int> recurringMicros,  Map<String, String> currencyCodes,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.isAvailable,_that.isLoading,_that.selectedPlan,_that.isSubmitting,_that.localizedPrices,_that.trialPhrases,_that.offerTokens,_that.recurringMicros,_that.currencyCodes,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionState extends SubscriptionState {
  const _SubscriptionState({this.isAvailable = false, this.isLoading = false, this.selectedPlan = SubscriptionPlan.yearly, this.isSubmitting = false,  Map<String, String> localizedPrices = const <String, String>{},  Map<String, String> trialPhrases = const <String, String>{},  Map<String, String> offerTokens = const <String, String>{},  Map<String, int> recurringMicros = const <String, int>{},  Map<String, String> currencyCodes = const <String, String>{}, this.errorMessage, this.successMessage}): _localizedPrices = localizedPrices,_trialPhrases = trialPhrases,_offerTokens = offerTokens,_recurringMicros = recurringMicros,_currencyCodes = currencyCodes,super._();
  

@override@JsonKey() final  bool isAvailable;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SubscriptionPlan selectedPlan;
@override@JsonKey() final  bool isSubmitting;
 final  Map<String, String> _localizedPrices;
@override@JsonKey() Map<String, String> get localizedPrices {
  if (_localizedPrices is EqualUnmodifiableMapView) return _localizedPrices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_localizedPrices);
}

 final  Map<String, String> _trialPhrases;
@override@JsonKey() Map<String, String> get trialPhrases {
  if (_trialPhrases is EqualUnmodifiableMapView) return _trialPhrases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_trialPhrases);
}

 final  Map<String, String> _offerTokens;
@override@JsonKey() Map<String, String> get offerTokens {
  if (_offerTokens is EqualUnmodifiableMapView) return _offerTokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_offerTokens);
}

 final  Map<String, int> _recurringMicros;
@override@JsonKey() Map<String, int> get recurringMicros {
  if (_recurringMicros is EqualUnmodifiableMapView) return _recurringMicros;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_recurringMicros);
}

 final  Map<String, String> _currencyCodes;
@override@JsonKey() Map<String, String> get currencyCodes {
  if (_currencyCodes is EqualUnmodifiableMapView) return _currencyCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_currencyCodes);
}

@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStateCopyWith<_SubscriptionState> get copyWith => __$SubscriptionStateCopyWithImpl<_SubscriptionState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionState&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedPlan, selectedPlan) || other.selectedPlan == selectedPlan)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&const DeepCollectionEquality().equals(other.localizedPrices, _localizedPrices)&&const DeepCollectionEquality().equals(other.trialPhrases, _trialPhrases)&&const DeepCollectionEquality().equals(other.offerTokens, _offerTokens)&&const DeepCollectionEquality().equals(other.recurringMicros, _recurringMicros)&&const DeepCollectionEquality().equals(other.currencyCodes, _currencyCodes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isAvailable,isLoading,selectedPlan,isSubmitting,const DeepCollectionEquality().hash(_localizedPrices),const DeepCollectionEquality().hash(_trialPhrases),const DeepCollectionEquality().hash(_offerTokens),const DeepCollectionEquality().hash(_recurringMicros),const DeepCollectionEquality().hash(_currencyCodes),errorMessage,successMessage);
}

@override
String toString() {
    return 'SubscriptionState(isAvailable: $isAvailable, isLoading: $isLoading, selectedPlan: $selectedPlan, isSubmitting: $isSubmitting, localizedPrices: $localizedPrices, trialPhrases: $trialPhrases, offerTokens: $offerTokens, recurringMicros: $recurringMicros, currencyCodes: $currencyCodes, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStateCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory _$SubscriptionStateCopyWith(_SubscriptionState value, $Res Function(_SubscriptionState) _then) = __$SubscriptionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isAvailable, bool isLoading, SubscriptionPlan selectedPlan, bool isSubmitting, Map<String, String> localizedPrices, Map<String, String> trialPhrases, Map<String, String> offerTokens, Map<String, int> recurringMicros, Map<String, String> currencyCodes, String? errorMessage, String? successMessage
});




}
/// @nodoc
class __$SubscriptionStateCopyWithImpl<$Res>
    implements _$SubscriptionStateCopyWith<$Res> {
  __$SubscriptionStateCopyWithImpl(this._self, this._then);

  final _SubscriptionState _self;
  final $Res Function(_SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAvailable = null,Object? isLoading = null,Object? selectedPlan = null,Object? isSubmitting = null,Object? localizedPrices = null,Object? trialPhrases = null,Object? offerTokens = null,Object? recurringMicros = null,Object? currencyCodes = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_SubscriptionState(
isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedPlan: null == selectedPlan ? _self.selectedPlan : selectedPlan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,localizedPrices: null == localizedPrices ? _self._localizedPrices : localizedPrices // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trialPhrases: null == trialPhrases ? _self._trialPhrases : trialPhrases // ignore: cast_nullable_to_non_nullable
as Map<String, String>,offerTokens: null == offerTokens ? _self._offerTokens : offerTokens // ignore: cast_nullable_to_non_nullable
as Map<String, String>,recurringMicros: null == recurringMicros ? _self._recurringMicros : recurringMicros // ignore: cast_nullable_to_non_nullable
as Map<String, int>,currencyCodes: null == currencyCodes ? _self._currencyCodes : currencyCodes // ignore: cast_nullable_to_non_nullable
as Map<String, String>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
