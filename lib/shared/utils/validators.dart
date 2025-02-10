import 'package:email_validator/email_validator.dart';

class Validators {
  static final RegExp mobileRegExp = RegExp(
    r'^[|0]?(?:50|51|52|55|56|58|2|3|4|6|7|9)\d{7}$',
  );

  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$',
  );

  static final RegExp textRegExp = RegExp(
    r'[a-zA-Z]',
  );

  static bool isTextValid(String text) {
    return textRegExp.allMatches(text).length == text.length;
  }

  static bool isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

  static bool isMobileValid(String mobile, {bool acceptEmpty = false}) {
    return mobile.length == 9 || (acceptEmpty && mobile.isEmpty);
  }

  static bool isPasswordValid(String password) {
    return passwordRegExp.hasMatch(password);
  }

  static bool isEmirateIdValid(String emirateId) {
    return emirateId.length == 18 && (int.tryParse(emirateId.replaceAll("-", "")) != null);
  }
}
