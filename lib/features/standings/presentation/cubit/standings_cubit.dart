import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/either.dart';
import '../../../../shared/models/cache_info.dart';
import '../../domain/repositories/standings_repository.dart';
import 'standings_state.dart';

class StandingsCubit extends Cubit<StandingsState> {
  StandingsCubit(this._repository) : super(const StandingsState.initial());

  final StandingsRepository _repository;

  Future<void> load({bool forceRefresh = false}) async {
    emit(const StandingsState.loading());

    final sw = Stopwatch()..start();
    final result = await _repository.getCurrentStandings(forceRefresh: forceRefresh);
    sw.stop();

    switch (result) {
      case Left(value: final failure):
        emit(StandingsState.error(message: failure.message));
      case Right(value: final standingsResult):
        final old = standingsResult.cache;
        emit(
          StandingsState.loaded(
            data: StandingsData(
              drivers: standingsResult.driverStandings,
              constructors: standingsResult.constructorStandings,
              cache: CacheInfo(
                fromCache: old.fromCache,
                responseTimeMs: sw.elapsedMilliseconds,
                fetchedAt: old.fetchedAt,
                ttlSeconds: old.ttlSeconds,
              ),
            ),
          ),
        );
    }
  }
}
