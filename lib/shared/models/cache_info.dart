/// Metadata about a cache operation, carried alongside business data.
///
/// Every screen that uses the Drift cache can surface this info through
/// [CacheInfoBanner] so we can visually verify TTL behaviour.
class CacheInfo {
  const CacheInfo({
    required this.fromCache,
    required this.responseTimeMs,
    required this.fetchedAt,
    this.ttlSeconds,
  });

  /// True when the data came from a fresh cache read (no network call).
  final bool fromCache;

  /// Wall-clock time of the repository call (cache read or network round-trip).
  final int responseTimeMs;

  /// When the data was originally fetched from the API (stored in `CacheEntries.fetchedAt`).
  /// For a fresh API call this is approximately "now".
  final DateTime fetchedAt;

  /// Cache TTL in seconds. `null` = cached forever (e.g. historical results).
  final int? ttlSeconds;

  /// Human-readable time remaining until the cache entry goes stale.
  /// Returns null when the TTL is null (forever).
  String? get expiresIn {
    if (ttlSeconds == null) return null;
    final expiresAt = fetchedAt.add(Duration(seconds: ttlSeconds!));
    final remaining = expiresAt.difference(DateTime.now());
    if (remaining.isNegative) return 'stale';
    return _formatDuration(remaining);
  }

  /// Human-readable age since the data was fetched.
  String get age => _formatDuration(DateTime.now().difference(fetchedAt));

  static String _formatDuration(Duration d) {
    if (d.inDays > 0) return '${d.inDays}d ${d.inHours % 24}h';
    if (d.inHours > 0) return '${d.inHours}h ${d.inMinutes % 60}m';
    if (d.inMinutes > 0) return '${d.inMinutes}m ${d.inSeconds % 60}s';
    return '${d.inSeconds}s';
  }
}
