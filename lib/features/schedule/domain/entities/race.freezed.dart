// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'race.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Race {

 int get round; String get raceName; String? get circuitId; String get circuitName; String get country; String? get locality; double? get latitude; double? get longitude; DateTime get fp1DateTime; DateTime? get fp2DateTime; DateTime? get sprintDateTime; DateTime? get fp3DateTime; DateTime? get sprintQualifyingDateTime; DateTime get qualifyingDateTime; DateTime get raceDateTime;
/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RaceCopyWith<Race> get copyWith => _$RaceCopyWithImpl<Race>(this as Race, _$identity);

  /// Serializes this Race to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Race&&(identical(other.round, round) || other.round == round)&&(identical(other.raceName, raceName) || other.raceName == raceName)&&(identical(other.circuitId, circuitId) || other.circuitId == circuitId)&&(identical(other.circuitName, circuitName) || other.circuitName == circuitName)&&(identical(other.country, country) || other.country == country)&&(identical(other.locality, locality) || other.locality == locality)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.fp1DateTime, fp1DateTime) || other.fp1DateTime == fp1DateTime)&&(identical(other.fp2DateTime, fp2DateTime) || other.fp2DateTime == fp2DateTime)&&(identical(other.sprintDateTime, sprintDateTime) || other.sprintDateTime == sprintDateTime)&&(identical(other.fp3DateTime, fp3DateTime) || other.fp3DateTime == fp3DateTime)&&(identical(other.sprintQualifyingDateTime, sprintQualifyingDateTime) || other.sprintQualifyingDateTime == sprintQualifyingDateTime)&&(identical(other.qualifyingDateTime, qualifyingDateTime) || other.qualifyingDateTime == qualifyingDateTime)&&(identical(other.raceDateTime, raceDateTime) || other.raceDateTime == raceDateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,round,raceName,circuitId,circuitName,country,locality,latitude,longitude,fp1DateTime,fp2DateTime,sprintDateTime,fp3DateTime,sprintQualifyingDateTime,qualifyingDateTime,raceDateTime);

@override
String toString() {
  return 'Race(round: $round, raceName: $raceName, circuitId: $circuitId, circuitName: $circuitName, country: $country, locality: $locality, latitude: $latitude, longitude: $longitude, fp1DateTime: $fp1DateTime, fp2DateTime: $fp2DateTime, sprintDateTime: $sprintDateTime, fp3DateTime: $fp3DateTime, sprintQualifyingDateTime: $sprintQualifyingDateTime, qualifyingDateTime: $qualifyingDateTime, raceDateTime: $raceDateTime)';
}


}

