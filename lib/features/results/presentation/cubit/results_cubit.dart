import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/either.dart';
import '../../domain/repositories/results_repository.dart';
import 'results_state.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit(this._repository) : super(const ResultsState.initial());

  final ResultsRepository _repository;

  Future<void> load({required int season, required int round}) async {
    emit(const ResultsState.loading());

    final result = await _repository.getRoundResults(season: season, round: round);
    switch (result) {
      case Right(value: final data):
        emit(ResultsState.loaded(data));
      case Left(value: final failure):
        emit(ResultsState.error(failure.message));
    }
  }
}
