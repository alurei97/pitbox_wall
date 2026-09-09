import 'package:dio/dio.dart';

import '../../domain/entities/race.dart';

class ScheduleRemoteDataSource {
  ScheduleRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<Race>> fetchCurrentSeasonRaces() async {
    final res = await _dio.get('current/races');
    final data = res.data;

    if (data is! Map<String, dynamic>) return const [];

    final raceTable = (data['MRData'] as Map<String, dynamic>?)?['RaceTable'];
    final races = (raceTable as Map<String, dynamic>?)?['Races'];

    if (races is! List) return const [];

    return races
        .whereType<Map<String, dynamic>>()
        .map(_mapRace)
        .whereType<Race>()
        .toList(growable: false);
  }

  Race? _mapRace(Map<String, dynamic> raw) {
    final roundRaw = raw['round']?.toString();
    final raceName = raw['raceName']?.toString();

    final circuit = raw['Circuit'] as Map<String, dynamic>?;
    final circuitId = circuit?['circuitId']?.toString();
    final circuitName = circuit?['circuitName']?.toString();
    final location = circuit?['Location'] as Map<String, dynamic>?;
    final country = location?['country']?.toString();
    final locality = location?['locality']?.toString();
    final latitude = double.tryParse(location?['lat']?.toString() ?? '');
    final longitude = double.tryParse(location?['long']?.toString() ?? '');

    if (roundRaw == null || raceName == null || circuitName == null || country == null) {
      return null;
    }

    final round = int.tryParse(roundRaw);
    if (round == null) return null;

    final fp1DateTime = _sessionDateTime(raw, 'FirstPractice');
    final qualifyingDateTime = _sessionDateTime(raw, 'Qualifying');
    final raceDateTime = _rootSessionDateTime(raw);

    if (fp1DateTime == null || qualifyingDateTime == null || raceDateTime == null) {
      return null;
    }

    return Race(
      round: round,
      raceName: raceName,
      circuitId: circuitId,
      circuitName: circuitName,
      country: country,
      locality: locality,
      latitude: latitude,
      longitude: longitude,
      fp1DateTime: fp1DateTime,
      fp2DateTime: _sessionDateTime(raw, 'SecondPractice'),
      sprintDateTime: _sessionDateTime(raw, 'Sprint'),
      fp3DateTime: _sessionDateTime(raw, 'ThirdPractice'),
      sprintQualifyingDateTime: _sessionDateTime(raw, 'SprintQualifying'),
      qualifyingDateTime: qualifyingDateTime,
      raceDateTime: raceDateTime.toUtc(),
    );
  }

  DateTime? _rootSessionDateTime(Map<String, dynamic> raw) {
    final dateRaw = raw['date']?.toString();
    final timeRaw = raw['time']?.toString();
    return _parseDateTime(dateRaw, timeRaw);
  }

  DateTime? _sessionDateTime(Map<String, dynamic> raw, String key) {
    final session = raw[key] as Map<String, dynamic>?;
    if (session == null) return null;
    final dateRaw = session['date']?.toString();
    final timeRaw = session['time']?.toString();
    return _parseDateTime(dateRaw, timeRaw);
  }

  DateTime? _parseDateTime(String? dateRaw, String? timeRaw) {
    if (dateRaw == null || dateRaw.isEmpty) return null;
    final isoDate = timeRaw == null || timeRaw.isEmpty
        ? '${dateRaw}T00:00:00Z'
        : '${dateRaw}T$timeRaw';
    return DateTime.tryParse(isoDate)?.toUtc();
  }
}
