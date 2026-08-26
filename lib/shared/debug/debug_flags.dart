import 'package:flutter/foundation.dart';

/// Global debug flag: when true, the [CacheInfoBanner] debug banners are
/// rendered on every screen (showing cache vs API call, timing, TTL).
///
/// Toggled by long-pressing the home title.
final ValueNotifier<bool> showCacheInfo = ValueNotifier<bool>(false);
