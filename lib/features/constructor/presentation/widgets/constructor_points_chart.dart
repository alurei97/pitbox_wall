import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../results/domain/entities/race_result.dart';
import '../../../../shared/theme/app_theme.dart';

class ConstructorPointsChart extends StatelessWidget {
  const ConstructorPointsChart({
    required this.results,
    required this.drivers,
    super.key,
  });

  final List<RaceResult> results;
  final List<dynamic> drivers;

  /// Vertical space each bar group occupies in the rotated chart.
  static const _barHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    const maxY = 25.0;

    // Group results by round
    final groupedByRound = <int, List<RaceResult>>{};
    for (final r in results) {
      groupedByRound.putIfAbsent(r.round, () => []).add(r);
    }
    final rounds = groupedByRound.keys.toList()..sort();

    // Assign a unique color per driver using team color + opacity variation
    final driverIds = <String>{};
    for (final r in results) {
      driverIds.add(r.driverId);
    }
    final driverColorMap = <String, Color>{};
    final sortedDriverIds = driverIds.toList()
      ..sort((a, b) {
        final codeA = results.firstWhere((r) => r.driverId == a).driverCode;
        final codeB = results.firstWhere((r) => r.driverId == b).driverCode;
        return codeA.compareTo(codeB);
      });
    for (var i = 0; i < sortedDriverIds.length; i++) {
      final result = results.firstWhere((r) => r.driverId == sortedDriverIds[i]);
      final base = AppTheme.teamColor(result.constructorId);
      driverColorMap[sortedDriverIds[i]] = i == 0 ? base : base.withValues(alpha: 0.55);
    }

    // Sort results within each round by driver code
    for (final round in groupedByRound.keys) {
      groupedByRound[round]!.sort((a, b) => a.driverCode.compareTo(b.driverCode));
    }

    return Padding(
      padding: const .fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          Text(
            'Season results',
            style: theme.textTheme.titleMedium,
          ),

          // Legend
          Row(
            mainAxisAlignment: .center,
            spacing: 16,
            children: [
              for (final id in sortedDriverIds)
                Row(
                  mainAxisSize: .min,
                  spacing: 4,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: driverColorMap[id],
                        borderRadius: .circular(2),
                      ),
                    ),
                    Text(
                      results.firstWhere((r) => r.driverId == id).driverCode,
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
            ],
          ),

          SizedBox(
            height: rounds.length * _barHeight,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                alignment: .spaceBetween,
                rotationQuarterTurns: 1,
                gridData: const FlGridData(show: false, drawVerticalLine: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: theme.colorScheme.outlineVariant.withValues(alpha: .1),
                    ),
                  ),
                ),
                barTouchData: BarTouchData(
                  touchExtraThreshold: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 500,
                  ),
                  touchTooltipData: BarTouchTooltipData(
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    tooltipPadding: const .all(4),
                    tooltipBorderRadius: .circular(8),
                    getTooltipColor: (_) => theme.colorScheme.surfaceContainerHighest,
                    getTooltipItem: (group, _, _, rodIndex) {
                      final roundResults = groupedByRound[group.x] ?? [];
                      if (rodIndex >= roundResults.length) return null;
                      final result = roundResults[rodIndex];

                      return BarTooltipItem(
                        '${result.driverCode} · P${result.position}\n',
                        theme.textTheme.labelMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: .w700,
                        ),
                        children: [
                          TextSpan(
                            text: '${result.points.toStringAsFixed(0)} pts',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                      getTitlesWidget: (value, meta) {
                        final round = value.round();
                        if (!groupedByRound.containsKey(round)) return const SizedBox.shrink();

                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            'R$round',
                            style: theme.textTheme.labelSmall,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 90,
                      getTitlesWidget: (value, meta) {
                        final round = value.round();
                        final matches = results.where((r) => r.round == round).toList()
                          ..sort((a, b) => a.driverCode.compareTo(b.driverCode));
                        if (matches.isEmpty) return const SizedBox.shrink();

                        return SideTitleWidget(
                          meta: meta,
                          child: Column(
                            mainAxisSize: .min,
                            crossAxisAlignment: .start,
                            children: [
                              for (final r in matches)
                                Text(
                                  '${r.driverCode}·${r.points.toStringAsFixed(0)} pts',
                                  style: theme.textTheme.labelSmall,
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (final round in rounds)
                    BarChartGroupData(
                      x: round,
                      barsSpace: 1,
                      barRods: [
                        for (final result
                            in groupedByRound[round]!.toList()
                              ..sort((a, b) => a.driverCode.compareTo(b.driverCode)))
                          BarChartRodData(
                            toY: result.points,
                            width: 16,
                            color: driverColorMap[result.driverId],
                            borderRadius: .circular(3),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
