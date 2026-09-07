import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/repositories/results_repository.dart';

part 'results_state.freezed.dart';

@freezed
abstract class ResultsState with _$ResultsState {
  const factory ResultsState.initial() = _Initial;
  const factory ResultsState.loading() = _Loading;
  const factory ResultsState.loaded(ResultsResult data) = _Loaded;
  const factory ResultsState.error(String message) = _Error;
}
