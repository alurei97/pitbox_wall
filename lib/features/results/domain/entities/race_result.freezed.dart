// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'race_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RaceResult {

 String get sessionType; int get round; String get driverId; String get driverCode; String get driverNumber; String get givenName; String get familyName; String get nationality; String get constructorId; String get constructorName; int get position; int get grid; double get points; String get status; String? get time;
/// Create a copy of RaceResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RaceResultCopyWith<RaceResult> get copyWith => _$RaceResultCopyWithImpl<RaceResult>(this as RaceResult, _$identity);

  /// Serializes this RaceResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RaceResult&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.round, round) || other.round == round)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.driverNumber, driverNumber) || other.driverNumber == driverNumber)&&(identical(other.givenName, givenName) || other.givenName == givenName)&&(identical(other.familyName, familyName) || other.familyName == familyName)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.constructorName, constructorName) || other.constructorName == constructorName)&&(identical(other.position, position) || other.position == position)&&(identical(other.grid, grid) || other.grid == grid)&&(identical(other.points, points) || other.points == points)&&(identical(other.status, status) || other.status == status)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionType,round,driverId,driverCode,driverNumber,givenName,familyName,nationality,constructorId,constructorName,position,grid,points,status,time);

@override
String toString() {
  return 'RaceResult(sessionType: $sessionType, round: $round, driverId: $driverId, driverCode: $driverCode, driverNumber: $driverNumber, givenName: $givenName, familyName: $familyName, nationality: $nationality, constructorId: $constructorId, constructorName: $constructorName, position: $position, grid: $grid, points: $points, status: $status, time: $time)';
}


}

