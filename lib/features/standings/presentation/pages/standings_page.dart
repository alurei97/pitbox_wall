import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../shared/widgets/error_retry_view.dart';
import '../cubit/chart_cubit.dart';
import '../cubit/standings_cubit.dart';
import '../cubit/standings_state.dart';
import '../widgets/standings_loaded_view.dart';
import '../widgets/standings_skeleton.dart';

/// Bump chart + Standings.
class StandingsPage extends StatelessWidget {
  const StandingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<StandingsCubit>()..load()),
        BlocProvider(create: (_) => getIt<ChartCubit>()..downloadHistory()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<StandingsCubit, StandingsState>(
            builder: (context, state) => state.when(
              initial: () => const StandingsSkeleton(),
              loading: () => const StandingsSkeleton(),
              loaded: (data) => StandingsLoadedView(data: data),
              error: (message) => ErrorRetryView(
                title: "Can't load standings",
                message: message,
                onRetry: () => context.read<StandingsCubit>().load(forceRefresh: true),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
