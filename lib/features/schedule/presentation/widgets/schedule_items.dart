import '../../domain/entities/race.dart';

// ---------------------------------------------------------------------------
// Month grouping
// ---------------------------------------------------------------------------

/// Discriminated union for the flat list of items rendered by the schedule list.
sealed class ScheduleItem {}

class MonthHeader extends ScheduleItem {
  MonthHeader(this.label);
  final String label;
}

class RaceItem extends ScheduleItem {
  RaceItem(this.race);
  final Race race;
}

/// Splits [races] into month headers + race items.
List<ScheduleItem> groupByMonth(List<Race> races) {
  final items = <ScheduleItem>[];
  int? lastMonth;

  for (final race in races) {
    final month = race.raceDateTime.month;
    if (month != lastMonth) {
      items.add(MonthHeader(monthNames[month - 1]));
      lastMonth = month;
    }
    items.add(RaceItem(race));
  }

  return items;
}

const monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
