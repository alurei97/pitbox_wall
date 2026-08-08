// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'constructor_standing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConstructorStanding {

 int get position; double get points; int get wins; String get constructorId; String get constructorName;
/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConstructorStandingCopyWith<ConstructorStanding> get copyWith => _$ConstructorStandingCopyWithImpl<ConstructorStanding>(this as ConstructorStanding, _$identity);

  /// Serializes this ConstructorStanding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConstructorStanding&&(identical(other.position, position) || other.position == position)&&(identical(other.points, points) || other.points == points)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.constructorName, constructorName) || other.constructorName == constructorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,points,wins,constructorId,constructorName);

@override
String toString() {
  return 'ConstructorStanding(position: $position, points: $points, wins: $wins, constructorId: $constructorId, constructorName: $constructorName)';
}


}

/// @nodoc
abstract mixin class $ConstructorStandingCopyWith<$Res>  {
  factory $ConstructorStandingCopyWith(ConstructorStanding value, $Res Function(ConstructorStanding) _then) = _$ConstructorStandingCopyWithImpl;
@useResult
$Res call({
 int position, double points, int wins, String constructorId, String constructorName
});




}
/// @nodoc
class _$ConstructorStandingCopyWithImpl<$Res>
    implements $ConstructorStandingCopyWith<$Res> {
  _$ConstructorStandingCopyWithImpl(this._self, this._then);

  final ConstructorStanding _self;
  final $Res Function(ConstructorStanding) _then;

/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? points = null,Object? wins = null,Object? constructorId = null,Object? constructorName = null,}) {
  return _then(ConstructorStanding(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,constructorName: null == constructorName ? _self.constructorName : constructorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConstructorStanding].
extension ConstructorStandingPatterns on ConstructorStanding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConstructorStanding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConstructorStanding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConstructorStanding value)  $default,){
final _that = this;
switch (_that) {
case _ConstructorStanding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConstructorStanding value)?  $default,){
final _that = this;
switch (_that) {
case _ConstructorStanding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int position,  double points,  int wins,  String constructorId,  String constructorName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConstructorStanding() when $default != null:
return $default(_that.position,_that.points,_that.wins,_that.constructorId,_that.constructorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int position,  double points,  int wins,  String constructorId,  String constructorName)  $default,) {final _that = this;
switch (_that) {
case _ConstructorStanding():
return $default(_that.position,_that.points,_that.wins,_that.constructorId,_that.constructorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int position,  double points,  int wins,  String constructorId,  String constructorName)?  $default,) {final _that = this;
switch (_that) {
case _ConstructorStanding() when $default != null:
return $default(_that.position,_that.points,_that.wins,_that.constructorId,_that.constructorName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConstructorStanding implements ConstructorStanding {
  const _ConstructorStanding({required this.position, required this.points, required this.wins, required this.constructorId, required this.constructorName});
  factory _ConstructorStanding.fromJson(Map<String, dynamic> json) => _$ConstructorStandingFromJson(json);

@override final  int position;
@override final  double points;
@override final  int wins;
@override final  String constructorId;
@override final  String constructorName;

/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConstructorStandingCopyWith<_ConstructorStanding> get copyWith => __$ConstructorStandingCopyWithImpl<_ConstructorStanding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConstructorStandingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConstructorStanding&&(identical(other.position, position) || other.position == position)&&(identical(other.points, points) || other.points == points)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.constructorName, constructorName) || other.constructorName == constructorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,points,wins,constructorId,constructorName);

@override
String toString() {
  return 'ConstructorStanding(position: $position, points: $points, wins: $wins, constructorId: $constructorId, constructorName: $constructorName)';
}


}

/// @nodoc
abstract mixin class _$ConstructorStandingCopyWith<$Res> implements $ConstructorStandingCopyWith<$Res> {
  factory _$ConstructorStandingCopyWith(_ConstructorStanding value, $Res Function(_ConstructorStanding) _then) = __$ConstructorStandingCopyWithImpl;
@override @useResult
$Res call({
 int position, double points, int wins, String constructorId, String constructorName
});




}
/// @nodoc
class __$ConstructorStandingCopyWithImpl<$Res>
    implements _$ConstructorStandingCopyWith<$Res> {
  __$ConstructorStandingCopyWithImpl(this._self, this._then);

  final _ConstructorStanding _self;
  final $Res Function(_ConstructorStanding) _then;

/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? points = null,Object? wins = null,Object? constructorId = null,Object? constructorName = null,}) {
  return _then(_ConstructorStanding(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,constructorName: null == constructorName ? _self.constructorName : constructorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
