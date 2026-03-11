import 'package:flutter/foundation.dart';

import 'package:hoxton_task/core/di/injection.dart';
import 'package:hoxton_task/core/network/api_exception.dart';
import 'package:hoxton_task/core/session/session_manager.dart';
import 'package:hoxton_task/features/auth/domain/usecases/login_with_email_password.dart';
import 'package:hoxton_task/features/auth/domain/usecases/register_with_email_password.dart';

sealed class AuthFlowResult {
  const AuthFlowResult();
}

class AuthFlowSuccess extends AuthFlowResult {
  const AuthFlowSuccess({required this.isSignIn, this.email});

  final bool isSignIn;
  final String? email;
}

class AuthFlowFailure extends AuthFlowResult {
  const AuthFlowFailure({required this.message});

  final String message;
}

class AuthFlowController {
  AuthFlowController()
      : _login = sl<LoginWithEmailPassword>(),
        _register = sl<RegisterWithEmailPassword>(),
        _sessionManager = sl<SessionManager>();

  final LoginWithEmailPassword _login;
  final RegisterWithEmailPassword _register;
  final SessionManager _sessionManager;

  final ValueNotifier<bool> isSubmitting = ValueNotifier(false);

  /// [isSignIn] true = login, false = register. Returns [AuthFlowSuccess] or [AuthFlowFailure].
  Future<AuthFlowResult> submit({
    required String email,
    required String password,
    required bool isSignIn,
  }) async {
    isSubmitting.value = true;
    try {
      if (isSignIn) {
        final session =
            await _login(email: email, password: password);
        await _sessionManager.save(session);
        return const AuthFlowSuccess(isSignIn: true, email: null);
      } else {
        final session =
            await _register(email: email, password: password);
        await _sessionManager.save(session);
        return AuthFlowSuccess(isSignIn: false, email: email);
      }
    } on ApiException catch (e) {
      return AuthFlowFailure(message: e.message);
    } catch (_) {
      return const AuthFlowFailure(
        message: 'Something went wrong. Please try again.',
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void dispose() {
    isSubmitting.dispose();
  }
}
