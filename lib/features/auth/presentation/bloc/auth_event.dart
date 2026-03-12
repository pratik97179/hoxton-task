part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSubmitted extends AuthEvent {
  const AuthSubmitted({
    required this.email,
    required this.password,
    required this.isSignIn,
  });

  final String email;
  final String password;
  final bool isSignIn;

  @override
  List<Object?> get props => [email, password, isSignIn];
}

