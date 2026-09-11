// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_standing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DriverStanding {

 int get position; double get points; int get wins; String get driverId; String? get driverCode; String get driverNumber; String get givenName; String get familyName; String get nationality; String get dateOfBirth; String get constructorId; String get constructorName;
/// Create a copy of DriverStanding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverStandingCopyWith<DriverStanding> get copyWith => _$DriverStandingCopyWithImpl<DriverStanding>(this as DriverStanding, _$identity);

  /// Serializes this DriverStanding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverStanding&&(identical(other.position, position) || other.position == position)&&(identical(other.points, points) || other.points == points)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.driverNumber, driverNumber) || other.driverNumber == driverNumber)&&(identical(other.givenName, givenName) || other.givenName == givenName)&&(identical(other.familyName, familyName) || other.familyName == familyName)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.constructorName, constructorName) || other.constructorName == constructorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,points,wins,driverId,driverCode,driverNumber,givenName,familyName,nationality,dateOfBirth,constructorId,constructorName);

@override
String toString() {
  return 'DriverStanding(position: $position, points: $points, wins: $wins, driverId: $driverId, driverCode: $driverCode, driverNumber: $driverNumber, givenName: $givenName, familyName: $familyName, nationality: $nationality, dateOfBirth: $dateOfBirth, constructorId: $constructorId, constructorName: $constructorName)';
}


}

