import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/driver_round_standing.dart';

part 'chart_state.freezed.dart';

@freezed
abstract class ChartState with _$ChartState {
  const factory ChartState.initial() = ChartInitial;

  const factory ChartState.downloading({
    @Default(<DriverRoundStanding>[]) List<DriverRoundStanding> roundStandings,
    @Default(0) int downloadedRounds,
  }) = ChartDownloading;

  const factory ChartState.ready({
    required List<DriverRoundStanding> roundStandings,
    required int downloadedRounds,
    @Default(<String>{}) Set<String> selectedEntryIds,
  }) = ChartReady;

  const factory ChartState.selecting({
    required List<DriverRoundStanding> roundStandings,
    required int downloadedRounds,
    @Default(<String>{}) Set<String> selectedEntryIds,
  }) = ChartSelecting;
}
