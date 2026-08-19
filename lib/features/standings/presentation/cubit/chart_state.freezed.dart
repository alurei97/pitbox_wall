// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChartState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChartState()';
}


}

/// @nodoc
class $ChartStateCopyWith<$Res>  {
$ChartStateCopyWith(ChartState _, $Res Function(ChartState) __);
}


/// Adds pattern-matching-related methods to [ChartState].
extension ChartStatePatterns on ChartState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChartInitial value)?  initial,TResult Function( ChartDownloading value)?  downloading,TResult Function( ChartReady value)?  ready,TResult Function( ChartSelecting value)?  selecting,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChartInitial() when initial != null:
return initial(_that);case ChartDownloading() when downloading != null:
return downloading(_that);case ChartReady() when ready != null:
return ready(_that);case ChartSelecting() when selecting != null:
return selecting(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChartInitial value)  initial,required TResult Function( ChartDownloading value)  downloading,required TResult Function( ChartReady value)  ready,required TResult Function( ChartSelecting value)  selecting,}){
final _that = this;
switch (_that) {
case ChartInitial():
return initial(_that);case ChartDownloading():
return downloading(_that);case ChartReady():
return ready(_that);case ChartSelecting():
return selecting(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChartInitial value)?  initial,TResult? Function( ChartDownloading value)?  downloading,TResult? Function( ChartReady value)?  ready,TResult? Function( ChartSelecting value)?  selecting,}){
final _that = this;
switch (_that) {
case ChartInitial() when initial != null:
return initial(_that);case ChartDownloading() when downloading != null:
return downloading(_that);case ChartReady() when ready != null:
return ready(_that);case ChartSelecting() when selecting != null:
return selecting(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds)?  downloading,TResult Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds,  Set<String> selectedEntryIds)?  ready,TResult Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds,  Set<String> selectedEntryIds)?  selecting,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChartInitial() when initial != null:
return initial();case ChartDownloading() when downloading != null:
return downloading(_that.roundStandings,_that.downloadedRounds);case ChartReady() when ready != null:
return ready(_that.roundStandings,_that.downloadedRounds,_that.selectedEntryIds);case ChartSelecting() when selecting != null:
return selecting(_that.roundStandings,_that.downloadedRounds,_that.selectedEntryIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds)  downloading,required TResult Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds,  Set<String> selectedEntryIds)  ready,required TResult Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds,  Set<String> selectedEntryIds)  selecting,}) {final _that = this;
switch (_that) {
case ChartInitial():
return initial();case ChartDownloading():
return downloading(_that.roundStandings,_that.downloadedRounds);case ChartReady():
return ready(_that.roundStandings,_that.downloadedRounds,_that.selectedEntryIds);case ChartSelecting():
return selecting(_that.roundStandings,_that.downloadedRounds,_that.selectedEntryIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds)?  downloading,TResult? Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds,  Set<String> selectedEntryIds)?  ready,TResult? Function( List<DriverRoundStanding> roundStandings,  int downloadedRounds,  Set<String> selectedEntryIds)?  selecting,}) {final _that = this;
switch (_that) {
case ChartInitial() when initial != null:
return initial();case ChartDownloading() when downloading != null:
return downloading(_that.roundStandings,_that.downloadedRounds);case ChartReady() when ready != null:
return ready(_that.roundStandings,_that.downloadedRounds,_that.selectedEntryIds);case ChartSelecting() when selecting != null:
return selecting(_that.roundStandings,_that.downloadedRounds,_that.selectedEntryIds);case _:
  return null;

}
}

}

/// @nodoc


class ChartInitial implements ChartState {
  const ChartInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChartState.initial()';
}


}




/// @nodoc


class ChartDownloading implements ChartState {
  const ChartDownloading({ List<DriverRoundStanding> roundStandings = const <DriverRoundStanding>[], this.downloadedRounds = 0}): _roundStandings = roundStandings;
  

 final  List<DriverRoundStanding> _roundStandings;
@JsonKey() List<DriverRoundStanding> get roundStandings {
  if (_roundStandings is EqualUnmodifiableListView) return _roundStandings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roundStandings);
}

@JsonKey() final  int downloadedRounds;

/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartDownloadingCopyWith<ChartDownloading> get copyWith => _$ChartDownloadingCopyWithImpl<ChartDownloading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartDownloading&&const DeepCollectionEquality().equals(other._roundStandings, _roundStandings)&&(identical(other.downloadedRounds, downloadedRounds) || other.downloadedRounds == downloadedRounds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_roundStandings),downloadedRounds);

@override
String toString() {
  return 'ChartState.downloading(roundStandings: $roundStandings, downloadedRounds: $downloadedRounds)';
}


}

