import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../shared/widgets/error_retry_view.dart';
import '../../../standings/domain/entities/driver_standing.dart';
import '../widgets/driver_header.dart';
import '../widgets/driver_loading_view.dart';
import '../widgets/driver_points_chart.dart';
import '../widgets/driver_stats.dart';
import '../cubit/driver_cubit.dart';
import '../cubit/driver_state.dart';

/// Full-screen driver detail page: personal info, season info, race results...
class DriverPage extends StatefulWidget {
  const DriverPage({
    required this.id,
    this.driver,
    super.key,
  });

  final String id;
  final DriverStanding? driver;

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DriverCubit>()..load(widget.id),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<DriverCubit, DriverState>(
            builder: (context, state) => state.when(
              initial: () => _loadingView(context),
              loading: () => _loadingView(context),
              loaded: (data) => _DriverView(data: data),
              error: (message) => ErrorRetryView(
                title: "Can't load driver",
                message: message,
                onRetry: () => context.read<DriverCubit>().load(widget.id),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingView(BuildContext context) {
    return DriverLoadingView(
      driver: widget.driver,
      onBack: () => Navigator.of(context).pop(),
    );
  }
}

class _DriverView extends StatelessWidget {
  const _DriverView({required this.data});

  final DriverData data;

  @override
  Widget build(BuildContext context) {
    final driver = data.driver;
    final results = data.raceResults;
    final podiumCount = results.where((r) => r.position <= 3).length;
    final dnfCount = results.where((r) => r.status != 'Finished').length;

    return ListView(
      padding: .zero,
      children: [
        DriverHeader(
          driver: driver,
          onBack: () => Navigator.of(context).pop(),
        ),
        DriverStats(
          stats: [
            ('WINS', driver.wins),
            ('PODIUMS', podiumCount),
            ('POLES', data.poles),
            ('DNFS', dnfCount),
          ],
        ),
        DriverPointsChart(results: results),
      ],
    );
  }
}
