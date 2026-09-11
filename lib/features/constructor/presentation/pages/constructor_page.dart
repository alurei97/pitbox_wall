import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/error_retry_view.dart';
import '../widgets/constructor_drivers_list.dart';
import '../widgets/constructor_header.dart';
import '../../../standings/domain/entities/constructor_standing.dart';
import '../widgets/constructor_loading_view.dart';
import '../widgets/constructor_points_chart.dart';
import '../widgets/constructor_stats.dart';
import '../cubit/constructor_cubit.dart';
import '../cubit/constructor_state.dart';

/// Full-screen constructor detail page: constructor info, season info, race results...
class ConstructorPage extends StatefulWidget {
  const ConstructorPage({required this.id, required this.constructor, super.key});

  final String id;
  final ConstructorStanding constructor;

  @override
  State<ConstructorPage> createState() => _ConstructorPageState();
}

class _ConstructorPageState extends State<ConstructorPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ConstructorCubit>()..load(widget.id),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ConstructorCubit, ConstructorState>(
            builder: (context, state) => state.when(
              initial: () => _loadingView(context),
              loading: () => _loadingView(context),
              loaded: (data) => _ConstructorView(data: data),
              error: (message) => ErrorRetryView(
                title: "Can't load constructor",
                message: message,
                onRetry: () => context.read<ConstructorCubit>().load(widget.id),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingView(BuildContext context) {
    return ConstructorLoadingView(
      constructor: widget.constructor,
      onBack: () => Navigator.of(context).pop(),
    );
  }
}

class _ConstructorView extends StatelessWidget {
  const _ConstructorView({required this.data});

  final ConstructorData data;

  @override
  Widget build(BuildContext context) {
    final team = data.constructor;
    final podiums = data.results.where((r) => r.position <= 3).length;
    final teamColor = AppTheme.teamColor(team.constructorId);

    return ListView(
      padding: .zero,
      children: [
        ConstructorHeader(
          constructor: team,
          onBack: () => Navigator.of(context).pop(),
        ),
        ConstructorStats(
          stats: [
            ('POSITION', team.position),
            ('POINTS', team.points.round()),
            ('WINS', team.wins),
            ('PODIUMS', podiums),
          ],
        ),
        if (data.drivers.isNotEmpty)
          ConstructorDriversList(
            drivers: data.drivers,
            teamColor: teamColor,
          ),
        ConstructorPointsChart(
          results: data.results,
          drivers: data.drivers,
        ),
      ],
    );
  }
}
