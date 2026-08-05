import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/models/cache_info.dart';
import '../../../../shared/widgets/cache_info_banner.dart';
import '../../domain/entities/race.dart';
import '../cubit/schedule_cubit.dart';
import 'race_card.dart';
import 'race_status.dart';
import 'schedule_items.dart';

/// Displays the season schedule grouped by month.
/// "YYYY Season" and the cache banner are fixed at the top;
/// the race list scrolls beneath them.
class ScheduleLoadedView extends StatefulWidget {
  const ScheduleLoadedView({
    required this.races,
    required this.cache,
    super.key,
  });

  final List<Race> races;
  final CacheInfo cache;

  @override
  State<ScheduleLoadedView> createState() => _ScheduleLoadedViewState();
}

class _ScheduleLoadedViewState extends State<ScheduleLoadedView> {
  final _scrollController = ScrollController();
  final _nextRaceKey = GlobalKey();
  bool _scrolledToNext = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToNext());
  }

  /// Scrolls to the first non-finished race.
  /// Phase 1: rough scroll to bring the item into the build window.
  /// Phase 2: Scrollable.ensureVisible positions it exactly at the top.
  void _scrollToNext() {
    if (_scrolledToNext || !_scrollController.hasClients) return;

    final now = DateTime.now();
    final items = groupByMonth(widget.races);
    final nextIndex = items.indexWhere(
      (item) => item is RaceItem && item.race.statusAt(now) != RaceStatus.past,
    );

    if (nextIndex <= 0) {
      _scrolledToNext = true;
      return; // already at the top or all races past
    }

    // Phase 1: rough scroll to bring the item into the build window.
    _scrollController.jumpTo((nextIndex * 80).toDouble());

    // Phase 2: after the frame builds the item, use the GlobalKey for exact top alignment.
    _scrolledToNext = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _nextRaceKey.currentContext;
      if (ctx == null) return;
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        alignment: 0.0, // align to the top of the viewport
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      ).then((_) {
        // Nudge up ~50px so the month header above is partially visible.
        if (!_scrollController.hasClients) return;
        final target = _scrollController.offset - 50;
        _scrollController.animateTo(
          target < 0 ? 0 : target,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final items = groupByMonth(widget.races);
    final now = DateTime.now();
    final chips = chipsFor(widget.races, now);
    final seasonYear = widget.races.isNotEmpty
        ? widget.races.first.raceDateTime.toLocal().year
        : DateTime.now().year;

    // Find the first non-finished race round so we can attach the scroll key.
    final nextRound = widget.races
        .where((r) => r.statusAt(now) != RaceStatus.past)
        .firstOrNull
        ?.round;

    return Column(
      children: [
        // ── Fixed at the top ──
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: Align(
            alignment: .centerLeft,
            child: Text(
              '$seasonYear Season',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: .w800,
              ),
            ),
          ),
        ),
        CacheInfoBanner(cache: widget.cache),

        // ── Scrollable: month sections + race cards ──
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => context.read<ScheduleCubit>().load(forceRefresh: true),
            child: ListView.builder(
              controller: _scrollController,
              padding: const .all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return switch (item) {
                  MonthHeader(:final label) => Padding(
                    padding: const .all(0),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w700,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  RaceItem(:final race) => RaceCard(
                    key: race.round == nextRound ? _nextRaceKey : null,
                    race: race,
                    chip: chips[race.round],
                    // Divider only between two races
                    showDivider: index + 1 < items.length && items[index + 1] is RaceItem,
                    onTap: () => context.push('/race/${race.round}', extra: race),
                  ),
                };
              },
            ),
          ),
        ),
      ],
    );
  }
}
