import 'package:graduate_front/core/utils/string_extensions.dart';

class FormValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty || !value.isValidEmail) {
      return 'enter a valid email address!';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty || !value.isValidName) {
      return 'enter a valid name!';
    }
    return null;
  }

  static String? birthdayValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter Date of Birth!';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter a password!';
    } else if (value.length < 6) {
      return "password length must be above 6 characters!";
    }
    return null;
  }

  static String? confirmPasswordValidator(String? confirmPw, String inputPw) {
    if (confirmPw == null || confirmPw.isEmpty) {
      return 'enter a valid password!';
    } else if (confirmPw.length < 6) {
      return "password length must be above 6 characters!";
    }
    if (confirmPw != inputPw.trim()) {
      return "passwords don't match!";
    }
    return null;
  }
}
