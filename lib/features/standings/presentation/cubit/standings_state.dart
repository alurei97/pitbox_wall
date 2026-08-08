import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/models/cache_info.dart';
import '../../domain/entities/constructor_standing.dart';
import '../../domain/entities/driver_standing.dart';

part 'standings_state.freezed.dart';

class StandingsData {
  const StandingsData({
    required this.drivers,
    required this.constructors,
    required this.cache,
  });

  final List<DriverStanding> drivers;
  final List<ConstructorStanding> constructors;
  final CacheInfo cache;
}

@freezed
abstract class StandingsState with _$StandingsState {
  const factory StandingsState.initial() = _Initial;
  const factory StandingsState.loading() = _Loading;
  const factory StandingsState.loaded({required StandingsData data}) = _Loaded;
  const factory StandingsState.error({required String message}) = _Error;
}
