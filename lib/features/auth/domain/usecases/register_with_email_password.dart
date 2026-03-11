import 'package:hoxton_task/features/auth/domain/entities/session_entity.dart';
import 'package:hoxton_task/features/auth/domain/repositories/auth_repository.dart';

class RegisterWithEmailPassword {
  RegisterWithEmailPassword(this._repository);

  final AuthRepository _repository;

  Future<SessionEntity> call({
    required String email,
    required String password,
  }) {
    return _repository.register(email: email, password: password);
  }
}
