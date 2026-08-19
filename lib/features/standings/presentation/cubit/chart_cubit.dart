import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../schedule/domain/entities/race.dart';
import '../../../schedule/domain/repositories/schedule_repository.dart';
import '../../domain/entities/driver_round_standing.dart';
import '../../domain/repositories/standings_repository.dart';
import 'chart_state.dart';

/// Owns the bump chart's round-by-round download and comparison selection,
/// independent of the standings table's own loading lifecycle.
class ChartCubit extends Cubit<ChartState> {
  ChartCubit(this._standingsRepository, this._scheduleRepository)
    : super(const ChartState.initial());

  final StandingsRepository _standingsRepository;
  final ScheduleRepository _scheduleRepository;

  void startComparison() {
    final current = state;
    if (current is! ChartReady) return;
    emit(
      ChartState.selecting(
        roundStandings: current.roundStandings,
        downloadedRounds: current.downloadedRounds,
      ),
    );
  }

  void toggleEntry(String entryId) {
    final current = state;
    if (current is! ChartSelecting) return;
    final selected = {...current.selectedEntryIds};
    if (selected.contains(entryId)) {
      selected.remove(entryId);
    } else if (selected.length < 6) {
      selected.add(entryId);
    } else {
      return;
    }
    emit(current.copyWith(selectedEntryIds: selected));
  }

  void resetComparison() {
    final current = state;
    if (current is! ChartSelecting) return;
    emit(
      ChartState.ready(
        roundStandings: current.roundStandings,
        downloadedRounds: current.downloadedRounds,
      ),
    );
  }

  Future<void> downloadHistory({bool forceRefresh = false}) async {
    final scheduleResult = await _scheduleRepository.getSeasonSchedule();
    if (scheduleResult case Left()) {
      emit(const ChartState.ready(roundStandings: [], downloadedRounds: 0));
      return;
    }

    final schedule = (scheduleResult as Right<Failure, ScheduleResult>).value;
    final races = schedule.races;
    final now = DateTime.now();
    final currentRound = races
        .where((race) => race.statusAt(now) != RaceStatus.future)
        .fold<int>(0, (int maxRound, Race race) => race.round > maxRound ? race.round : maxRound);
    final season = races.isNotEmpty ? races.first.raceDateTime.toLocal().year : now.year;

    if (currentRound == 0) {
      emit(const ChartState.ready(roundStandings: [], downloadedRounds: 0));
      return;
    }

    final allStandings = <DriverRoundStanding>[];
    for (var round = 1; round <= currentRound; round++) {
      final result = await _standingsRepository.getDriverStandingsAtRound(
        season: season,
        round: round,
        forceRefresh: forceRefresh,
      );
      switch (result) {
        case Left():
          continue;
        case Right(value: final standings):
          allStandings.addAll(standings);
      }
      emit(
        ChartState.downloading(
          roundStandings: List.unmodifiable(allStandings),
          downloadedRounds: round,
        ),
      );
    }

    emit(
      ChartState.ready(
        roundStandings: List.unmodifiable(allStandings),
        downloadedRounds: currentRound,
      ),
    );
  }
}
