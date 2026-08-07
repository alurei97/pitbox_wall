import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../shared/widgets/error_retry_view.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_loaded_view.dart';
import '../widgets/home_skeleton.dart';

/// Home — next race & session overview.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..load(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) => state.when(
              initial: () => const HomeSkeleton(),
              loading: () => const HomeSkeleton(),
              loaded: (data) => HomeLoadedView(data: data),
              error: (message) => ErrorRetryView(
                title: "Can't load schedule",
                message: message,
                onRetry: () => context.read<HomeCubit>().load(forceRefresh: true),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
