import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Generic cache table — every API response stored here as JSON.
class CacheEntries extends Table {
  TextColumn get key => text()();
  TextColumn get jsonData => text()();
  DateTimeColumn get fetchedAt => dateTime()();
  IntColumn get ttlSeconds => integer().nullable()(); // null = cache forever

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [CacheEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'pitbox_wall.db'));

  @override
  int get schemaVersion => 1;

  /// Returns a non-stale entry for [key], or null when missing or stale.
  Future<CacheEntry?> getFresh(String key) async {
    final row = await (select(cacheEntries)..where((t) => t.key.equals(key))).getSingleOrNull();
    if (row == null) return null;
    if (row.ttlSeconds == null) return row; // forever → always fresh
    final age = DateTime.now().difference(row.fetchedAt).inSeconds;
    return age > row.ttlSeconds! ? null : row;
  }

  Future<void> upsert(String key, String json, {int? ttlSeconds}) =>
      into(cacheEntries).insertOnConflictUpdate(
        CacheEntriesCompanion.insert(
          key: key,
          jsonData: json,
          fetchedAt: DateTime.now(),
          ttlSeconds: Value(ttlSeconds),
        ),
      );
}

/// TTL constants for the generic cache.
class CacheTTL {
  static const int? forever = null; // completed race results, historical standings per round
  static const int week = 604800; // driver/team metadata
  static const int day = 86400; // season schedule, session times
  static const int hour = 3600; // current standings
  static const int halfHour = 1800; // active race weekend
}
