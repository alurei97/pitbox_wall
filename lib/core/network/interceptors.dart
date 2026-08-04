import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Prints a compact one-line log per request/response.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('→ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint('← ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('✗ ${err.type} ${err.requestOptions.uri}');
    handler.next(err);
  }
}

/// Retries requests that fail with HTTP 429 (rate limit) up to [maxRetries]
/// times, waiting [baseDelay] doubling on each attempt.
class RateLimitRetryInterceptor extends Interceptor {
  final Dio _dio;
  final int maxRetries;
  final Duration baseDelay;

  static const _retryKey = 'retryCount';

  RateLimitRetryInterceptor(
    this._dio, {
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 1),
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 429) {
      return handler.next(err);
    }
    final retryCount = err.requestOptions.extra[_retryKey] as int? ?? 0;
    if (retryCount >= maxRetries) {
      return handler.next(err);
    }
    err.requestOptions.extra[_retryKey] = retryCount + 1;
    await Future<void>.delayed(baseDelay * (retryCount + 1));
    try {
      final response = await _dio.fetch<dynamic>(err.requestOptions);
      return handler.resolve(response);
    } on DioException catch (retryErr) {
      return handler.next(retryErr);
    }
  }
}
