import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/models/cache_info.dart';
import '../../../schedule/domain/entities/race.dart';

part 'home_state.freezed.dart';

/// A session within a race weekend, with its scheduled time.
class SessionEntry {
  const SessionEntry(this.name, this.dateTime);
  final String name;
  final DateTime dateTime;
}

/// Pre-computed data for the home screen.
class HomeData {
  const HomeData({
    required this.nextRace,
    required this.sessions,
    required this.totalRounds,
    required this.completedRounds,
    required this.cache,
  });

  /// The next upcoming or in-progress race (null = all races past).
  final Race? nextRace;

  /// Sessions for [nextRace], sorted chronologically.
  final List<SessionEntry> sessions;

  /// Total races in the season.
  final int totalRounds;

  /// How many are already finished.
  final int completedRounds;

  /// Cache metadata for the banner.
  final CacheInfo cache;
}

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({required HomeData data}) = _Loaded;
  const factory HomeState.error({required String message}) = _Error;
}
