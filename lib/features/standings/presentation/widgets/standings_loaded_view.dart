import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/cache_info_banner.dart';
import '../cubit/standings_cubit.dart';
import '../cubit/standings_state.dart';
import '../../../../shared/widgets/list_divider.dart';
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
                onSelectionChanged: (selection) => setState(() => _tab = selection.first),
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

        // ── Scrollable: list ──
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => context.read<StandingsCubit>().load(forceRefresh: true),
            child: _tab == .drivers
                ? ListView.separated(
                    padding: const .all(16),
                    itemCount: data.drivers.length,
                    separatorBuilder: (_, _) => const ListDivider(),
                    itemBuilder: (context, index) =>
                        DriverStandingRow(standing: data.drivers[index]),
                  )
                : ListView.separated(
                    padding: const .all(16),
                    itemCount: data.constructors.length,
                    separatorBuilder: (_, _) => const ListDivider(),
                    itemBuilder: (context, index) =>
                        ConstructorStandingRow(standing: data.constructors[index]),
                  ),
          ),
        ),
      ],
    );
  }
}
