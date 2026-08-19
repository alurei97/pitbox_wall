// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_round_standing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DriverRoundStanding {

 int get round; String get driverId; String get driverCode; String get constructorId; int get position; double get points;
/// Create a copy of DriverRoundStanding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverRoundStandingCopyWith<DriverRoundStanding> get copyWith => _$DriverRoundStandingCopyWithImpl<DriverRoundStanding>(this as DriverRoundStanding, _$identity);

  /// Serializes this DriverRoundStanding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverRoundStanding&&(identical(other.round, round) || other.round == round)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.position, position) || other.position == position)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,round,driverId,driverCode,constructorId,position,points);

@override
String toString() {
  return 'DriverRoundStanding(round: $round, driverId: $driverId, driverCode: $driverCode, constructorId: $constructorId, position: $position, points: $points)';
}


}

/// @nodoc
abstract mixin class $DriverRoundStandingCopyWith<$Res>  {
  factory $DriverRoundStandingCopyWith(DriverRoundStanding value, $Res Function(DriverRoundStanding) _then) = _$DriverRoundStandingCopyWithImpl;
@useResult
$Res call({
 int round, String driverId, String driverCode, String constructorId, int position, double points
});




}
/// @nodoc
class _$DriverRoundStandingCopyWithImpl<$Res>
    implements $DriverRoundStandingCopyWith<$Res> {
  _$DriverRoundStandingCopyWithImpl(this._self, this._then);

  final DriverRoundStanding _self;
  final $Res Function(DriverRoundStanding) _then;

/// Create a copy of DriverRoundStanding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? round = null,Object? driverId = null,Object? driverCode = null,Object? constructorId = null,Object? position = null,Object? points = null,}) {
  return _then(DriverRoundStanding(
round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverCode: null == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String,constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverRoundStanding].
extension DriverRoundStandingPatterns on DriverRoundStanding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverRoundStanding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverRoundStanding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverRoundStanding value)  $default,){
final _that = this;
switch (_that) {
case _DriverRoundStanding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverRoundStanding value)?  $default,){
final _that = this;
switch (_that) {
case _DriverRoundStanding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int round,  String driverId,  String driverCode,  String constructorId,  int position,  double points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverRoundStanding() when $default != null:
return $default(_that.round,_that.driverId,_that.driverCode,_that.constructorId,_that.position,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int round,  String driverId,  String driverCode,  String constructorId,  int position,  double points)  $default,) {final _that = this;
switch (_that) {
case _DriverRoundStanding():
return $default(_that.round,_that.driverId,_that.driverCode,_that.constructorId,_that.position,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int round,  String driverId,  String driverCode,  String constructorId,  int position,  double points)?  $default,) {final _that = this;
switch (_that) {
case _DriverRoundStanding() when $default != null:
return $default(_that.round,_that.driverId,_that.driverCode,_that.constructorId,_that.position,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriverRoundStanding implements DriverRoundStanding {
  const _DriverRoundStanding({required this.round, required this.driverId, required this.driverCode, required this.constructorId, required this.position, required this.points});
  factory _DriverRoundStanding.fromJson(Map<String, dynamic> json) => _$DriverRoundStandingFromJson(json);

@override final  int round;
@override final  String driverId;
@override final  String driverCode;
@override final  String constructorId;
@override final  int position;
@override final  double points;

/// Create a copy of DriverRoundStanding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverRoundStandingCopyWith<_DriverRoundStanding> get copyWith => __$DriverRoundStandingCopyWithImpl<_DriverRoundStanding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriverRoundStandingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverRoundStanding&&(identical(other.round, round) || other.round == round)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.position, position) || other.position == position)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,round,driverId,driverCode,constructorId,position,points);

@override
String toString() {
  return 'DriverRoundStanding(round: $round, driverId: $driverId, driverCode: $driverCode, constructorId: $constructorId, position: $position, points: $points)';
}


}

/// @nodoc
abstract mixin class _$DriverRoundStandingCopyWith<$Res> implements $DriverRoundStandingCopyWith<$Res> {
  factory _$DriverRoundStandingCopyWith(_DriverRoundStanding value, $Res Function(_DriverRoundStanding) _then) = __$DriverRoundStandingCopyWithImpl;
@override @useResult
$Res call({
 int round, String driverId, String driverCode, String constructorId, int position, double points
});




}
/// @nodoc
class __$DriverRoundStandingCopyWithImpl<$Res>
    implements _$DriverRoundStandingCopyWith<$Res> {
  __$DriverRoundStandingCopyWithImpl(this._self, this._then);

  final _DriverRoundStanding _self;
  final $Res Function(_DriverRoundStanding) _then;

/// Create a copy of DriverRoundStanding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? round = null,Object? driverId = null,Object? driverCode = null,Object? constructorId = null,Object? position = null,Object? points = null,}) {
  return _then(_DriverRoundStanding(
round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverCode: null == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String,constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
