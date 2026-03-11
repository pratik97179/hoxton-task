import 'package:dio/dio.dart';

import 'package:hoxton_task/core/network/api_client.dart';
import 'package:hoxton_task/core/network/api_envelope.dart';
import 'package:hoxton_task/core/network/api_exception.dart';

abstract class HomeRemoteDataSource {
  Future<Map<String, dynamic>> fetchHome({
    required String accessToken,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Map<String, dynamic>> fetchHome({
    required String accessToken,
  }) async {
    final Response<Map<String, dynamic>> response =
        await _apiClient.get<Map<String, dynamic>>(
      '/home',
      options: Options(
        headers: <String, Object>{
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    final payload = unwrap(response.data, statusCode: response.statusCode);
    if (payload is! Map<String, dynamic> || !payload.containsKey('home')) {
      throw const ApiException('Invalid home response');
    }

    final home = payload['home'];
    if (home is! Map<String, dynamic>) {
      throw const ApiException('Invalid home payload');
    }

    return home;
  }
}

