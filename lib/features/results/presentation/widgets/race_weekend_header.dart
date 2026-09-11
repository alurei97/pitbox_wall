import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../schedule/domain/entities/race.dart';
import '../../../../shared/utils/flags.dart';
import '../../../../shared/widgets/status_chip.dart';

class RaceWeekendHeader extends StatelessWidget {
  const RaceWeekendHeader({
    required this.race,
    required this.status,
    required this.sessionCount,
    super.key,
  });

  final Race race;
  final RaceStatus status;
  final int sessionCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final grayColor = theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Text(
              'Round ${race.round}',
              style: textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: .w700,
              ),
            ),
            const SizedBox(width: 8),
            AppStatusChip(
              label: status.label,
              color: Color(int.parse('FF${status.hexColor}', radix: 16)),
            ),
          ],
        ),

        Text(
          race.raceName,
          style: textTheme.headlineLarge,
        ),

        Row(
          mainAxisSize: .min,
          children: [
            Text(
              '${flagEmojiForCountry(race.country) ?? ''} ${race.circuitName} · ${race.country}',
              style: textTheme.bodyMedium?.copyWith(color: grayColor),
            ),
            Tooltip(
              message: 'Open circuit in Google Maps',
              child: IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.location_on_outlined, size: 20),
                color: grayColor,
                onPressed: () => _openCircuitMap(race),
              ),
            ),
          ],
        ),

        if (_trackAsset(race.circuitId) != null) _TrackLayout(circuitId: race.circuitId!),
      ],
    );
  }
}

Future<void> _openCircuitMap(Race race) async {
  final latitude = race.latitude;
  final longitude = race.longitude;
  if (latitude == null || longitude == null) return;
  final query = Uri.encodeComponent('${race.circuitName} $latitude,$longitude');
  await launchUrl(
    Uri.parse('https://www.google.com/maps/search/?api=1&query=$query'),
    mode: LaunchMode.externalApplication,
  );
}

String? _trackAsset(String? circuitId) {
  const assets = {
    'albert_park': 'albert_park',
    'americas': 'americas',
    'bahrain': 'bahrain',
    'baku': 'baku',
    'catalunya': 'catalunya',
    'hungaroring': 'hungaroring',
    'interlagos': 'interlagos',
    'jeddah': 'jeddah',
    'losail': 'losail',
    'marina_bay': 'marina_bay',
    'miami': 'miami',
    'monaco': 'monaco',
    'monza': 'monza',
    'red_bull_ring': 'red_bull_ring',
    'rodriguez': 'rodriguez',
    'shanghai': 'shanghai',
    'silverstone': 'silverstone',
    'spa': 'spa',
    'suzuka': 'suzuka',
    'vegas': 'vegas',
    'villeneuve': 'villeneuve',
    'yas_marina': 'yas_marina',
    'zandvoort': 'zandvoort',
  };
  return assets[circuitId];
}

class _TrackLayout extends StatelessWidget {
  const _TrackLayout({required this.circuitId});
  final String circuitId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 120,
      child: SvgPicture.asset(
        'assets/tracks/${_trackAsset(circuitId)}.svg',
        fit: BoxFit.contain,
        colorFilter: .mode(theme.colorScheme.primary, .srcIn),
        semanticsLabel: 'Circuit track layout',
      ),
    );
  }
}
