import 'package:hoxton_task/features/auth/domain/entities/session_entity.dart';

abstract class AuthRepository {
  Future<bool> checkEmailExists(String email);

  Future<SessionEntity> register({
    required String email,
    required String password,
  });

  Future<SessionEntity> login({
    required String email,
    required String password,
  });
}

