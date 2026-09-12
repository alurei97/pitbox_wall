import 'dart:convert';

import 'package:flutter/services.dart';

class TrackMetadata {
  const TrackMetadata({
    required this.lengthKm,
    required this.turns,
    required this.raceLaps,
    required this.raceDistanceKm,
  });

  final double lengthKm;
  final int turns;
  final int raceLaps;
  final double raceDistanceKm;
}

final Map<String, Future<TrackMetadata?>> _trackMetadataCache = {};

Future<TrackMetadata?> loadTrackMetadata(String circuitId) {
  return _trackMetadataCache.putIfAbsent(circuitId, () async {
    final raw = await rootBundle.loadString('assets/tracks/metadata.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final value = json[circuitId];
    if (value is! Map<String, dynamic>) return null;
    return TrackMetadata(
      lengthKm: (value['lengthKm'] as num).toDouble(),
      turns: value['turns'] as int,
      raceLaps: value['raceLaps'] as int,
      raceDistanceKm: (value['raceDistanceKm'] as num).toDouble(),
    );
  });
}
