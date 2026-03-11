import 'package:flutter/foundation.dart';

import 'package:hoxton_task/core/di/injection.dart';
import 'package:hoxton_task/core/extensions/string_validation_extension.dart';
import 'package:hoxton_task/core/network/api_exception.dart';
import 'package:hoxton_task/features/auth/domain/repositories/auth_repository.dart';

/// Result of checking whether an email exists. UI uses this to navigate or show error.
sealed class EmailCheckResult {
  const EmailCheckResult();
}

class EmailCheckSuccess extends EmailCheckResult {
  const EmailCheckSuccess({required this.userExists});

  final bool userExists;
}

class EmailCheckFailure extends EmailCheckResult {
  const EmailCheckFailure({required this.message});

  final String message;
}

/// Holds email validation and check state; runs check via [AuthRepository].
/// No BuildContext or navigation; page uses [EmailCheckResult] to push or show SnackBar.
class EmailEntryController {
  EmailEntryController() : _authRepo = sl<AuthRepository>();

  final AuthRepository _authRepo;

  final ValueNotifier<bool> isEmailValid = ValueNotifier(false);
  final ValueNotifier<bool> isChecking = ValueNotifier(false);

  void validateEmail(String email) {
    isEmailValid.value = email.isValidEmail;
  }

  /// Returns [EmailCheckSuccess] with [userExists] or [EmailCheckFailure] with message.
  Future<EmailCheckResult> checkEmail(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || !trimmed.isValidEmail) {
      return const EmailCheckFailure(message: 'Please enter a valid email.');
    }

    isChecking.value = true;
    try {
      final userExists = await _authRepo.checkEmailExists(trimmed);
      return EmailCheckSuccess(userExists: userExists);
    } on ApiException catch (e) {
      return EmailCheckFailure(message: e.message);
    } catch (_) {
      return const EmailCheckFailure(
        message: 'Something went wrong. Please try again.',
      );
    } finally {
      isChecking.value = false;
    }
  }

  void dispose() {
    isEmailValid.dispose();
    isChecking.dispose();
  }
}
