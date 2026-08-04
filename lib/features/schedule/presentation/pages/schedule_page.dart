import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../shared/widgets/error_retry_view.dart';
import '../cubit/schedule_cubit.dart';
import '../cubit/schedule_state.dart';

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
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (races, fromCache) => Column(
                children: [
                  if (fromCache)
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Row(
                        children: [
                          Icon(Icons.cloud_done_outlined, size: 16, color: Color(0xFFAAAAAA)),
                          SizedBox(width: 8),
                          Text(
                            'Loaded from cache',
                            style: TextStyle(fontSize: 12, color: Color(0xFFAAAAAA)),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: races.length,
                      separatorBuilder: (_, index) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final race = races[i];
                        return Card(
                          child: ListTile(
                            title: Text('R${race.round} · ${race.raceName}'),
                            subtitle: Text('${race.circuitName} · ${race.country}'),
                            trailing: Text(
                              _dateLabel(race.raceDateTime),
                              style: const TextStyle(fontSize: 12, color: Color(0xFFAAAAAA)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
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

  String _dateLabel(DateTime dt) {
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    return '$day/$month';
  }
}