/// @nodoc
abstract mixin class $ChartDownloadingCopyWith<$Res> implements $ChartStateCopyWith<$Res> {
  factory $ChartDownloadingCopyWith(ChartDownloading value, $Res Function(ChartDownloading) _then) = _$ChartDownloadingCopyWithImpl;
@useResult
$Res call({
 List<DriverRoundStanding> roundStandings, int downloadedRounds
});




}
/// @nodoc
class _$ChartDownloadingCopyWithImpl<$Res>
    implements $ChartDownloadingCopyWith<$Res> {
  _$ChartDownloadingCopyWithImpl(this._self, this._then);

  final ChartDownloading _self;
  final $Res Function(ChartDownloading) _then;

/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? roundStandings = null,Object? downloadedRounds = null,}) {
  return _then(ChartDownloading(
roundStandings: null == roundStandings ? _self._roundStandings : roundStandings // ignore: cast_nullable_to_non_nullable
as List<DriverRoundStanding>,downloadedRounds: null == downloadedRounds ? _self.downloadedRounds : downloadedRounds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChartReady implements ChartState {
  const ChartReady({required  List<DriverRoundStanding> roundStandings, required this.downloadedRounds,  Set<String> selectedEntryIds = const <String>{}}): _roundStandings = roundStandings,_selectedEntryIds = selectedEntryIds;
  

 final  List<DriverRoundStanding> _roundStandings;
 List<DriverRoundStanding> get roundStandings {
  if (_roundStandings is EqualUnmodifiableListView) return _roundStandings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roundStandings);
}

 final  int downloadedRounds;
 final  Set<String> _selectedEntryIds;
@JsonKey() Set<String> get selectedEntryIds {
  if (_selectedEntryIds is EqualUnmodifiableSetView) return _selectedEntryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedEntryIds);
}


/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartReadyCopyWith<ChartReady> get copyWith => _$ChartReadyCopyWithImpl<ChartReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartReady&&const DeepCollectionEquality().equals(other._roundStandings, _roundStandings)&&(identical(other.downloadedRounds, downloadedRounds) || other.downloadedRounds == downloadedRounds)&&const DeepCollectionEquality().equals(other._selectedEntryIds, _selectedEntryIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_roundStandings),downloadedRounds,const DeepCollectionEquality().hash(_selectedEntryIds));

@override
String toString() {
  return 'ChartState.ready(roundStandings: $roundStandings, downloadedRounds: $downloadedRounds, selectedEntryIds: $selectedEntryIds)';
}


}

/// @nodoc
abstract mixin class $ChartReadyCopyWith<$Res> implements $ChartStateCopyWith<$Res> {
  factory $ChartReadyCopyWith(ChartReady value, $Res Function(ChartReady) _then) = _$ChartReadyCopyWithImpl;
@useResult
$Res call({
 List<DriverRoundStanding> roundStandings, int downloadedRounds, Set<String> selectedEntryIds
});




}
/// @nodoc
class _$ChartReadyCopyWithImpl<$Res>
    implements $ChartReadyCopyWith<$Res> {
  _$ChartReadyCopyWithImpl(this._self, this._then);

  final ChartReady _self;
  final $Res Function(ChartReady) _then;

/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? roundStandings = null,Object? downloadedRounds = null,Object? selectedEntryIds = null,}) {
  return _then(ChartReady(
roundStandings: null == roundStandings ? _self._roundStandings : roundStandings // ignore: cast_nullable_to_non_nullable
as List<DriverRoundStanding>,downloadedRounds: null == downloadedRounds ? _self.downloadedRounds : downloadedRounds // ignore: cast_nullable_to_non_nullable
as int,selectedEntryIds: null == selectedEntryIds ? _self._selectedEntryIds : selectedEntryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

/// @nodoc


class ChartSelecting implements ChartState {
  const ChartSelecting({required  List<DriverRoundStanding> roundStandings, required this.downloadedRounds,  Set<String> selectedEntryIds = const <String>{}}): _roundStandings = roundStandings,_selectedEntryIds = selectedEntryIds;
  

 final  List<DriverRoundStanding> _roundStandings;
 List<DriverRoundStanding> get roundStandings {
  if (_roundStandings is EqualUnmodifiableListView) return _roundStandings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roundStandings);
}

 final  int downloadedRounds;
 final  Set<String> _selectedEntryIds;
@JsonKey() Set<String> get selectedEntryIds {
  if (_selectedEntryIds is EqualUnmodifiableSetView) return _selectedEntryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedEntryIds);
}


/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartSelectingCopyWith<ChartSelecting> get copyWith => _$ChartSelectingCopyWithImpl<ChartSelecting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartSelecting&&const DeepCollectionEquality().equals(other._roundStandings, _roundStandings)&&(identical(other.downloadedRounds, downloadedRounds) || other.downloadedRounds == downloadedRounds)&&const DeepCollectionEquality().equals(other._selectedEntryIds, _selectedEntryIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_roundStandings),downloadedRounds,const DeepCollectionEquality().hash(_selectedEntryIds));

@override
String toString() {
  return 'ChartState.selecting(roundStandings: $roundStandings, downloadedRounds: $downloadedRounds, selectedEntryIds: $selectedEntryIds)';
}


}

/// @nodoc
abstract mixin class $ChartSelectingCopyWith<$Res> implements $ChartStateCopyWith<$Res> {
  factory $ChartSelectingCopyWith(ChartSelecting value, $Res Function(ChartSelecting) _then) = _$ChartSelectingCopyWithImpl;
@useResult
$Res call({
 List<DriverRoundStanding> roundStandings, int downloadedRounds, Set<String> selectedEntryIds
});




}
/// @nodoc
class _$ChartSelectingCopyWithImpl<$Res>
    implements $ChartSelectingCopyWith<$Res> {
  _$ChartSelectingCopyWithImpl(this._self, this._then);

  final ChartSelecting _self;
  final $Res Function(ChartSelecting) _then;

/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? roundStandings = null,Object? downloadedRounds = null,Object? selectedEntryIds = null,}) {
  return _then(ChartSelecting(
roundStandings: null == roundStandings ? _self._roundStandings : roundStandings // ignore: cast_nullable_to_non_nullable
as List<DriverRoundStanding>,downloadedRounds: null == downloadedRounds ? _self.downloadedRounds : downloadedRounds // ignore: cast_nullable_to_non_nullable
as int,selectedEntryIds: null == selectedEntryIds ? _self._selectedEntryIds : selectedEntryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
