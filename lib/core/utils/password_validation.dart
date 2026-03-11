class PasswordValidationStatus {
  final bool hasValidLength;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool hasUppercase;
  final bool hasLowercase;

  const PasswordValidationStatus({
    required this.hasValidLength,
    required this.hasNumber,
    required this.hasSpecialChar,
    required this.hasUppercase,
    required this.hasLowercase,
  });

  const PasswordValidationStatus.empty()
      : hasValidLength = false,
        hasNumber = false,
        hasSpecialChar = false,
        hasUppercase = false,
        hasLowercase = false;

  bool get isValid =>
      hasValidLength &&
      hasNumber &&
      hasSpecialChar &&
      hasUppercase &&
      hasLowercase;
}

