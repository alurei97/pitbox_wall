// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qualifying_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QualifyingResult {

 String get sessionType; int get round; String get driverId; String get driverCode; String get givenName; String get familyName; String get constructorName; int get position; String? get q1; String? get q2; String? get q3;
/// Create a copy of QualifyingResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QualifyingResultCopyWith<QualifyingResult> get copyWith => _$QualifyingResultCopyWithImpl<QualifyingResult>(this as QualifyingResult, _$identity);

  /// Serializes this QualifyingResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QualifyingResult&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.round, round) || other.round == round)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.givenName, givenName) || other.givenName == givenName)&&(identical(other.familyName, familyName) || other.familyName == familyName)&&(identical(other.constructorName, constructorName) || other.constructorName == constructorName)&&(identical(other.position, position) || other.position == position)&&(identical(other.q1, q1) || other.q1 == q1)&&(identical(other.q2, q2) || other.q2 == q2)&&(identical(other.q3, q3) || other.q3 == q3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionType,round,driverId,driverCode,givenName,familyName,constructorName,position,q1,q2,q3);

@override
String toString() {
  return 'QualifyingResult(sessionType: $sessionType, round: $round, driverId: $driverId, driverCode: $driverCode, givenName: $givenName, familyName: $familyName, constructorName: $constructorName, position: $position, q1: $q1, q2: $q2, q3: $q3)';
}


}

