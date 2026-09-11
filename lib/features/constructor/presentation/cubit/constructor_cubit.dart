import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../results/domain/repositories/results_repository.dart';
import '../../../schedule/domain/repositories/schedule_repository.dart';
import '../../../standings/domain/repositories/standings_repository.dart';
import 'constructor_state.dart';

class ConstructorCubit extends Cubit<ConstructorState> {
  ConstructorCubit(
    this._standingsRepository,
    this._scheduleRepository,
    this._resultsRepository,
  ) : super(const ConstructorState.initial());

  final StandingsRepository _standingsRepository;
  final ScheduleRepository _scheduleRepository;
  final ResultsRepository _resultsRepository;

  Future<void> load(String constructorId) async {
    emit(const ConstructorState.loading());

    final standingsResult = await _standingsRepository.getCurrentStandings();
    if (standingsResult case Left(value: final failure)) {
      emit(ConstructorState.error(message: failure.message));
      return;
    }
    final standings = (standingsResult as Right<Failure, dynamic>).value;
    final constructor = standings.constructorStandings
        .where((item) => item.constructorId == constructorId)
        .firstOrNull;
    if (constructor == null) {
      emit(const ConstructorState.error(message: 'Constructor not found.'));
      return;
    }

    final scheduleResult = await _scheduleRepository.getSeasonSchedule();
    if (scheduleResult case Left(value: final failure)) {
      emit(ConstructorState.error(message: failure.message));
      return;
    }
    final schedule = (scheduleResult as Right<Failure, dynamic>).value;
    final races = schedule.races;
    final completed = races.where((race) => race.raceDateTime.isBefore(DateTime.now())).length;
    final season = races.isEmpty ? DateTime.now().year : races.first.raceDateTime.toLocal().year;

    final result = await _resultsRepository.getSeasonResults(
      season: season,
      lastCompletedRound: completed,
    );
    if (result case Left(value: final failure)) {
      emit(ConstructorState.error(message: failure.message));
      return;
    }
    final seasonResults = (result as Right<Failure, dynamic>).value;

    emit(
      ConstructorState.loaded(
        data: ConstructorData(
          constructor: constructor,
          drivers: standings.driverStandings
              .where((driver) => driver.constructorId == constructorId)
              .toList(growable: false),
          results: seasonResults.raceResults
              .where((r) => r.constructorId == constructorId && r.sessionType == 'race')
              .toList(growable: false),
        ),
      ),
    );
  }
}
