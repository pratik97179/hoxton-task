import '../utils/password_validation.dart';

extension StringValidationExtension on String {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _numberRegex = RegExp(r'\d');
  static final RegExp _specialCharRegex =
      RegExp(r'[!#@\$%^&*(),.?":{}|<>_\-+=\\\/\[\];]');
  static final RegExp _upperCaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowerCaseRegex = RegExp(r'[a-z]');

  bool get isValidEmail => _emailRegex.hasMatch(this);

  PasswordValidationStatus get passwordValidationStatus {
    final value = this;
    return PasswordValidationStatus(
      hasValidLength: value.length >= 8 && value.length <= 16,
      hasNumber: _numberRegex.hasMatch(value),
      hasSpecialChar: _specialCharRegex.hasMatch(value),
      hasUppercase: _upperCaseRegex.hasMatch(value),
      hasLowercase: _lowerCaseRegex.hasMatch(value),
    );
  }

  bool get isValidPassword => passwordValidationStatus.isValid;
}

