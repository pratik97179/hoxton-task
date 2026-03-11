import 'dart:developer' as developer;

class AppLogger {
  AppLogger([this.name = 'App']);

  final String name;

  void _log(
    String level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    dynamic data,
  }) {
    final prefix = '[$name][$level]';
    final body = data != null ? '$message $data' : message;
    developer.log(
      body,
      name: prefix,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void d(String message, {dynamic data}) {
    _log('D', message, data: data);
  }

  void i(String message, {dynamic data}) {
    _log('I', message, data: data);
  }

  void w(String message, {Object? error, dynamic data}) {
    _log('W', message, error: error, data: data);
  }

  void e(String message, {Object? error, StackTrace? stackTrace, dynamic data}) {
    _log('E', message, error: error, stackTrace: stackTrace, data: data);
  }
}

final appLogger = AppLogger('API');
