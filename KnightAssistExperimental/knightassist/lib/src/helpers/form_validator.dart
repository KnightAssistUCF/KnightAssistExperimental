import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Helpers
import 'extensions/string_extension.dart';

/// A utility class that holds methods for validating different textFields.
/// This class has no constructor and all methods are `static`.
@immutable
class FormValidator {
  const FormValidator._();

  /// The error message for invalid email input.
  static const _invalidEmailError = 'Please enter a valid email address';

  /// The error message for empty email input.
  static const _emptyEmailInputError = 'Please enter an email';

  /// The error message for empty password input.
  static const _emptyPasswordInputError = 'Please enter a password';

  /// The error message if the two passwords do not match.
  static const _invalidConfirmPwError = 'Passwords do not match';

  /// The error message for invalid current password input.
  static const _invalidCurrentPwError = 'Invalid current password!';

  /// The error message for invalid new password input.
  static const _invalidNewPwError = "Current and new password can't be same";

  /// The error message for invalid name input.
  static const _invalidNameError = 'Please enter a valid name';

  /// The error message for invalid contact input.
  static const _invalidContactError = 'Please enter a valid contact';

  /// The error message for invalid identification input.
  static const _invalidIdError = 'Please enter a valid identification';

  static const _invalidDefaultError = 'Please enter a valid input';

  /// A method containing validation logic for email input.
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return _emptyEmailInputError;
    } else if (!email.isValidEmail) {
      return _invalidEmailError;
    }
    return null;
  }

  /// A method containing validation logic for password input.
  static String? passwordValidator(String? password) {
    if (password!.isEmpty) return _emptyPasswordInputError;
    return null;
  }

  /// A method containing validation logic for confirm password input.
  static String? confirmPasswordValidator(String? confirmPw, String inputPw) {
    if (confirmPw == inputPw.trim()) return null;
    return _invalidConfirmPwError;
  }

  /// A method containing validation logic for current password input.
  static String? currentPasswordValidator(String? inputPw, String currentPw) {
    if (inputPw == currentPw) return null;
    return _invalidCurrentPwError;
  }

  /// A method containing validation logic for new password input.
  static String? newPasswordValidator(String? newPw, String currentPw) {
    if (newPw!.isEmpty) {
      return _emptyPasswordInputError;
    } else if (newPw == currentPw) {
      return _invalidNewPwError;
    }
    return null;
  }

  /// A method containing validation logic for name input.
  static String? nameValidator(String? name) {
    if (name != null && name.isValidName) return null;
    return _invalidNameError;
  }

  static String? defaultValidator(String? text) {
    if (text != '') return null;
    return _invalidDefaultError;
  }

  /// A method containing validation logic for contact number input.
  static String? contactValidator(String? contact) {
    if (contact != null && contact.isValidContact) return null;
    return _invalidContactError;
  }

  /// A method containing validation logic for identification input.
  static String? idValidator(String? id) {
    if (id != null && id.isValidIdentification) return null;
    return _invalidIdError;
  }
}
