import 'package:hoxton_task/features/auth/domain/entities/user_entity.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  final String id;
  final String email;
  final String name;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
    );
  }
}

