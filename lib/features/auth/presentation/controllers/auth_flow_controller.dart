import 'package:flutter/foundation.dart';

import 'package:hoxton_task/core/di/injection.dart';
import 'package:hoxton_task/core/network/api_exception.dart';
import 'package:hoxton_task/features/auth/domain/usecases/login_with_email_password.dart';
import 'package:hoxton_task/features/auth/domain/usecases/register_with_email_password.dart';

/// Result of auth submit (login or register). UI uses this to navigate or show error.
sealed class AuthFlowResult {
  const AuthFlowResult();
}

class AuthFlowSuccess extends AuthFlowResult {
  const AuthFlowSuccess({required this.isSignIn, this.email});

  /// True if login (go home), false if register (go pre-boarding with email).
  final bool isSignIn;
  /// Set when isSignIn is false (register) for pre-boarding route.
  final String? email;
}

class AuthFlowFailure extends AuthFlowResult {
  const AuthFlowFailure({required this.message});

  final String message;
}

/// Runs login or register via use cases; exposes [isSubmitting]. No context or navigation.
class AuthFlowController {
  AuthFlowController()
      : _login = sl<LoginWithEmailPassword>(),
        _register = sl<RegisterWithEmailPassword>();

  final LoginWithEmailPassword _login;
  final RegisterWithEmailPassword _register;

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
        await _login(email: email, password: password);
        return const AuthFlowSuccess(isSignIn: true, email: null);
      } else {
        await _register(email: email, password: password);
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
