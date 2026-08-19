import 'package:flutter/material.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/driver_round_standing.dart';
import '../cubit/chart_state.dart';

class _ComparisonCopy {
  static const start = 'Start comparison';
  static const instruction = 'Select up to 6 entries to compare them';
  static const selected = 'of 6 entries selected';
}

/// Short display code for a constructor, max 4 chars
String _constructorCode(String constructorId) {
  const codes = {
    'mclaren': 'MCL',
    'red_bull': 'RB',
    'ferrari': 'FER',
    'mercedes': 'MER',
    'aston_martin': 'AM',
    'alpine': 'ALP',
    'williams': 'WIL',
    'haas': 'HAA',
    'rb': 'RBR',
    'cadillac': 'CAD',
  };

  final key = constructorId.toLowerCase();
  final known = codes[key];
  if (known != null) return known;

  // Fallback: initials of underscore-separated words, or first 3 letters.
  final parts = key.split('_');
  final initials = parts.map((p) => p[0]).join().toUpperCase();
  if (initials.length >= 3) return initials.substring(0, 3);
  return key.replaceAll('_', '').toUpperCase().substring(0, 3);
}

class StandingsChart extends StatelessWidget {
  const StandingsChart({
    required this.chart,
    required this.onStartComparison,
    required this.constructors,
    super.key,
  });

  final ChartState chart;
  final VoidCallback onStartComparison;
  final bool constructors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasSelection = switch (chart) {
      ChartSelecting(:final selectedEntryIds) => selectedEntryIds.isNotEmpty,
      _ => false,
    };

    final infoWidgets = <Widget>[
      Icon(
        Icons.show_chart,
        size: 42,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
      ),
      Text('Standings evolution chart', style: theme.textTheme.titleMedium),
    ];
    final children = <Widget>[];

    switch (chart) {
      case ChartDownloading(:final downloadedRounds):
        children.addAll([
          ...infoWidgets,
          const SizedBox(height: 25),
          const Padding(
            padding: .symmetric(horizontal: 16),
            child: LinearProgressIndicator(minHeight: 6),
          ),
          Text(
            'Downloading standings history\n$downloadedRounds rounds loaded...',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ]);

      case ChartSelecting(:final roundStandings, :final selectedEntryIds)
          when selectedEntryIds.isNotEmpty:
        children.addAll([
          Expanded(
            child: Padding(
              padding: const .fromLTRB(8, 8, 8, 0),
              child: _ComparisonChart(
                roundStandings: roundStandings,
                selectedEntryIds: selectedEntryIds,
                constructors: constructors,
              ),
            ),
          ),
          Text(
            '${selectedEntryIds.length} ${_ComparisonCopy.selected}',
            style: theme.textTheme.bodySmall,
          ),
        ]);

      case ChartSelecting():
        children.addAll([
          ...infoWidgets,
          Text(_ComparisonCopy.instruction, style: theme.textTheme.bodyMedium),
        ]);

      default:
        children.addAll([
          ...infoWidgets,
          FilledButton(
            onPressed: onStartComparison,
            child: const Text(_ComparisonCopy.start),
          ),
        ]);
    }

    return Container(
      width: .infinity,
      height: hasSelection ? 300 : 220,
      margin: const .fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: .circular(12),
        border: .all(color: theme.colorScheme.outline),
      ),
      child: Column(
        mainAxisAlignment: .center,
        spacing: 8,
        children: children,
      ),
    );
  }
}

class _ComparisonChart extends StatelessWidget {
  const _ComparisonChart({
    required this.roundStandings,
    required this.selectedEntryIds,
    required this.constructors,
  });

