// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReadingState {

 SpreadType get spreadType; String get question; List<TarotCard> get drawnCards; Set<int> get revealedIndices; bool get isShuffling; bool get isDealing; bool get isConsultingOracle; bool get isAskingFollowUp; Reading? get currentReading; List<Reading> get history; List<OracleMessage> get conversationHistory; TarotDeckTheme get deckTheme; AltarTheme get altarTheme; int? get selectedInspectIndex; String? get errorMessage;
/// Create a copy of ReadingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingStateCopyWith<ReadingState> get copyWith => _$ReadingStateCopyWithImpl<ReadingState>(this as ReadingState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReadingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingState&&(identical(other.spreadType, _this.spreadType) || other.spreadType == _this.spreadType)&&(identical(other.question, _this.question) || other.question == _this.question)&&const DeepCollectionEquality().equals(other.drawnCards, _this.drawnCards)&&const DeepCollectionEquality().equals(other.revealedIndices, _this.revealedIndices)&&(identical(other.isShuffling, _this.isShuffling) || other.isShuffling == _this.isShuffling)&&(identical(other.isDealing, _this.isDealing) || other.isDealing == _this.isDealing)&&(identical(other.isConsultingOracle, _this.isConsultingOracle) || other.isConsultingOracle == _this.isConsultingOracle)&&(identical(other.isAskingFollowUp, _this.isAskingFollowUp) || other.isAskingFollowUp == _this.isAskingFollowUp)&&(identical(other.currentReading, _this.currentReading) || other.currentReading == _this.currentReading)&&const DeepCollectionEquality().equals(other.history, _this.history)&&const DeepCollectionEquality().equals(other.conversationHistory, _this.conversationHistory)&&(identical(other.deckTheme, _this.deckTheme) || other.deckTheme == _this.deckTheme)&&(identical(other.altarTheme, _this.altarTheme) || other.altarTheme == _this.altarTheme)&&(identical(other.selectedInspectIndex, _this.selectedInspectIndex) || other.selectedInspectIndex == _this.selectedInspectIndex)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as ReadingState;
  return Object.hash(runtimeType,_this.spreadType,_this.question,const DeepCollectionEquality().hash(_this.drawnCards),const DeepCollectionEquality().hash(_this.revealedIndices),_this.isShuffling,_this.isDealing,_this.isConsultingOracle,_this.isAskingFollowUp,_this.currentReading,const DeepCollectionEquality().hash(_this.history),const DeepCollectionEquality().hash(_this.conversationHistory),_this.deckTheme,_this.altarTheme,_this.selectedInspectIndex,_this.errorMessage);
}

