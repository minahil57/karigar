class AppValidators {
  /// EMAIL VALIDATION
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  /// PASSWORD VALIDATION
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Include at least one lowercase letter";
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Include at least one number";
    }

    return null;
  }

  /// OPTIONAL: STRONG PASSWORD CHECK
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    final strongRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
    );

    if (!strongRegex.hasMatch(value)) {
      return "Password must be 8+ chars with A-Z, a-z, number & symbol";
    }
    return null;
  }

  /// NAME VALIDATION
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    if (value.trim().length < 2) {
      return "Name is too short";
    }
    return null;
  }

  /// PHONE VALIDATION
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    final phoneRegex = RegExp(r"^\+?[0-9]{10,15}$");
    if (!phoneRegex.hasMatch(value.trim())) {
      return "Enter a valid phone number";
    }
    return null;
  }

  /// CONFIRM PASSWORD VALIDATION
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }
}
