import 'package:flutter/material.dart';

import '../models/cache_info.dart';

/// Debug banner that shows cache timing info for any screen.
///
/// Displays whether the data came from cache or a fresh API call,
/// how long the operation took, and the remaining TTL.
class CacheInfoBanner extends StatelessWidget {
  const CacheInfoBanner({required this.cache, super.key});

  final CacheInfo cache;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onPrimary.withValues(alpha: 0.3);

    return Container(
      width: double.infinity,
      padding: const .fromLTRB(16, 0, 16, 5),
      child: Row(
        spacing: 8,
        children: [
          Icon(
            cache.fromCache ? Icons.storage_outlined : Icons.cloud_download_outlined,
            size: 14,
            color: color,
          ),
          Expanded(
            child: Text(
              _buildLabel(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
                fontFamily: 'RobotoMono',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildLabel() {
    final action = cache.fromCache ? 'CACHE' : 'API CALL';
    final time = '${cache.responseTimeMs}ms';
    final ttl = cache.expiresIn;
    final ttlLabel = ttl != null ? ' · ttl $ttl' : ' · no expiry';
    return '$action · $time · age ${cache.age}$ttlLabel';
  }
}
