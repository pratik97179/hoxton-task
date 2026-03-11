import 'password_validation.dart';

class PasswordRequirement {
  final String label;
  final bool isMet;

  const PasswordRequirement({
    required this.label,
    required this.isMet,
  });
}

class PasswordRequirementsPresenter {
  static List<PasswordRequirement> build(PasswordValidationStatus status) {
    return [
      PasswordRequirement(
        label: '8-16 characters only',
        isMet: status.hasValidLength,
      ),
      PasswordRequirement(
        label: 'At least 1 number',
        isMet: status.hasNumber,
      ),
      PasswordRequirement(
        label: 'At least 1 special character like !#@\$',
        isMet: status.hasSpecialChar,
      ),
      PasswordRequirement(
        label: 'At least 1 upper case character',
        isMet: status.hasUppercase,
      ),
      PasswordRequirement(
        label: 'At least 1 lower case character',
        isMet: status.hasLowercase,
      ),
    ];
  }
}

