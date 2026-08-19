import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/cache_info_banner.dart';
import '../../../../shared/widgets/list_divider.dart';
import '../cubit/chart_cubit.dart';
import '../cubit/chart_state.dart';
import '../cubit/standings_cubit.dart';
import '../cubit/standings_state.dart';
import 'standings_chart.dart';
import 'constructor_standing_row.dart';
import 'driver_standing_row.dart';

/// The standings list and Drivers / Constructors toggle.
enum StandingsTab { drivers, constructors }

class StandingsLoadedView extends StatefulWidget {
  const StandingsLoadedView({required this.data, super.key});

  final StandingsData data;

  @override
  State<StandingsLoadedView> createState() => _StandingsLoadedViewState();
}

class _StandingsLoadedViewState extends State<StandingsLoadedView> {
  StandingsTab _tab = StandingsTab.drivers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final data = widget.data;

    final chart = context.watch<ChartCubit>().state;
    final selecting = chart is ChartSelecting;
    final selectedEntryIds = switch (chart) {
      ChartReady(:final selectedEntryIds) ||
      ChartSelecting(:final selectedEntryIds) => selectedEntryIds,
      _ => const <String>{},
    };

    return Column(
      crossAxisAlignment: .start,
      children: [
        // ── Header ──
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: .center,
            children: [
              Text(
                'Standings',
                style: theme.textTheme.headlineLarge,
                maxLines: 1,
                overflow: .ellipsis,
              ),
              const Spacer(),
              SegmentedButton<StandingsTab>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: .drivers, label: Text('Drivers')),
                  ButtonSegment(value: .constructors, label: Text('Constructors')),
                ],
                selected: {_tab},
                onSelectionChanged: (selection) {
                  context.read<ChartCubit>().resetComparison();
                  setState(() => _tab = selection.first);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return theme.colorScheme.primary;
                    }
                    return theme.colorScheme.surfaceContainerHighest;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return theme.colorScheme.onPrimary;
                    }
                    return theme.colorScheme.onSurface.withValues(alpha: 0.55);
                  }),
                  visualDensity: .compact,
                ),
              ),
            ],
          ),
        ),
        CacheInfoBanner(cache: data.cache, label: 'STANDINGS'),

        StandingsChart(
          chart: chart,
          constructors: _tab == .constructors,
          onStartComparison: () => context.read<ChartCubit>().startComparison(),
        ),

        // ── Scrollable: list ──
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => context.read<StandingsCubit>().load(forceRefresh: true),
            child: _tab == .drivers
                ? ListView.separated(
                    padding: const .fromLTRB(16, 0, 16, 16),
                    itemCount: data.drivers.length,
                    separatorBuilder: (_, _) => const ListDivider(),
                    itemBuilder: (context, index) => DriverStandingRow(
                      standing: data.drivers[index],
                      selecting: selecting,
                      selected: selectedEntryIds.contains(
                        data.drivers[index].driverId,
                      ),
                      onToggle: () => context.read<ChartCubit>().toggleEntry(
                        data.drivers[index].driverId,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const .fromLTRB(16, 8, 16, 16),
                    itemCount: data.constructors.length,
                    separatorBuilder: (_, _) => const ListDivider(),
                    itemBuilder: (context, index) => ConstructorStandingRow(
                      standing: data.constructors[index],
                      selecting: selecting,
                      selected: selectedEntryIds.contains(
                        data.constructors[index].constructorId,
                      ),
                      onToggle: () => context.read<ChartCubit>().toggleEntry(
                        data.constructors[index].constructorId,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
