import 'package:dio/dio.dart';

import '../../domain/entities/qualifying_result.dart';
import '../../domain/entities/race_result.dart';

class ResultsRemoteDataSource {
  ResultsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<RaceResult>> fetchRaceResults({
    required int season,
    required int round,
  }) async {
    final response = await _dio.get('$season/$round/results');
    final rows = _extractRows(response.data, 'Results');
    return rows
        .map((row) => _mapRaceResult(row, round, 'race'))
        .whereType<RaceResult>()
        .toList(growable: false);
  }

  Future<List<RaceResult>> fetchSprintResults({
    required int season,
    required int round,
  }) async {
    final response = await _dio.get('$season/$round/sprint');
    final rows = _extractRows(response.data, 'SprintResults');
    return rows
        .map((row) => _mapRaceResult(row, round, 'sprint'))
        .whereType<RaceResult>()
        .toList(growable: false);
  }

  Future<List<QualifyingResult>> fetchQualifyingResults({
    required int season,
    required int round,
  }) async {
    final response = await _dio.get('$season/$round/qualifying');
    final rows = _extractRows(response.data, 'QualifyingResults');
    return rows
        .map((row) => _mapQualifyingResult(row, round, 'qualifying'))
        .whereType<QualifyingResult>()
        .toList(growable: false);
  }

  List<Map<String, dynamic>> _extractRows(dynamic data, String key) {
    if (data is! Map<String, dynamic>) return const [];
    final mrData = data['MRData'] as Map<String, dynamic>?;
    final raceTable = mrData?['RaceTable'] as Map<String, dynamic>?;
    final races = raceTable?['Races'];
    if (races is! List || races.isEmpty) return const [];
    final race = races.first;
    if (race is! Map<String, dynamic>) return const [];
    final rows = race[key];
    if (rows is! List) return const [];
    return rows.whereType<Map<String, dynamic>>().toList(growable: false);
  }

  RaceResult? _mapRaceResult(Map<String, dynamic> raw, int round, String sessionType) {
    final driver = raw['Driver'] as Map<String, dynamic>?;
    final constructor = raw['Constructor'] as Map<String, dynamic>?;
    final driverId = driver?['driverId']?.toString();
    final driverCode = driver?['code']?.toString();
    final driverNumber = driver?['permanentNumber']?.toString();
    final givenName = driver?['givenName']?.toString();
    final familyName = driver?['familyName']?.toString();
    final nationality = driver?['nationality']?.toString();
    final constructorId = constructor?['constructorId']?.toString();
    final constructorName = constructor?['name']?.toString();
    final position = int.tryParse(raw['position']?.toString() ?? '');
    final grid = int.tryParse(raw['grid']?.toString() ?? '');
    final points = double.tryParse(raw['points']?.toString() ?? '');
    final status = raw['status']?.toString();
    final time = (raw['Time'] as Map<String, dynamic>?)?['time']?.toString();

    if (driverId == null ||
        driverCode == null ||
        driverNumber == null ||
        givenName == null ||
        familyName == null ||
        nationality == null ||
        constructorId == null ||
        constructorName == null ||
        position == null ||
        grid == null ||
        points == null ||
        status == null) {
      return null;
    }

    return RaceResult(
      sessionType: sessionType,
      round: round,
      driverId: driverId,
      driverCode: driverCode,
      driverNumber: driverNumber,
      givenName: givenName,
      familyName: familyName,
      nationality: nationality,
      constructorId: constructorId,
      constructorName: constructorName,
      position: position,
      grid: grid,
      points: points,
      status: status,
      time: time,
    );
  }

  QualifyingResult? _mapQualifyingResult(
    Map<String, dynamic> raw,
    int round,
    String sessionType,
  ) {
    final driver = raw['Driver'] as Map<String, dynamic>?;
    final driverId = driver?['driverId']?.toString();
    final driverCode = driver?['code']?.toString();
    final givenName = driver?['givenName']?.toString();
    final familyName = driver?['familyName']?.toString();
    final constructor = raw['Constructor'] as Map<String, dynamic>?;
    final constructorName = constructor?['name']?.toString();
    final position = int.tryParse(raw['position']?.toString() ?? '');
    if (driverId == null ||
        driverCode == null ||
        givenName == null ||
        familyName == null ||
        constructorName == null ||
        position == null) {
      return null;
    }
    return QualifyingResult(
      sessionType: sessionType,
      round: round,
      driverId: driverId,
      driverCode: driverCode,
      givenName: givenName,
      familyName: familyName,
      constructorName: constructorName,
      position: position,
      q1: raw['Q1']?.toString(),
      q2: raw['Q2']?.toString(),
      q3: raw['Q3']?.toString(),
    );
  }
}
