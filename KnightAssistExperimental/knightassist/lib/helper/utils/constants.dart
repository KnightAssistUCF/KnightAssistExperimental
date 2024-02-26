import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class Constants {
  const Constants._();

  static const Color primaryColor = Color(0xFF1e6316);

  static const Color greenColor = Colors.green;

  static const Color redColor = Color(0xFFed0000);

  static const Color starsColor = Color(0xFFffbf00);

  static const Color darkSkeletonColor = Color(0xFF656565);

  static const Color lightSkeletonColor = Colors.grey;

  static const Gradient buttonGradientGreen =
      LinearGradient(colors: [primaryColor, greenColor]);

  static const Gradient buttonGradientGrey =
      LinearGradient(colors: [textGreyColor, scaffoldGreyColor]);

  static const Color buttonGreyColor = Color(0xFF1c1c1c);

  static const Color scaffoldColor = Color(0xFF141414);

  static const Color scaffoldGreyColor = Color(0xFF2b2b2b);

  static const Color textGreyColor = Color(0xFF949494);

  static const Color textWhite80Color = Color(0xFFf2f2f2);

  static const Color barrierColor = Colors.black87;

  static const Color barrierColorLight = Color(0xBF000000);

  static TextStyle latoFont = GoogleFonts.lato().copyWith(color: Colors.black);

  static TextStyle poppinsFont = GoogleFonts.poppins().copyWith(
    color: textWhite80Color,
  );

  static TextStyle robotoFont = GoogleFonts.roboto();

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  static const double bottomInsets = 65;

  static const double bottomInsetsLow = 48;

  /// The regular expression for validating emails in the app.
  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+",
  );

  /// The regular expression for validating credit card expiry in the app.
  static final RegExp otpDigitRegex = RegExp('^[0-9]{1}\$');

  /// The error message for invalid email input.
  static const invalidEmailError = 'Please enter a valid email address';

  /// The error message for empty email input.
  static const emptyEmailInputError = 'Please enter an email';

  /// The error message for empty password input.
  static const emptyPasswordInputError = 'Please enter a password';

  /// The error message for invalid confirm password input.
  static const invalidConfirmPwError = "Passwords don't match";

  /// The error message for invalid current password input.
  static const invalidCurrentPwError = 'Invalid current password!';

  /// The error message for invalid new password input.
  static const invalidNewPwError = "Current and new password can't be same";

  static T? toNull<T>(Object? _) => null;
}