@override
String toString() {
  final _this = this as ReadingState;
  return 'ReadingState(spreadType: ${_this.spreadType}, question: ${_this.question}, drawnCards: ${_this.drawnCards}, revealedIndices: ${_this.revealedIndices}, isShuffling: ${_this.isShuffling}, isDealing: ${_this.isDealing}, isConsultingOracle: ${_this.isConsultingOracle}, isAskingFollowUp: ${_this.isAskingFollowUp}, currentReading: ${_this.currentReading}, history: ${_this.history}, conversationHistory: ${_this.conversationHistory}, deckTheme: ${_this.deckTheme}, altarTheme: ${_this.altarTheme}, selectedInspectIndex: ${_this.selectedInspectIndex}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $ReadingStateCopyWith<$Res>  {
  factory $ReadingStateCopyWith(ReadingState value, $Res Function(ReadingState) _then) = _$ReadingStateCopyWithImpl;
@useResult
$Res call({
 SpreadType spreadType, String question, List<TarotCard> drawnCards, Set<int> revealedIndices, bool isShuffling, bool isDealing, bool isConsultingOracle, bool isAskingFollowUp, Reading? currentReading, List<Reading> history, List<OracleMessage> conversationHistory, TarotDeckTheme deckTheme, AltarTheme altarTheme, int? selectedInspectIndex, String? errorMessage
});


$ReadingCopyWith<$Res>? get currentReading;

}
/// @nodoc
class _$ReadingStateCopyWithImpl<$Res>
    implements $ReadingStateCopyWith<$Res> {
  _$ReadingStateCopyWithImpl(this._self, this._then);

  final ReadingState _self;
  final $Res Function(ReadingState) _then;

/// Create a copy of ReadingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spreadType = null,Object? question = null,Object? drawnCards = null,Object? revealedIndices = null,Object? isShuffling = null,Object? isDealing = null,Object? isConsultingOracle = null,Object? isAskingFollowUp = null,Object? currentReading = freezed,Object? history = null,Object? conversationHistory = null,Object? deckTheme = null,Object? altarTheme = null,Object? selectedInspectIndex = freezed,Object? errorMessage = freezed,}) {
  return _then(ReadingState(
spreadType: null == spreadType ? _self.spreadType : spreadType // ignore: cast_nullable_to_non_nullable
as SpreadType,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,drawnCards: null == drawnCards ? _self.drawnCards : drawnCards // ignore: cast_nullable_to_non_nullable
as List<TarotCard>,revealedIndices: null == revealedIndices ? _self.revealedIndices : revealedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,isShuffling: null == isShuffling ? _self.isShuffling : isShuffling // ignore: cast_nullable_to_non_nullable
as bool,isDealing: null == isDealing ? _self.isDealing : isDealing // ignore: cast_nullable_to_non_nullable
as bool,isConsultingOracle: null == isConsultingOracle ? _self.isConsultingOracle : isConsultingOracle // ignore: cast_nullable_to_non_nullable
as bool,isAskingFollowUp: null == isAskingFollowUp ? _self.isAskingFollowUp : isAskingFollowUp // ignore: cast_nullable_to_non_nullable
as bool,currentReading: freezed == currentReading ? _self.currentReading : currentReading // ignore: cast_nullable_to_non_nullable
as Reading?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<Reading>,conversationHistory: null == conversationHistory ? _self.conversationHistory : conversationHistory // ignore: cast_nullable_to_non_nullable
as List<OracleMessage>,deckTheme: null == deckTheme ? _self.deckTheme : deckTheme // ignore: cast_nullable_to_non_nullable
as TarotDeckTheme,altarTheme: null == altarTheme ? _self.altarTheme : altarTheme // ignore: cast_nullable_to_non_nullable
as AltarTheme,selectedInspectIndex: freezed == selectedInspectIndex ? _self.selectedInspectIndex : selectedInspectIndex // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReadingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadingCopyWith<$Res>? get currentReading {
    if (_self.currentReading == null) {
    return null;
  }

  return $ReadingCopyWith<$Res>(_self.currentReading!, (value) {
    return _then(_self.copyWith(currentReading: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReadingState].
extension ReadingStatePatterns on ReadingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingState value)  $default,){
final _that = this;
switch (_that) {
case _ReadingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingState value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SpreadType spreadType,  String question,  List<TarotCard> drawnCards,  Set<int> revealedIndices,  bool isShuffling,  bool isDealing,  bool isConsultingOracle,  bool isAskingFollowUp,  Reading? currentReading,  List<Reading> history,  List<OracleMessage> conversationHistory,  TarotDeckTheme deckTheme,  AltarTheme altarTheme,  int? selectedInspectIndex,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingState() when $default != null:
return $default(_that.spreadType,_that.question,_that.drawnCards,_that.revealedIndices,_that.isShuffling,_that.isDealing,_that.isConsultingOracle,_that.isAskingFollowUp,_that.currentReading,_that.history,_that.conversationHistory,_that.deckTheme,_that.altarTheme,_that.selectedInspectIndex,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SpreadType spreadType,  String question,  List<TarotCard> drawnCards,  Set<int> revealedIndices,  bool isShuffling,  bool isDealing,  bool isConsultingOracle,  bool isAskingFollowUp,  Reading? currentReading,  List<Reading> history,  List<OracleMessage> conversationHistory,  TarotDeckTheme deckTheme,  AltarTheme altarTheme,  int? selectedInspectIndex,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ReadingState():
return $default(_that.spreadType,_that.question,_that.drawnCards,_that.revealedIndices,_that.isShuffling,_that.isDealing,_that.isConsultingOracle,_that.isAskingFollowUp,_that.currentReading,_that.history,_that.conversationHistory,_that.deckTheme,_that.altarTheme,_that.selectedInspectIndex,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SpreadType spreadType,  String question,  List<TarotCard> drawnCards,  Set<int> revealedIndices,  bool isShuffling,  bool isDealing,  bool isConsultingOracle,  bool isAskingFollowUp,  Reading? currentReading,  List<Reading> history,  List<OracleMessage> conversationHistory,  TarotDeckTheme deckTheme,  AltarTheme altarTheme,  int? selectedInspectIndex,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReadingState() when $default != null:
return $default(_that.spreadType,_that.question,_that.drawnCards,_that.revealedIndices,_that.isShuffling,_that.isDealing,_that.isConsultingOracle,_that.isAskingFollowUp,_that.currentReading,_that.history,_that.conversationHistory,_that.deckTheme,_that.altarTheme,_that.selectedInspectIndex,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ReadingState extends ReadingState {
  const _ReadingState({this.spreadType = SpreadType.dailyGuidance, this.question = '',  List<TarotCard> drawnCards = const [],  Set<int> revealedIndices = const {}, this.isShuffling = false, this.isDealing = false, this.isConsultingOracle = false, this.isAskingFollowUp = false, this.currentReading,  List<Reading> history = const [],  List<OracleMessage> conversationHistory = const [], this.deckTheme = TarotDeckTheme.classic, this.altarTheme = AltarTheme.midnightNebula, this.selectedInspectIndex, this.errorMessage}): _drawnCards = drawnCards,_revealedIndices = revealedIndices,_history = history,_conversationHistory = conversationHistory,super._();
  

@override@JsonKey() final  SpreadType spreadType;
@override@JsonKey() final  String question;
 final  List<TarotCard> _drawnCards;
@override@JsonKey() List<TarotCard> get drawnCards {
  if (_drawnCards is EqualUnmodifiableListView) return _drawnCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drawnCards);
}

 final  Set<int> _revealedIndices;
@override@JsonKey() Set<int> get revealedIndices {
  if (_revealedIndices is EqualUnmodifiableSetView) return _revealedIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_revealedIndices);
}

@override@JsonKey() final  bool isShuffling;
@override@JsonKey() final  bool isDealing;
@override@JsonKey() final  bool isConsultingOracle;
@override@JsonKey() final  bool isAskingFollowUp;
@override final  Reading? currentReading;
 final  List<Reading> _history;
@override@JsonKey() List<Reading> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

 final  List<OracleMessage> _conversationHistory;
@override@JsonKey() List<OracleMessage> get conversationHistory {
  if (_conversationHistory is EqualUnmodifiableListView) return _conversationHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversationHistory);
}

@override@JsonKey() final  TarotDeckTheme deckTheme;
@override@JsonKey() final  AltarTheme altarTheme;
@override final  int? selectedInspectIndex;
@override final  String? errorMessage;

/// Create a copy of ReadingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingStateCopyWith<_ReadingState> get copyWith => __$ReadingStateCopyWithImpl<_ReadingState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingState&&(identical(other.spreadType, spreadType) || other.spreadType == spreadType)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.drawnCards, _drawnCards)&&const DeepCollectionEquality().equals(other.revealedIndices, _revealedIndices)&&(identical(other.isShuffling, isShuffling) || other.isShuffling == isShuffling)&&(identical(other.isDealing, isDealing) || other.isDealing == isDealing)&&(identical(other.isConsultingOracle, isConsultingOracle) || other.isConsultingOracle == isConsultingOracle)&&(identical(other.isAskingFollowUp, isAskingFollowUp) || other.isAskingFollowUp == isAskingFollowUp)&&(identical(other.currentReading, currentReading) || other.currentReading == currentReading)&&const DeepCollectionEquality().equals(other.history, _history)&&const DeepCollectionEquality().equals(other.conversationHistory, _conversationHistory)&&(identical(other.deckTheme, deckTheme) || other.deckTheme == deckTheme)&&(identical(other.altarTheme, altarTheme) || other.altarTheme == altarTheme)&&(identical(other.selectedInspectIndex, selectedInspectIndex) || other.selectedInspectIndex == selectedInspectIndex)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,spreadType,question,const DeepCollectionEquality().hash(_drawnCards),const DeepCollectionEquality().hash(_revealedIndices),isShuffling,isDealing,isConsultingOracle,isAskingFollowUp,currentReading,const DeepCollectionEquality().hash(_history),const DeepCollectionEquality().hash(_conversationHistory),deckTheme,altarTheme,selectedInspectIndex,errorMessage);
}

@override
String toString() {
    return 'ReadingState(spreadType: $spreadType, question: $question, drawnCards: $drawnCards, revealedIndices: $revealedIndices, isShuffling: $isShuffling, isDealing: $isDealing, isConsultingOracle: $isConsultingOracle, isAskingFollowUp: $isAskingFollowUp, currentReading: $currentReading, history: $history, conversationHistory: $conversationHistory, deckTheme: $deckTheme, altarTheme: $altarTheme, selectedInspectIndex: $selectedInspectIndex, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReadingStateCopyWith<$Res> implements $ReadingStateCopyWith<$Res> {
  factory _$ReadingStateCopyWith(_ReadingState value, $Res Function(_ReadingState) _then) = __$ReadingStateCopyWithImpl;
@override @useResult
$Res call({
 SpreadType spreadType, String question, List<TarotCard> drawnCards, Set<int> revealedIndices, bool isShuffling, bool isDealing, bool isConsultingOracle, bool isAskingFollowUp, Reading? currentReading, List<Reading> history, List<OracleMessage> conversationHistory, TarotDeckTheme deckTheme, AltarTheme altarTheme, int? selectedInspectIndex, String? errorMessage
});


@override $ReadingCopyWith<$Res>? get currentReading;

}
/// @nodoc
class __$ReadingStateCopyWithImpl<$Res>
    implements _$ReadingStateCopyWith<$Res> {
  __$ReadingStateCopyWithImpl(this._self, this._then);

  final _ReadingState _self;
  final $Res Function(_ReadingState) _then;

/// Create a copy of ReadingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spreadType = null,Object? question = null,Object? drawnCards = null,Object? revealedIndices = null,Object? isShuffling = null,Object? isDealing = null,Object? isConsultingOracle = null,Object? isAskingFollowUp = null,Object? currentReading = freezed,Object? history = null,Object? conversationHistory = null,Object? deckTheme = null,Object? altarTheme = null,Object? selectedInspectIndex = freezed,Object? errorMessage = freezed,}) {
  return _then(_ReadingState(
spreadType: null == spreadType ? _self.spreadType : spreadType // ignore: cast_nullable_to_non_nullable
as SpreadType,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,drawnCards: null == drawnCards ? _self._drawnCards : drawnCards // ignore: cast_nullable_to_non_nullable
as List<TarotCard>,revealedIndices: null == revealedIndices ? _self._revealedIndices : revealedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,isShuffling: null == isShuffling ? _self.isShuffling : isShuffling // ignore: cast_nullable_to_non_nullable
as bool,isDealing: null == isDealing ? _self.isDealing : isDealing // ignore: cast_nullable_to_non_nullable
as bool,isConsultingOracle: null == isConsultingOracle ? _self.isConsultingOracle : isConsultingOracle // ignore: cast_nullable_to_non_nullable
as bool,isAskingFollowUp: null == isAskingFollowUp ? _self.isAskingFollowUp : isAskingFollowUp // ignore: cast_nullable_to_non_nullable
as bool,currentReading: freezed == currentReading ? _self.currentReading : currentReading // ignore: cast_nullable_to_non_nullable
as Reading?,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<Reading>,conversationHistory: null == conversationHistory ? _self._conversationHistory : conversationHistory // ignore: cast_nullable_to_non_nullable
as List<OracleMessage>,deckTheme: null == deckTheme ? _self.deckTheme : deckTheme // ignore: cast_nullable_to_non_nullable
as TarotDeckTheme,altarTheme: null == altarTheme ? _self.altarTheme : altarTheme // ignore: cast_nullable_to_non_nullable
as AltarTheme,selectedInspectIndex: freezed == selectedInspectIndex ? _self.selectedInspectIndex : selectedInspectIndex // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReadingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadingCopyWith<$Res>? get currentReading {
    if (_self.currentReading == null) {
    return null;
  }

  return $ReadingCopyWith<$Res>(_self.currentReading!, (value) {
    return _then(_self.copyWith(currentReading: value));
  });
}
}

// dart format on