/// @nodoc
abstract mixin class $RaceResultCopyWith<$Res>  {
  factory $RaceResultCopyWith(RaceResult value, $Res Function(RaceResult) _then) = _$RaceResultCopyWithImpl;
@useResult
$Res call({
 String sessionType, int round, String driverId, String driverCode, String driverNumber, String givenName, String familyName, String nationality, String constructorId, String constructorName, int position, int grid, double points, String status, String? time
});




}
/// @nodoc
class _$RaceResultCopyWithImpl<$Res>
    implements $RaceResultCopyWith<$Res> {
  _$RaceResultCopyWithImpl(this._self, this._then);

  final RaceResult _self;
  final $Res Function(RaceResult) _then;

/// Create a copy of RaceResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionType = null,Object? round = null,Object? driverId = null,Object? driverCode = null,Object? driverNumber = null,Object? givenName = null,Object? familyName = null,Object? nationality = null,Object? constructorId = null,Object? constructorName = null,Object? position = null,Object? grid = null,Object? points = null,Object? status = null,Object? time = freezed,}) {
  return _then(RaceResult(
sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverCode: null == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String,driverNumber: null == driverNumber ? _self.driverNumber : driverNumber // ignore: cast_nullable_to_non_nullable
as String,givenName: null == givenName ? _self.givenName : givenName // ignore: cast_nullable_to_non_nullable
as String,familyName: null == familyName ? _self.familyName : familyName // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,constructorName: null == constructorName ? _self.constructorName : constructorName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,grid: null == grid ? _self.grid : grid // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RaceResult].
extension RaceResultPatterns on RaceResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RaceResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RaceResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RaceResult value)  $default,){
final _that = this;
switch (_that) {
case _RaceResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RaceResult value)?  $default,){
final _that = this;
switch (_that) {
case _RaceResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionType,  int round,  String driverId,  String driverCode,  String driverNumber,  String givenName,  String familyName,  String nationality,  String constructorId,  String constructorName,  int position,  int grid,  double points,  String status,  String? time)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RaceResult() when $default != null:
return $default(_that.sessionType,_that.round,_that.driverId,_that.driverCode,_that.driverNumber,_that.givenName,_that.familyName,_that.nationality,_that.constructorId,_that.constructorName,_that.position,_that.grid,_that.points,_that.status,_that.time);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionType,  int round,  String driverId,  String driverCode,  String driverNumber,  String givenName,  String familyName,  String nationality,  String constructorId,  String constructorName,  int position,  int grid,  double points,  String status,  String? time)  $default,) {final _that = this;
switch (_that) {
case _RaceResult():
return $default(_that.sessionType,_that.round,_that.driverId,_that.driverCode,_that.driverNumber,_that.givenName,_that.familyName,_that.nationality,_that.constructorId,_that.constructorName,_that.position,_that.grid,_that.points,_that.status,_that.time);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionType,  int round,  String driverId,  String driverCode,  String driverNumber,  String givenName,  String familyName,  String nationality,  String constructorId,  String constructorName,  int position,  int grid,  double points,  String status,  String? time)?  $default,) {final _that = this;
switch (_that) {
case _RaceResult() when $default != null:
return $default(_that.sessionType,_that.round,_that.driverId,_that.driverCode,_that.driverNumber,_that.givenName,_that.familyName,_that.nationality,_that.constructorId,_that.constructorName,_that.position,_that.grid,_that.points,_that.status,_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RaceResult implements RaceResult {
  const _RaceResult({required this.sessionType, required this.round, required this.driverId, required this.driverCode, required this.driverNumber, required this.givenName, required this.familyName, required this.nationality, required this.constructorId, required this.constructorName, required this.position, required this.grid, required this.points, required this.status, this.time});
  factory _RaceResult.fromJson(Map<String, dynamic> json) => _$RaceResultFromJson(json);

@override final  String sessionType;
@override final  int round;
@override final  String driverId;
@override final  String driverCode;
@override final  String driverNumber;
@override final  String givenName;
@override final  String familyName;
@override final  String nationality;
@override final  String constructorId;
@override final  String constructorName;
@override final  int position;
@override final  int grid;
@override final  double points;
@override final  String status;
@override final  String? time;

/// Create a copy of RaceResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RaceResultCopyWith<_RaceResult> get copyWith => __$RaceResultCopyWithImpl<_RaceResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RaceResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RaceResult&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.round, round) || other.round == round)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.driverNumber, driverNumber) || other.driverNumber == driverNumber)&&(identical(other.givenName, givenName) || other.givenName == givenName)&&(identical(other.familyName, familyName) || other.familyName == familyName)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.constructorName, constructorName) || other.constructorName == constructorName)&&(identical(other.position, position) || other.position == position)&&(identical(other.grid, grid) || other.grid == grid)&&(identical(other.points, points) || other.points == points)&&(identical(other.status, status) || other.status == status)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionType,round,driverId,driverCode,driverNumber,givenName,familyName,nationality,constructorId,constructorName,position,grid,points,status,time);

@override
String toString() {
  return 'RaceResult(sessionType: $sessionType, round: $round, driverId: $driverId, driverCode: $driverCode, driverNumber: $driverNumber, givenName: $givenName, familyName: $familyName, nationality: $nationality, constructorId: $constructorId, constructorName: $constructorName, position: $position, grid: $grid, points: $points, status: $status, time: $time)';
}


}

/// @nodoc
abstract mixin class _$RaceResultCopyWith<$Res> implements $RaceResultCopyWith<$Res> {
  factory _$RaceResultCopyWith(_RaceResult value, $Res Function(_RaceResult) _then) = __$RaceResultCopyWithImpl;
@override @useResult
$Res call({
 String sessionType, int round, String driverId, String driverCode, String driverNumber, String givenName, String familyName, String nationality, String constructorId, String constructorName, int position, int grid, double points, String status, String? time
});




}
/// @nodoc
class __$RaceResultCopyWithImpl<$Res>
    implements _$RaceResultCopyWith<$Res> {
  __$RaceResultCopyWithImpl(this._self, this._then);

  final _RaceResult _self;
  final $Res Function(_RaceResult) _then;

/// Create a copy of RaceResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionType = null,Object? round = null,Object? driverId = null,Object? driverCode = null,Object? driverNumber = null,Object? givenName = null,Object? familyName = null,Object? nationality = null,Object? constructorId = null,Object? constructorName = null,Object? position = null,Object? grid = null,Object? points = null,Object? status = null,Object? time = freezed,}) {
  return _then(_RaceResult(
sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverCode: null == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String,driverNumber: null == driverNumber ? _self.driverNumber : driverNumber // ignore: cast_nullable_to_non_nullable
as String,givenName: null == givenName ? _self.givenName : givenName // ignore: cast_nullable_to_non_nullable
as String,familyName: null == familyName ? _self.familyName : familyName // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,constructorName: null == constructorName ? _self.constructorName : constructorName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,grid: null == grid ? _self.grid : grid // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
