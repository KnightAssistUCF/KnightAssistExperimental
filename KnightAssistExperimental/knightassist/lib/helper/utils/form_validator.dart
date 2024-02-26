import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../extensions/string_extension.dart';
import 'constants.dart';

@immutable
class FormValidator {
  const FormValidator._();

  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return Constants.emptyEmailInputError;
    } else if (!email.isValidEmail) {
      return Constants.invalidEmailError;
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password!.isEmpty) return Constants.emptyPasswordInputError;
    return null;
  }

  static String? confirmPasswordValidator(String? confirmPw, String inputPw) {
    if (confirmPw == inputPw.trim()) return null;
    return Constants.invalidConfirmPwError;
  }

  static String? currentPasswordValidator(String? inputPw, String currentPw) {
    if (inputPw == currentPw) return null;
    return Constants.invalidCurrentPwError;
  }

  static String? newPasswordValidator(String? newPw, String currentPw) {
    if (newPw!.isEmpty) {
      return Constants.emptyPasswordInputError;
    } else if (newPw == currentPw) {
      return Constants.invalidNewPwError;
    }
    return null;
  }

  static String? otpDigitValidator(String? digit) {
    if (digit != null && digit.isValidOtpDigit) return null;
    return '!';
  }
}
