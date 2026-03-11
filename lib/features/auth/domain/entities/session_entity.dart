import 'package:hoxton_task/features/auth/domain/entities/user_entity.dart';

class SessionEntity {
  const SessionEntity({
    required this.user,
    required this.accessToken,
    required this.expiresIn,
  });

  final UserEntity user;
  final String accessToken;
  final int expiresIn;
}

