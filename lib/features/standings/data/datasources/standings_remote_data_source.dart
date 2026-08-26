import 'package:dio/dio.dart';

import '../../domain/entities/constructor_standing.dart';
import '../../domain/entities/driver_round_standing.dart';
import '../../domain/entities/driver_standing.dart';

class StandingsRemoteDataSource {
  StandingsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<DriverStanding>> fetchCurrentDriverStandings() async {
    final res = await _dio.get('current/driverStandings');
    final rows = _extractStandingsRows(res.data, 'DriverStandings');
    return rows.map(_mapDriverStanding).whereType<DriverStanding>().toList(growable: false);
  }

  Future<List<ConstructorStanding>> fetchCurrentConstructorStandings() async {
    final res = await _dio.get('current/constructorStandings');
    final rows = _extractStandingsRows(res.data, 'ConstructorStandings');
    return rows
        .map(_mapConstructorStanding)
        .whereType<ConstructorStanding>()
        .toList(growable: false);
  }

  Future<List<DriverRoundStanding>> fetchDriverStandingsAtRound({
    required int season,
    required int round,
  }) async {
    final res = await _dio.get('$season/$round/driverStandings');
    final rows = _extractStandingsRows(res.data, 'DriverStandings');
    return rows
        .map((row) => _mapDriverRoundStanding(row, round))
        .whereType<DriverRoundStanding>()
        .toList(growable: false);
  }

  List<Map<String, dynamic>> _extractStandingsRows(dynamic data, String rowsKey) {
    if (data is! Map<String, dynamic>) return const [];
    final mrData = data['MRData'] as Map<String, dynamic>?;
    final standingsTable = mrData?['StandingsTable'] as Map<String, dynamic>?;
    final lists = standingsTable?['StandingsLists'];
    if (lists is! List || lists.isEmpty) return const [];
    final first = lists.first;
    if (first is! Map<String, dynamic>) return const [];
    final rows = first[rowsKey];
    if (rows is! List) return const [];
    return rows.whereType<Map<String, dynamic>>().toList(growable: false);
  }

  DriverStanding? _mapDriverStanding(Map<String, dynamic> raw) {
    final position = int.tryParse(raw['position']?.toString() ?? '');
    final points = double.tryParse(raw['points']?.toString() ?? '');
    final wins = int.tryParse(raw['wins']?.toString() ?? '');
    final driver = raw['Driver'] as Map<String, dynamic>?;
    final constructors = raw['Constructors'] as List?;
    final constructor = constructors != null && constructors.isNotEmpty
        ? constructors.first as Map<String, dynamic>?
        : null;

    if (position == null ||
        points == null ||
        wins == null ||
        driver == null ||
        constructor == null) {
      return null;
    }

    final driverId = driver['driverId']?.toString();
    final givenName = driver['givenName']?.toString();
    final familyName = driver['familyName']?.toString();
    final driverNumber = driver['permanentNumber']?.toString();
    final constructorId = constructor['constructorId']?.toString();
    final constructorName = constructor['name']?.toString();

    if (driverId == null || givenName == null || familyName == null || driverNumber == null)
      return null;
    if (constructorId == null || constructorName == null) return null;

    return DriverStanding(
      position: position,
      points: points,
      wins: wins,
      driverId: driverId,
      driverCode: driver['code']?.toString(),
      driverNumber: driverNumber,
      givenName: givenName,
      familyName: familyName,
      constructorId: constructorId,
      constructorName: constructorName,
    );
  }

  ConstructorStanding? _mapConstructorStanding(Map<String, dynamic> raw) {
    final position = int.tryParse(raw['position']?.toString() ?? '');
    final points = double.tryParse(raw['points']?.toString() ?? '');
    final wins = int.tryParse(raw['wins']?.toString() ?? '');
    final constructor = raw['Constructor'] as Map<String, dynamic>?;

    if (position == null || points == null || wins == null || constructor == null) return null;

    final constructorId = constructor['constructorId']?.toString();
    final constructorName = constructor['name']?.toString();

    if (constructorId == null || constructorName == null) return null;

    return ConstructorStanding(
      position: position,
      points: points,
      wins: wins,
      constructorId: constructorId,
      constructorName: constructorName,
    );
  }

  DriverRoundStanding? _mapDriverRoundStanding(Map<String, dynamic> raw, int round) {
    final position = int.tryParse(raw['position']?.toString() ?? '');
    final points = double.tryParse(raw['points']?.toString() ?? '');
    final driver = raw['Driver'] as Map<String, dynamic>?;
    final driverId = driver?['driverId']?.toString();
    final driverCode = driver?['code']?.toString();
    final constructors = raw['Constructors'] as List?;
    final constructor = constructors != null && constructors.isNotEmpty
        ? constructors.first as Map<String, dynamic>?
        : null;
    final constructorId = constructor?['constructorId']?.toString();

    if (position == null ||
        points == null ||
        driverId == null ||
        driverCode == null ||
        constructorId == null) {
      return null;
    }

    return DriverRoundStanding(
      round: round,
      driverId: driverId,
      driverCode: driverCode,
      constructorId: constructorId,
      position: position,
      points: points,
    );
  }
}
