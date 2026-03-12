import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hoxton_task/core/network/api_exception.dart';
import 'package:hoxton_task/core/session/session_manager.dart';
import 'package:hoxton_task/features/auth/domain/usecases/login_with_email_password.dart';
import 'package:hoxton_task/features/auth/domain/usecases/register_with_email_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._login,
    this._register,
    this._sessionManager,
  ) : super(const AuthInitial()) {
    on<AuthSubmitted>(_onAuthSubmitted);
  }

  final LoginWithEmailPassword _login;
  final RegisterWithEmailPassword _register;
  final SessionManager _sessionManager;

  Future<void> _onAuthSubmitted(
    AuthSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      if (event.isSignIn) {
        final session = await _login(
          email: event.email,
          password: event.password,
        );
        await _sessionManager.save(session);
        emit(const AuthSuccess(isSignIn: true));
      } else {
        final session = await _register(
          email: event.email,
          password: event.password,
        );
        await _sessionManager.save(session);
        emit(AuthSuccess(isSignIn: false, email: event.email));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (_) {
      emit(
        const AuthFailure(
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}

