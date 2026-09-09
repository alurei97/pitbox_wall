import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/results_repository.dart';
import '../cubit/results_cubit.dart';
import 'qualifying_results_table.dart';
import 'race_results_table.dart';

class ResultsLoadedView extends StatefulWidget {
  const ResultsLoadedView({
    required this.data,
    required this.isCurrentWeek,
    super.key,
  });

  final ResultsResult data;
  final bool isCurrentWeek;

  @override
  State<ResultsLoadedView> createState() => _ResultsLoadedViewState();
}

class _ResultsLoadedViewState extends State<ResultsLoadedView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: _tabs.length - 1,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> get _tabs => [
    if (widget.data.raceResults.any((r) => r.sessionType == 'sprint')) 'Sprint',
    if (widget.data.qualifyingResults.isNotEmpty) ...['Q1', 'Q2', 'Q3'],
    if (widget.data.raceResults.any((r) => r.sessionType == 'race')) 'Race',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = widget.data;
    final tabs = _tabs;
    if (tabs.isEmpty) return const Text('No session results published yet.');

    return RefreshIndicator(
      onRefresh: () => context.read<ResultsCubit>().refresh(),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const SizedBox(height: 24),
          Text(
            widget.isCurrentWeek ? 'Published results' : 'Results',
            style: theme.textTheme.titleMedium,
          ),
          TabBar(
            controller: _tabController,
            isScrollable: false,
            indicatorSize: .label,
            dividerColor: Colors.transparent,
            labelPadding: .zero,
            tabs: [
              for (var i = 0; i < tabs.length; i++)
                Tab(
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: _tabController.index == i ? 16 : 13,
                      fontWeight: _tabController.index == i ? .w700 : .w400,
                      color: _tabController.index == i
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: _tabContentHeight(tabs[_tabController.index], data),
            child: TabBarView(
              controller: _tabController,
              children: [for (final tab in tabs) _sessionView(tab, data)],
            ),
          ),
        ],
      ),
    );
  }

  double _tabContentHeight(String tab, ResultsResult data) {
    final count = switch (tab) {
      'Sprint' => data.raceResults.where((r) => r.sessionType == 'sprint').length,
      'Race' => data.raceResults.where((r) => r.sessionType == 'race').length,
      _ => data.qualifyingResults.length,
    };
    return 56 + count * 64;
  }
}

Widget _sessionView(String session, ResultsResult results) => switch (session) {
  'Sprint' => RaceResultsTable(
    title: session,
    results: results.raceResults.where((r) => r.sessionType == 'sprint').toList(),
  ),
  'Q1' => QualifyingResultsTable(results: results.qualifyingResults, stage: 1),
  'Q2' => QualifyingResultsTable(results: results.qualifyingResults, stage: 2),
  'Q3' => QualifyingResultsTable(results: results.qualifyingResults, stage: 3),
  _ => RaceResultsTable(
    title: session,
    results: results.raceResults.where((r) => r.sessionType == 'race').toList(),
  ),
};