/// @nodoc
abstract mixin class $QualifyingResultCopyWith<$Res>  {
  factory $QualifyingResultCopyWith(QualifyingResult value, $Res Function(QualifyingResult) _then) = _$QualifyingResultCopyWithImpl;
@useResult
$Res call({
 String sessionType, int round, String driverId, String driverCode, String givenName, String familyName, String constructorName, int position, String? q1, String? q2, String? q3
});




}
/// @nodoc
class _$QualifyingResultCopyWithImpl<$Res>
    implements $QualifyingResultCopyWith<$Res> {
  _$QualifyingResultCopyWithImpl(this._self, this._then);

  final QualifyingResult _self;
  final $Res Function(QualifyingResult) _then;

/// Create a copy of QualifyingResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionType = null,Object? round = null,Object? driverId = null,Object? driverCode = null,Object? givenName = null,Object? familyName = null,Object? constructorName = null,Object? position = null,Object? q1 = freezed,Object? q2 = freezed,Object? q3 = freezed,}) {
  return _then(QualifyingResult(
sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverCode: null == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String,givenName: null == givenName ? _self.givenName : givenName // ignore: cast_nullable_to_non_nullable
as String,familyName: null == familyName ? _self.familyName : familyName // ignore: cast_nullable_to_non_nullable
as String,constructorName: null == constructorName ? _self.constructorName : constructorName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,q1: freezed == q1 ? _self.q1 : q1 // ignore: cast_nullable_to_non_nullable
as String?,q2: freezed == q2 ? _self.q2 : q2 // ignore: cast_nullable_to_non_nullable
as String?,q3: freezed == q3 ? _self.q3 : q3 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QualifyingResult].
extension QualifyingResultPatterns on QualifyingResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QualifyingResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QualifyingResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QualifyingResult value)  $default,){
final _that = this;
switch (_that) {
case _QualifyingResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QualifyingResult value)?  $default,){
final _that = this;
switch (_that) {
case _QualifyingResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionType,  int round,  String driverId,  String driverCode,  String givenName,  String familyName,  String constructorName,  int position,  String? q1,  String? q2,  String? q3)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QualifyingResult() when $default != null:
return $default(_that.sessionType,_that.round,_that.driverId,_that.driverCode,_that.givenName,_that.familyName,_that.constructorName,_that.position,_that.q1,_that.q2,_that.q3);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionType,  int round,  String driverId,  String driverCode,  String givenName,  String familyName,  String constructorName,  int position,  String? q1,  String? q2,  String? q3)  $default,) {final _that = this;
switch (_that) {
case _QualifyingResult():
return $default(_that.sessionType,_that.round,_that.driverId,_that.driverCode,_that.givenName,_that.familyName,_that.constructorName,_that.position,_that.q1,_that.q2,_that.q3);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionType,  int round,  String driverId,  String driverCode,  String givenName,  String familyName,  String constructorName,  int position,  String? q1,  String? q2,  String? q3)?  $default,) {final _that = this;
switch (_that) {
case _QualifyingResult() when $default != null:
return $default(_that.sessionType,_that.round,_that.driverId,_that.driverCode,_that.givenName,_that.familyName,_that.constructorName,_that.position,_that.q1,_that.q2,_that.q3);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QualifyingResult implements QualifyingResult {
  const _QualifyingResult({required this.sessionType, required this.round, required this.driverId, required this.driverCode, required this.givenName, required this.familyName, required this.constructorName, required this.position, this.q1, this.q2, this.q3});
  factory _QualifyingResult.fromJson(Map<String, dynamic> json) => _$QualifyingResultFromJson(json);

@override final  String sessionType;
@override final  int round;
@override final  String driverId;
@override final  String driverCode;
@override final  String givenName;
@override final  String familyName;
@override final  String constructorName;
@override final  int position;
@override final  String? q1;
@override final  String? q2;
@override final  String? q3;

/// Create a copy of QualifyingResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QualifyingResultCopyWith<_QualifyingResult> get copyWith => __$QualifyingResultCopyWithImpl<_QualifyingResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QualifyingResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QualifyingResult&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.round, round) || other.round == round)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.givenName, givenName) || other.givenName == givenName)&&(identical(other.familyName, familyName) || other.familyName == familyName)&&(identical(other.constructorName, constructorName) || other.constructorName == constructorName)&&(identical(other.position, position) || other.position == position)&&(identical(other.q1, q1) || other.q1 == q1)&&(identical(other.q2, q2) || other.q2 == q2)&&(identical(other.q3, q3) || other.q3 == q3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionType,round,driverId,driverCode,givenName,familyName,constructorName,position,q1,q2,q3);

@override
String toString() {
  return 'QualifyingResult(sessionType: $sessionType, round: $round, driverId: $driverId, driverCode: $driverCode, givenName: $givenName, familyName: $familyName, constructorName: $constructorName, position: $position, q1: $q1, q2: $q2, q3: $q3)';
}


}

/// @nodoc
abstract mixin class _$QualifyingResultCopyWith<$Res> implements $QualifyingResultCopyWith<$Res> {
  factory _$QualifyingResultCopyWith(_QualifyingResult value, $Res Function(_QualifyingResult) _then) = __$QualifyingResultCopyWithImpl;
@override @useResult
$Res call({
 String sessionType, int round, String driverId, String driverCode, String givenName, String familyName, String constructorName, int position, String? q1, String? q2, String? q3
});




}
/// @nodoc
class __$QualifyingResultCopyWithImpl<$Res>
    implements _$QualifyingResultCopyWith<$Res> {
  __$QualifyingResultCopyWithImpl(this._self, this._then);

  final _QualifyingResult _self;
  final $Res Function(_QualifyingResult) _then;

/// Create a copy of QualifyingResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionType = null,Object? round = null,Object? driverId = null,Object? driverCode = null,Object? givenName = null,Object? familyName = null,Object? constructorName = null,Object? position = null,Object? q1 = freezed,Object? q2 = freezed,Object? q3 = freezed,}) {
  return _then(_QualifyingResult(
sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,driverCode: null == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String,givenName: null == givenName ? _self.givenName : givenName // ignore: cast_nullable_to_non_nullable
as String,familyName: null == familyName ? _self.familyName : familyName // ignore: cast_nullable_to_non_nullable
as String,constructorName: null == constructorName ? _self.constructorName : constructorName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,q1: freezed == q1 ? _self.q1 : q1 // ignore: cast_nullable_to_non_nullable
as String?,q2: freezed == q2 ? _self.q2 : q2 // ignore: cast_nullable_to_non_nullable
as String?,q3: freezed == q3 ? _self.q3 : q3 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
