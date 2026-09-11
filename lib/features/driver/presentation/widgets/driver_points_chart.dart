import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../results/domain/entities/race_result.dart';
import '../../../../shared/theme/app_theme.dart';

class DriverPointsChart extends StatelessWidget {
  const DriverPointsChart({required this.results, super.key});

  final List<RaceResult> results;

  /// Vertical space each bar occupies in the rotated chart.
  static const _barHeight = 24.0;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    const maxY = 25.0;

    return Padding(
      padding: const .fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          Text(
            'Season results',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: results.length * _barHeight,
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
                    getTooltipItem: (group, _, _, _) {
                      final result = results.firstWhere((r) => r.round == group.x);
                      return BarTooltipItem(
                        'R${result.round} · P${result.position}\n',
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
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        final round = value.round();
                        final result = results.where((r) => r.round == round).firstOrNull;
                        if (result == null) return const SizedBox.shrink();
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
                      reservedSize: 85,
                      getTitlesWidget: (value, meta) {
                        final round = value.round();
                        final result = results.where((r) => r.round == round).firstOrNull;
                        if (result == null) return const SizedBox.shrink();
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            'P${result.position}·${result.points.toStringAsFixed(0)} pts',
                            style: theme.textTheme.labelSmall,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (final result in results)
                    BarChartGroupData(
                      x: result.round,
                      barRods: [
                        BarChartRodData(
                          toY: result.points,
                          width: 16,
                          color: AppTheme.teamColor(result.constructorId).withValues(
                            alpha: result.position == 1
                                ? 1
                                : result.position <= 3
                                ? .6
                                : .3,
                          ),
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
