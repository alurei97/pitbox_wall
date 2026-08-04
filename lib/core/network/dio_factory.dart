import 'package:dio/dio.dart';

import 'interceptors.dart';

/// Builds the app's Dio clients. Two instances, named in GetIt:
/// - Jolpica (`api.jolpi.ca/ergast/f1/`) — standings, results, schedule
/// - OpenF1 (`api.openf1.org/v1/`) — optional future session/lap/live data
class DioFactory {
  static const jolpicaName = 'jolpica';
  static const openF1Name = 'openf1';

  static const _jolpicaBaseUrl = 'https://api.jolpi.ca/ergast/f1/';
  static const _openF1BaseUrl = 'https://api.openf1.org/v1/';

  Dio jolpica() => _build(_jolpicaBaseUrl);
  Dio openF1() => _build(_openF1BaseUrl);

  Dio _build(String baseUrl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: const {'Accept': 'application/json'},
      ),
    );
    dio.interceptors.addAll([LoggingInterceptor(), RateLimitRetryInterceptor(dio)]);
    return dio;
  }
}
