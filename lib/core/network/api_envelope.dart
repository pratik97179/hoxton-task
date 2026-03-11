import 'package:hoxton_task/core/network/api_exception.dart';

Object? unwrap(
  Map<String, dynamic>? body, {
  int? statusCode,
}) {
  if (body == null) {
    throw ApiException('Empty response from server', statusCode: statusCode);
  }

  final success = body['success'] as bool?;
  if (success != true) {
    final message = body['message'] ?? body['error'];
    final text = message is String && message.isNotEmpty
        ? message
        : 'Request failed';
    throw ApiException(text, statusCode: statusCode, data: body);
  }

  return body['data'];
}
