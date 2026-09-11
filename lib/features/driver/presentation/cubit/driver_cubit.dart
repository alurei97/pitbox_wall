import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../results/domain/repositories/results_repository.dart';
import '../../../schedule/domain/repositories/schedule_repository.dart';
import '../../../standings/domain/repositories/standings_repository.dart';
import 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit(
    this._standingsRepository,
    this._scheduleRepository,
    this._resultsRepository,
  ) : super(const DriverState.initial());

  final StandingsRepository _standingsRepository;
  final ScheduleRepository _scheduleRepository;
  final ResultsRepository _resultsRepository;

  Future<void> load(String driverId) async {
    emit(const DriverState.loading());

    final standingsResult = await _standingsRepository.getCurrentStandings();
    if (standingsResult case Left(value: final failure)) {
      emit(DriverState.error(message: failure.message));
      return;
    }
    final StandingsResult standings = (standingsResult as Right<Failure, StandingsResult>).value;
    final driver = standings.driverStandings.where((item) => item.driverId == driverId).first;

    final scheduleResult = await _scheduleRepository.getSeasonSchedule();
    if (scheduleResult case Left(value: final failure)) {
      emit(DriverState.error(message: failure.message));
      return;
    }
    final ScheduleResult schedule = (scheduleResult as Right<Failure, ScheduleResult>).value;
    final races = schedule.races;
    final completed = races.where((race) => race.raceDateTime.isBefore(DateTime.now())).length;
    final season = races.isEmpty ? DateTime.now().year : races.first.raceDateTime.toLocal().year;
    final results = await _resultsRepository.getSeasonResults(
      season: season,
      lastCompletedRound: completed,
    );
    if (results case Left(value: final failure)) {
      emit(DriverState.error(message: failure.message));
      return;
    }
    final seasonResults = (results as Right<Failure, ResultsResult>).value;

    emit(
      DriverState.loaded(
        data: DriverData(
          driver: driver,
          raceResults: seasonResults.raceResults
              .where((result) => result.driverId == driverId && result.sessionType == 'race')
              .toList(growable: false),
          poles: seasonResults.qualifyingResults
              .where((result) => result.driverId == driverId && result.position == 1)
              .length,
        ),
      ),
    );
  }
}
