import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../shared/widgets/error_retry_view.dart';
import '../cubit/schedule_cubit.dart';
import '../cubit/schedule_state.dart';
import '../widgets/schedule_loaded_view.dart';
import '../widgets/schedule_skeleton.dart';

/// Season schedule.
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ScheduleCubit>()..load(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ScheduleCubit, ScheduleState>(
            builder: (context, state) => state.when(
              initial: () => const ScheduleSkeleton(),
              loading: () => const ScheduleSkeleton(),
              loaded: (races, cache) => ScheduleLoadedView(races: races, cache: cache),
              error: (message) => ErrorRetryView(
                title: "Can't load schedule",
                message: message,
                onRetry: () => context.read<ScheduleCubit>().load(forceRefresh: true),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