/// @nodoc
abstract mixin class $DriverStandingCopyWith<$Res>  {
  factory $DriverStandingCopyWith(DriverStanding value, $Res Function(DriverStanding) _then) = _$DriverStandingCopyWithImpl;
@useResult
$Res call({
 int position, double points, int wins, String driverId, String? driverCode, String driverNumber, String givenName, String familyName, String nationality, String dateOfBirth, String constructorId, String constructorName
});




}
/// @nodoc
class _$DriverStandingCopyWithImpl<$Res>
    implements $DriverStandingCopyWith<$Res> {
  _$DriverStandingCopyWithImpl(this._self, this._then);

  final DriverStanding _self;
  final $Res Function(DriverStanding) _then;

/// Create a copy of DriverStanding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? points = null,Object? wins = null,Object? driverId = null,Object? driverCode = freezed,Object? driverNumber = null,Object? givenName = null,Object? familyName = null,Object? nationality = null,Object? dateOfBirth = null,Object? constructorId = null,Object? constructorName = null,}) {
  return _then(DriverStanding(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverCode: freezed == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String?,driverNumber: null == driverNumber ? _self.driverNumber : driverNumber // ignore: cast_nullable_to_non_nullable
as String,givenName: null == givenName ? _self.givenName : givenName // ignore: cast_nullable_to_non_nullable
as String,familyName: null == familyName ? _self.familyName : familyName // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String,constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,constructorName: null == constructorName ? _self.constructorName : constructorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverStanding].
extension DriverStandingPatterns on DriverStanding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverStanding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverStanding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverStanding value)  $default,){
final _that = this;
switch (_that) {
case _DriverStanding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverStanding value)?  $default,){
final _that = this;
switch (_that) {
case _DriverStanding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int position,  double points,  int wins,  String driverId,  String? driverCode,  String driverNumber,  String givenName,  String familyName,  String nationality,  String dateOfBirth,  String constructorId,  String constructorName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverStanding() when $default != null:
return $default(_that.position,_that.points,_that.wins,_that.driverId,_that.driverCode,_that.driverNumber,_that.givenName,_that.familyName,_that.nationality,_that.dateOfBirth,_that.constructorId,_that.constructorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int position,  double points,  int wins,  String driverId,  String? driverCode,  String driverNumber,  String givenName,  String familyName,  String nationality,  String dateOfBirth,  String constructorId,  String constructorName)  $default,) {final _that = this;
switch (_that) {
case _DriverStanding():
return $default(_that.position,_that.points,_that.wins,_that.driverId,_that.driverCode,_that.driverNumber,_that.givenName,_that.familyName,_that.nationality,_that.dateOfBirth,_that.constructorId,_that.constructorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int position,  double points,  int wins,  String driverId,  String? driverCode,  String driverNumber,  String givenName,  String familyName,  String nationality,  String dateOfBirth,  String constructorId,  String constructorName)?  $default,) {final _that = this;
switch (_that) {
case _DriverStanding() when $default != null:
return $default(_that.position,_that.points,_that.wins,_that.driverId,_that.driverCode,_that.driverNumber,_that.givenName,_that.familyName,_that.nationality,_that.dateOfBirth,_that.constructorId,_that.constructorName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriverStanding implements DriverStanding {
  const _DriverStanding({required this.position, required this.points, required this.wins, required this.driverId, this.driverCode, required this.driverNumber, required this.givenName, required this.familyName, required this.nationality, required this.dateOfBirth, required this.constructorId, required this.constructorName});
  factory _DriverStanding.fromJson(Map<String, dynamic> json) => _$DriverStandingFromJson(json);

@override final  int position;
@override final  double points;
@override final  int wins;
@override final  String driverId;
@override final  String? driverCode;
@override final  String driverNumber;
@override final  String givenName;
@override final  String familyName;
@override final  String nationality;
@override final  String dateOfBirth;
@override final  String constructorId;
@override final  String constructorName;

/// Create a copy of DriverStanding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverStandingCopyWith<_DriverStanding> get copyWith => __$DriverStandingCopyWithImpl<_DriverStanding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriverStandingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverStanding&&(identical(other.position, position) || other.position == position)&&(identical(other.points, points) || other.points == points)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.driverNumber, driverNumber) || other.driverNumber == driverNumber)&&(identical(other.givenName, givenName) || other.givenName == givenName)&&(identical(other.familyName, familyName) || other.familyName == familyName)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.constructorName, constructorName) || other.constructorName == constructorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,points,wins,driverId,driverCode,driverNumber,givenName,familyName,nationality,dateOfBirth,constructorId,constructorName);

@override
String toString() {
  return 'DriverStanding(position: $position, points: $points, wins: $wins, driverId: $driverId, driverCode: $driverCode, driverNumber: $driverNumber, givenName: $givenName, familyName: $familyName, nationality: $nationality, dateOfBirth: $dateOfBirth, constructorId: $constructorId, constructorName: $constructorName)';
}


}

/// @nodoc
abstract mixin class _$DriverStandingCopyWith<$Res> implements $DriverStandingCopyWith<$Res> {
  factory _$DriverStandingCopyWith(_DriverStanding value, $Res Function(_DriverStanding) _then) = __$DriverStandingCopyWithImpl;
@override @useResult
$Res call({
 int position, double points, int wins, String driverId, String? driverCode, String driverNumber, String givenName, String familyName, String nationality, String dateOfBirth, String constructorId, String constructorName
});




}
/// @nodoc
class __$DriverStandingCopyWithImpl<$Res>
    implements _$DriverStandingCopyWith<$Res> {
  __$DriverStandingCopyWithImpl(this._self, this._then);

  final _DriverStanding _self;
  final $Res Function(_DriverStanding) _then;

/// Create a copy of DriverStanding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? points = null,Object? wins = null,Object? driverId = null,Object? driverCode = freezed,Object? driverNumber = null,Object? givenName = null,Object? familyName = null,Object? nationality = null,Object? dateOfBirth = null,Object? constructorId = null,Object? constructorName = null,}) {
  return _then(_DriverStanding(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverCode: freezed == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String?,driverNumber: null == driverNumber ? _self.driverNumber : driverNumber // ignore: cast_nullable_to_non_nullable
as String,givenName: null == givenName ? _self.givenName : givenName // ignore: cast_nullable_to_non_nullable
as String,familyName: null == familyName ? _self.familyName : familyName // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String,constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,constructorName: null == constructorName ? _self.constructorName : constructorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
