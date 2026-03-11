import 'package:dio/dio.dart';

import 'package:hoxton_task/core/logger/app_logger.dart';

/// Logs every API request and response using the common [AppLogger].
class ApiLoggerInterceptor extends Interceptor {
  ApiLoggerInterceptor([AppLogger? logger]) : _logger = logger ?? appLogger;

  final AppLogger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d(
      '→ ${options.method} ${options.uri}',
      data: options.data != null ? options.data : options.queryParameters,
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.i(
      '← ${response.statusCode} ${response.requestOptions.uri}',
      data: response.data,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    _logger.e(
      '← ${response?.statusCode ?? 'ERR'} ${err.requestOptions.uri}',
      error: err.message,
      data: response?.data,
    );
    handler.next(err);
  }
}
