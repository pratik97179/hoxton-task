import 'package:dio/dio.dart';

import 'package:hoxton_task/core/network/api_client.dart';
import 'package:hoxton_task/core/network/api_envelope.dart';
import 'package:hoxton_task/core/network/api_exception.dart';
import 'package:hoxton_task/features/auth/data/models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> checkEmailExists(String email);

  Future<AuthResponseModel> register({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<bool> checkEmailExists(String email) async {
    final Response<Map<String, dynamic>> response =
        await _apiClient.post<Map<String, dynamic>>(
      '/auth/check-email',
      data: <String, dynamic>{'email': email},
    );

    final payload = unwrap(response.data, statusCode: response.statusCode);
    if (payload is! Map<String, dynamic> || !payload.containsKey('userExists')) {
      throw const ApiException('Invalid check-email response');
    }
    return payload['userExists'] as bool;
  }

  @override
  Future<AuthResponseModel> register({
    required String email,
    required String password,
  }) async {
    final Response<Map<String, dynamic>> response =
        await _apiClient.post<Map<String, dynamic>>(
      '/auth/register',
      data: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );

    final payload = unwrap(response.data, statusCode: response.statusCode);
    if (payload is! Map<String, dynamic>) {
      throw const ApiException('Invalid register response');
    }
    return AuthResponseModel.fromJson(payload);
  }

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final Response<Map<String, dynamic>> response =
        await _apiClient.post<Map<String, dynamic>>(
      '/auth/login',
      data: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );

    final payload = unwrap(response.data, statusCode: response.statusCode);
    if (payload is! Map<String, dynamic>) {
      throw const ApiException('Invalid login response');
    }
    return AuthResponseModel.fromJson(payload);
  }
}