/// @nodoc
abstract mixin class $RaceCopyWith<$Res>  {
  factory $RaceCopyWith(Race value, $Res Function(Race) _then) = _$RaceCopyWithImpl;
@useResult
$Res call({
 int round, String raceName, String? circuitId, String circuitName, String country, String? locality, double? latitude, double? longitude, DateTime fp1DateTime, DateTime? fp2DateTime, DateTime? sprintDateTime, DateTime? fp3DateTime, DateTime? sprintQualifyingDateTime, DateTime qualifyingDateTime, DateTime raceDateTime
});




}
/// @nodoc
class _$RaceCopyWithImpl<$Res>
    implements $RaceCopyWith<$Res> {
  _$RaceCopyWithImpl(this._self, this._then);

  final Race _self;
  final $Res Function(Race) _then;

/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? round = null,Object? raceName = null,Object? circuitId = freezed,Object? circuitName = null,Object? country = null,Object? locality = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? fp1DateTime = null,Object? fp2DateTime = freezed,Object? sprintDateTime = freezed,Object? fp3DateTime = freezed,Object? sprintQualifyingDateTime = freezed,Object? qualifyingDateTime = null,Object? raceDateTime = null,}) {
  return _then(Race(
round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,raceName: null == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String,circuitId: freezed == circuitId ? _self.circuitId : circuitId // ignore: cast_nullable_to_non_nullable
as String?,circuitName: null == circuitName ? _self.circuitName : circuitName // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,locality: freezed == locality ? _self.locality : locality // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,fp1DateTime: null == fp1DateTime ? _self.fp1DateTime : fp1DateTime // ignore: cast_nullable_to_non_nullable
as DateTime,fp2DateTime: freezed == fp2DateTime ? _self.fp2DateTime : fp2DateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,sprintDateTime: freezed == sprintDateTime ? _self.sprintDateTime : sprintDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,fp3DateTime: freezed == fp3DateTime ? _self.fp3DateTime : fp3DateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,sprintQualifyingDateTime: freezed == sprintQualifyingDateTime ? _self.sprintQualifyingDateTime : sprintQualifyingDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,qualifyingDateTime: null == qualifyingDateTime ? _self.qualifyingDateTime : qualifyingDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,raceDateTime: null == raceDateTime ? _self.raceDateTime : raceDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Race].
extension RacePatterns on Race {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Race value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Race() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Race value)  $default,){
final _that = this;
switch (_that) {
case _Race():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Race value)?  $default,){
final _that = this;
switch (_that) {
case _Race() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int round,  String raceName,  String? circuitId,  String circuitName,  String country,  String? locality,  double? latitude,  double? longitude,  DateTime fp1DateTime,  DateTime? fp2DateTime,  DateTime? sprintDateTime,  DateTime? fp3DateTime,  DateTime? sprintQualifyingDateTime,  DateTime qualifyingDateTime,  DateTime raceDateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Race() when $default != null:
return $default(_that.round,_that.raceName,_that.circuitId,_that.circuitName,_that.country,_that.locality,_that.latitude,_that.longitude,_that.fp1DateTime,_that.fp2DateTime,_that.sprintDateTime,_that.fp3DateTime,_that.sprintQualifyingDateTime,_that.qualifyingDateTime,_that.raceDateTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int round,  String raceName,  String? circuitId,  String circuitName,  String country,  String? locality,  double? latitude,  double? longitude,  DateTime fp1DateTime,  DateTime? fp2DateTime,  DateTime? sprintDateTime,  DateTime? fp3DateTime,  DateTime? sprintQualifyingDateTime,  DateTime qualifyingDateTime,  DateTime raceDateTime)  $default,) {final _that = this;
switch (_that) {
case _Race():
return $default(_that.round,_that.raceName,_that.circuitId,_that.circuitName,_that.country,_that.locality,_that.latitude,_that.longitude,_that.fp1DateTime,_that.fp2DateTime,_that.sprintDateTime,_that.fp3DateTime,_that.sprintQualifyingDateTime,_that.qualifyingDateTime,_that.raceDateTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int round,  String raceName,  String? circuitId,  String circuitName,  String country,  String? locality,  double? latitude,  double? longitude,  DateTime fp1DateTime,  DateTime? fp2DateTime,  DateTime? sprintDateTime,  DateTime? fp3DateTime,  DateTime? sprintQualifyingDateTime,  DateTime qualifyingDateTime,  DateTime raceDateTime)?  $default,) {final _that = this;
switch (_that) {
case _Race() when $default != null:
return $default(_that.round,_that.raceName,_that.circuitId,_that.circuitName,_that.country,_that.locality,_that.latitude,_that.longitude,_that.fp1DateTime,_that.fp2DateTime,_that.sprintDateTime,_that.fp3DateTime,_that.sprintQualifyingDateTime,_that.qualifyingDateTime,_that.raceDateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Race implements Race {
  const _Race({required this.round, required this.raceName, this.circuitId, required this.circuitName, required this.country, this.locality, this.latitude, this.longitude, required this.fp1DateTime, this.fp2DateTime, this.sprintDateTime, this.fp3DateTime, this.sprintQualifyingDateTime, required this.qualifyingDateTime, required this.raceDateTime});
  factory _Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);

@override final  int round;
@override final  String raceName;
@override final  String? circuitId;
@override final  String circuitName;
@override final  String country;
@override final  String? locality;
@override final  double? latitude;
@override final  double? longitude;
@override final  DateTime fp1DateTime;
@override final  DateTime? fp2DateTime;
@override final  DateTime? sprintDateTime;
@override final  DateTime? fp3DateTime;
@override final  DateTime? sprintQualifyingDateTime;
@override final  DateTime qualifyingDateTime;
@override final  DateTime raceDateTime;

/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RaceCopyWith<_Race> get copyWith => __$RaceCopyWithImpl<_Race>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Race&&(identical(other.round, round) || other.round == round)&&(identical(other.raceName, raceName) || other.raceName == raceName)&&(identical(other.circuitId, circuitId) || other.circuitId == circuitId)&&(identical(other.circuitName, circuitName) || other.circuitName == circuitName)&&(identical(other.country, country) || other.country == country)&&(identical(other.locality, locality) || other.locality == locality)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.fp1DateTime, fp1DateTime) || other.fp1DateTime == fp1DateTime)&&(identical(other.fp2DateTime, fp2DateTime) || other.fp2DateTime == fp2DateTime)&&(identical(other.sprintDateTime, sprintDateTime) || other.sprintDateTime == sprintDateTime)&&(identical(other.fp3DateTime, fp3DateTime) || other.fp3DateTime == fp3DateTime)&&(identical(other.sprintQualifyingDateTime, sprintQualifyingDateTime) || other.sprintQualifyingDateTime == sprintQualifyingDateTime)&&(identical(other.qualifyingDateTime, qualifyingDateTime) || other.qualifyingDateTime == qualifyingDateTime)&&(identical(other.raceDateTime, raceDateTime) || other.raceDateTime == raceDateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,round,raceName,circuitId,circuitName,country,locality,latitude,longitude,fp1DateTime,fp2DateTime,sprintDateTime,fp3DateTime,sprintQualifyingDateTime,qualifyingDateTime,raceDateTime);

@override
String toString() {
  return 'Race(round: $round, raceName: $raceName, circuitId: $circuitId, circuitName: $circuitName, country: $country, locality: $locality, latitude: $latitude, longitude: $longitude, fp1DateTime: $fp1DateTime, fp2DateTime: $fp2DateTime, sprintDateTime: $sprintDateTime, fp3DateTime: $fp3DateTime, sprintQualifyingDateTime: $sprintQualifyingDateTime, qualifyingDateTime: $qualifyingDateTime, raceDateTime: $raceDateTime)';
}


}

/// @nodoc
abstract mixin class _$RaceCopyWith<$Res> implements $RaceCopyWith<$Res> {
  factory _$RaceCopyWith(_Race value, $Res Function(_Race) _then) = __$RaceCopyWithImpl;
@override @useResult
$Res call({
 int round, String raceName, String? circuitId, String circuitName, String country, String? locality, double? latitude, double? longitude, DateTime fp1DateTime, DateTime? fp2DateTime, DateTime? sprintDateTime, DateTime? fp3DateTime, DateTime? sprintQualifyingDateTime, DateTime qualifyingDateTime, DateTime raceDateTime
});




}
/// @nodoc
class __$RaceCopyWithImpl<$Res>
    implements _$RaceCopyWith<$Res> {
  __$RaceCopyWithImpl(this._self, this._then);

  final _Race _self;
  final $Res Function(_Race) _then;

/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? round = null,Object? raceName = null,Object? circuitId = freezed,Object? circuitName = null,Object? country = null,Object? locality = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? fp1DateTime = null,Object? fp2DateTime = freezed,Object? sprintDateTime = freezed,Object? fp3DateTime = freezed,Object? sprintQualifyingDateTime = freezed,Object? qualifyingDateTime = null,Object? raceDateTime = null,}) {
  return _then(_Race(
round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,raceName: null == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String,circuitId: freezed == circuitId ? _self.circuitId : circuitId // ignore: cast_nullable_to_non_nullable
as String?,circuitName: null == circuitName ? _self.circuitName : circuitName // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,locality: freezed == locality ? _self.locality : locality // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,fp1DateTime: null == fp1DateTime ? _self.fp1DateTime : fp1DateTime // ignore: cast_nullable_to_non_nullable
as DateTime,fp2DateTime: freezed == fp2DateTime ? _self.fp2DateTime : fp2DateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,sprintDateTime: freezed == sprintDateTime ? _self.sprintDateTime : sprintDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,fp3DateTime: freezed == fp3DateTime ? _self.fp3DateTime : fp3DateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,sprintQualifyingDateTime: freezed == sprintQualifyingDateTime ? _self.sprintQualifyingDateTime : sprintQualifyingDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,qualifyingDateTime: null == qualifyingDateTime ? _self.qualifyingDateTime : qualifyingDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,raceDateTime: null == raceDateTime ? _self.raceDateTime : raceDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
