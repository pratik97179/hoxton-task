import 'package:hoxton_task/features/auth/data/models/user_model.dart';
import 'package:hoxton_task/features/auth/domain/entities/session_entity.dart';

class AuthResponseModel {
  const AuthResponseModel({
    required this.user,
    required this.accessToken,
    required this.expiresIn,
  });

  final UserModel user;
  final String accessToken;
  final int expiresIn;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
    );
  }

  SessionEntity toDomain() {
    return SessionEntity(
      user: user.toDomain(),
      accessToken: accessToken,
      expiresIn: expiresIn,
    );
  }
}
