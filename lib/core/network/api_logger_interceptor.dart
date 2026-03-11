import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:hoxton_task/core/logger/app_logger.dart';

class ApiLoggerInterceptor extends Interceptor {
  ApiLoggerInterceptor([AppLogger? logger]) : _logger = logger ?? appLogger;

  final AppLogger _logger;

  static String _pretty(dynamic data) {
    if (data == null) return 'null';
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      if (data is String) return data;
      return data.toString();
    } catch (_) {
      return data.toString();
    }
  }

  static String _headersSummary(dynamic headers) {
    if (headers == null || (headers is Map && headers.isEmpty)) return '';
    if (headers is! Map) return headers.toString();
    final sanitized = <String, String>{};
    for (final e in headers.entries) {
      final key = e.key.toString().toLowerCase();
      final raw = e.value;
      final value = raw is List ? raw.join(', ') : raw?.toString() ?? '';
      if (key == 'authorization' && value.length > 12) {
        sanitized[e.key.toString()] = '${value.substring(0, 12)}...';
      } else {
        sanitized[e.key.toString()] = value;
      }
    }
    return _pretty(sanitized);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln('┌────────── API REQUEST ──────────');
    buffer.writeln('${options.method} ${options.uri}');
    if (options.headers.isNotEmpty) {
      buffer.writeln('Headers:');
      buffer.writeln(_headersSummary(options.headers));
    }
    if (options.queryParameters.isNotEmpty) {
      buffer.writeln('Query:');
      buffer.writeln(_pretty(options.queryParameters));
    }
    if (options.data != null) {
      buffer.writeln('Body:');
      buffer.writeln(_pretty(options.data));
    }
    buffer.write('└─────────────────────────────────');
    _logger.d(buffer.toString());
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final options = response.requestOptions;
    final buffer = StringBuffer();
    buffer.writeln('┌────────── API RESPONSE ──────────');
    buffer.writeln('${response.statusCode} ${options.method} ${options.uri}');
    buffer.writeln('Body:');
    buffer.writeln(_pretty(response.data));
    buffer.write('└──────────────────────────────────');
    _logger.i(buffer.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final response = err.response;
    final buffer = StringBuffer();
    buffer.writeln('┌────────── API ERROR ──────────');
    buffer.writeln('${response?.statusCode ?? 'ERR'} ${options.method} ${options.uri}');
    buffer.writeln('Message: ${err.message}');
    if (response?.data != null) {
      buffer.writeln('Body:');
      buffer.writeln(_pretty(response!.data));
    }
    buffer.write('└────────────────────────────────');
    _logger.e(buffer.toString(), error: err.error, stackTrace: err.stackTrace);
    handler.next(err);
  }
}
