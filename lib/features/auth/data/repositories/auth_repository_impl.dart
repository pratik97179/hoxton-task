import 'package:hoxton_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hoxton_task/features/auth/domain/entities/session_entity.dart';
import 'package:hoxton_task/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<bool> checkEmailExists(String email) async {
    return _remoteDataSource.checkEmailExists(email);
  }

  @override
  Future<SessionEntity> register({
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.register(
      email: email,
      password: password,
    );
    return response.toDomain();
  }

  @override
  Future<SessionEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    return response.toDomain();
  }
}
