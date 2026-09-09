import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../shared/widgets/error_retry_view.dart';
import '../../../schedule/domain/entities/race.dart';
import '../cubit/results_cubit.dart';
import '../cubit/results_state.dart';
import 'results_loading_view.dart';
import 'results_loaded_view.dart';

class RaceResultsSection extends StatelessWidget {
  const RaceResultsSection({required this.race, required this.isCurrentWeek, super.key});

  final Race race;
  final bool isCurrentWeek;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ResultsCubit>()..load(season: race.raceDateTime.toLocal().year, round: race.round),
      child: _RaceResultsBody(race: race, isCurrentWeek: isCurrentWeek),
    );
  }
}

class _RaceResultsBody extends StatelessWidget {
  const _RaceResultsBody({required this.race, required this.isCurrentWeek});

  final Race race;
  final bool isCurrentWeek;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultsCubit, ResultsState>(
      builder: (context, state) => state.when(
        initial: () => const ResultsLoadingView(),
        loading: () => const ResultsLoadingView(),
        loaded: (data) => ResultsLoadedView(data: data, isCurrentWeek: isCurrentWeek),
        error: (message) => ErrorRetryView(
          title: "Can't load results",
          message: message,
          onRetry: () => context.read<ResultsCubit>().load(
            season: race.raceDateTime.toLocal().year,
            round: race.round,
          ),
        ),
      ),
    );
  }
}
