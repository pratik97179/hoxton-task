import 'package:hoxton_task/core/network/api_exception.dart';

/// Backend responses use a standard envelope: `{ success, message, data, error }`.
/// Use [unwrap] once per API response and then use only the returned payload
/// for domain parsing. Do not reimplement this skeleton in response models or
/// data sources.
///
/// Success: `{ success: true, message: string, data: <payload>, error: null }`
/// Failure: `{ success: false, message: string, data: null, error: string }`
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
