import 'package:flutter/material.dart';

import '../../domain/entities/qualifying_result.dart' show QualifyingResult;

class QualifyingResultsTable extends StatelessWidget {
  const QualifyingResultsTable({super.key, required this.results, required this.stage});

  final List<QualifyingResult> results;
  final int stage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(12),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ..._rows(context),
        ],
      ),
    );
  }

  List<Widget> _rows(BuildContext context) {
    final displayed = results.where((result) => _timeForStage(result) != null).toList()
      ..sort((a, b) => a.position.compareTo(b.position));
    if (displayed.isEmpty) return const [];
    final sessionDrivers = displayed.where(_setTimeInSelectedSession).toList(growable: false);
    final reference = sessionDrivers.isEmpty
        ? 0.0
        : sessionDrivers.map((r) => _parseTime(_sessionTime(r)!)).reduce((a, b) => a < b ? a : b);
    final q3Count = displayed.where((result) => result.q3 != null).length;

    return [
      for (var index = 0; index < displayed.length; index++) ...[
        _row(context, displayed[index], reference, _setTimeInSelectedSession(displayed[index])),
        if (_shouldShowDivider(index, displayed, q3Count))
          Divider(
            height: 16,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .4),
          ),
      ],
    ];
  }

  Widget _row(
    BuildContext context,
    QualifyingResult result,
    double reference,
    bool setSessionTime,
  ) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      textColor: eliminatedColor(context, setSessionTime),
      leading: Text(
        'P${result.position}',
        style: theme.textTheme.titleMedium?.copyWith(
          color: eliminatedColor(context, setSessionTime),
        ),
      ),
      title: Text(
        '${result.givenName} ${result.familyName}',
        style: theme.textTheme.bodySmall?.copyWith(color: eliminatedColor(context, setSessionTime)),
      ),
      subtitle: Text(
        result.constructorName,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: .4),
        ),
      ),
      trailing: Row(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        crossAxisAlignment: .end,
        children: [
          setSessionTime
              ? Text(
                  _formatDelta(_parseTime(_sessionTime(result)!) - reference),
                  style: Theme.of(context).textTheme.labelSmall,
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 12),
          Text(_timeForStage(result)!),
        ],
      ),
    );
  }

  Color? eliminatedColor(BuildContext context, bool setSessionTime) => setSessionTime
      ? Theme.of(context).colorScheme.onSurface
      : Theme.of(context).colorScheme.onSurface.withValues(alpha: .4);

  bool _shouldShowDivider(int index, List<QualifyingResult> results, int q3Count) {
    if (stage == 3) return false;
    if (stage == 1) return index == results.length - 7;
    return index == q3Count - 1;
  }

  bool _setTimeInSelectedSession(QualifyingResult result) => _sessionTime(result) != null;

  String? _sessionTime(QualifyingResult result) => switch (stage) {
    1 => result.q1,
    2 => result.q2,
    _ => result.q3,
  };

  String? _timeForStage(QualifyingResult result) => switch (stage) {
    1 => result.q1,
    2 => result.q2 ?? result.q1,
    _ => result.q3 ?? result.q2 ?? result.q1,
  };

  double _parseTime(String value) {
    final parts = value.split(':');
    if (parts.length != 2) return double.infinity;
    final minutes = double.tryParse(parts[0]);
    final seconds = double.tryParse(parts[1]);
    if (minutes == null || seconds == null) return double.infinity;
    return minutes * 60 + seconds;
  }

  String _formatDelta(double delta) {
    if (delta <= 0.0005) return '-';
    final minutes = delta ~/ 60;
    final seconds = delta - minutes * 60;
    return '+${minutes > 0 ? '$minutes:' : ''}${seconds.toStringAsFixed(3)}';
  }
}