  final List<DriverRoundStanding> roundStandings;
  final Set<String> selectedEntryIds;
  final bool constructors;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(selectedEntryIds),
      duration: const Duration(seconds: 1, milliseconds: 500),
      tween: Tween(begin: 0, end: 1),
      builder: (context, progress, _) {
        return CustomPaint(
          painter: _ComparisonChartPainter(
            roundStandings: roundStandings,
            selectedEntryIds: selectedEntryIds,
            constructors: constructors,
            progress: progress,
            colorScheme: Theme.of(context).colorScheme,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _ComparisonChartPainter extends CustomPainter {
  _ComparisonChartPainter({
    required this.roundStandings,
    required this.selectedEntryIds,
    required this.constructors,
    required this.progress,
    required this.colorScheme,
  });

  final List<DriverRoundStanding> roundStandings;
  final Set<String> selectedEntryIds;
  final bool constructors;
  final double progress;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final rounds = roundStandings.map((entry) => entry.round).toSet().toList()..sort();
    if (rounds.isEmpty) return;

    final chartWidth = (size.width - 50).clamp(0.0, size.width);
    final maxRound = rounds.last;

    // Build each selected entry's aggregated per-round series first — for
    // constructors this is the sum of both drivers' points, which is what
    // actually gets plotted, so the Y scale must be derived from it too.
    final series = <String, Map<int, double>>{};
    final constructorIdOf = <String, String>{};
    final codeOf = <String, String>{};

    for (final id in selectedEntryIds) {
      final entries =
          roundStandings
              .where((entry) => (constructors ? entry.constructorId : entry.driverId) == id)
              .toList()
            ..sort((a, b) => a.round.compareTo(b.round));
      if (entries.isEmpty) continue;

      final pointsByRound = <int, double>{};
      for (final entry in entries) {
        pointsByRound.update(
          entry.round,
          (points) => constructors ? points + entry.points : entry.points,
          ifAbsent: () => entry.points,
        );
      }
      series[id] = pointsByRound;
      constructorIdOf[id] = entries.last.constructorId;
      codeOf[id] = constructors
          ? _constructorCode(entries.last.constructorId)
          : entries.last.driverCode;
    }

    final maxPoints = series.values
        .expand((pointsByRound) => pointsByRound.values)
        .fold<double>(0, (max, points) => points > max ? points : max);
    final pointScale = maxPoints <= 0 ? 1.0 : maxPoints;

    final gridPaint = Paint()
      ..color = colorScheme.onSurface.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    for (var i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(chartWidth, y), gridPaint);
    }

    canvas.drawLine(Offset.zero, Offset(0, size.height), gridPaint);
    canvas.drawLine(Offset(0, size.height), Offset(chartWidth, size.height), gridPaint);

    final dottedPaint = Paint()
      ..color = colorScheme.onSurface.withValues(alpha: 0.18)
      ..strokeWidth = 1;
    for (final round in rounds) {
      final x = round / maxRound * chartWidth;
      for (var y = 0.0; y < size.height; y += 8) {
        canvas.drawLine(Offset(x, y), Offset(x, y + 4), dottedPaint);
      }
    }

    // Reveal only the data lines from left to right as progress advances
    // (0 → 1); the axis grid and round markers stay fixed.
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width * progress, size.height));

    for (final id in series.keys) {
      final pointsByRound = series[id]!;

      Offset? lastPoint;
      final path = Path()..moveTo(0, size.height);
      for (final pointEntry in pointsByRound.entries) {
        final x = pointEntry.key / maxRound * chartWidth;
        final y = size.height - (pointEntry.value / pointScale).clamp(0.0, 1.0) * size.height;
        final point = Offset(x, y);
        lastPoint = point;
        path.lineTo(point.dx, point.dy);
      }

      final linePaint = Paint()
        ..color = AppTheme.teamColor(constructorIdOf[id]!)
        ..style = .stroke
        ..strokeWidth = 2.5
        ..strokeCap = .round;
      canvas.drawPath(path, linePaint);

      if (lastPoint != null) {
        final totalPoints = pointsByRound.values.last;
        final label = '${totalPoints.toStringAsFixed(0)} ${codeOf[id]}';
        final textPainter = TextPainter(
          text: TextSpan(
            text: label,
            style: TextStyle(
              color: linePaint.color,
              fontSize: 10,
              fontWeight: .w700,
            ),
          ),
          textDirection: .ltr,
        )..layout(maxWidth: 70);
        textPainter.paint(
          canvas,
          Offset(
            chartWidth + 6,
            (lastPoint.dy - textPainter.height / 2).clamp(
              0.0,
              size.height - textPainter.height,
            ),
          ),
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_ComparisonChartPainter oldDelegate) =>
      oldDelegate.roundStandings != roundStandings ||
      oldDelegate.selectedEntryIds != selectedEntryIds ||
      oldDelegate.progress != progress;
}
