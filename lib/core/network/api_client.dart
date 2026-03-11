import 'package:dio/dio.dart';

import 'package:hoxton_task/core/network/api_exception.dart';

class ApiClient {
  ApiClient({
    required Dio dio,
    String? baseUrl,
  }) : _dio = dio {
    if (baseUrl != null && baseUrl.isNotEmpty) {
      _dio.options.baseUrl = baseUrl;
    }
  }

  final Dio _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (error) {
      throw _toApiException(error);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (error) {
      throw _toApiException(error);
    }
  }

  ApiException _toApiException(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    String message = 'Request failed';

    if (data is Map<String, dynamic>) {
      final dynamic errorMessage = data['message'] ?? data['error'];
      if (errorMessage is String && errorMessage.isNotEmpty) {
        message = errorMessage;
      }
    } else if (data is String && data.isNotEmpty) {
      message = data;
    } else if (error.message != null && error.message!.isNotEmpty) {
      message = error.message!;
    }

    return ApiException(
      message,
      statusCode: statusCode,
      data: data,
    );
  }
}

