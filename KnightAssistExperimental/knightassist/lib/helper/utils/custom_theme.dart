import 'package:flutter/material.dart';

import 'constants.dart';

@immutable
class CustomTheme {
  const CustomTheme._();

  static late final mainTheme = ThemeData(
    primaryColor: Constants.primaryColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Constants.primaryColor,
      secondary: Constants.primaryColor,
    ),
    scaffoldBackgroundColor: Constants.scaffoldColor,
    // fontFamily and textTheme here
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
