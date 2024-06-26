import 'package:flutter/material.dart';

/// A utility class that holds constants for colors used values
/// throughout the entire app.
/// This class has no constructor and all variables are `static`.
@immutable
class AppColors {
  const AppColors._();

  static const List<Color> primaries = [
    Color.fromARGB(249, 195, 91, 255),
    Color.fromARGB(255, 202, 108, 0),
    Color.fromARGB(255, 255, 39, 39),
    Color.fromARGB(255, 255, 132, 17),
    Color.fromARGB(255, 255, 180, 180),
    Color.fromARGB(255, 43, 206, 255),
    Color.fromARGB(255, 194, 255, 27),
    Color.fromARGB(255, 0, 248, 0),
    Colors.tealAccent,
    Color.fromARGB(255, 255, 70, 132),
    secondaryColor,
    Color.fromARGB(255, 0, 150, 236),
  ];

  /// The main color used for theming the app.
  static const Color primaryColor = Color(0xFF006C51);

  /// The color value for red color in the app.
  static const Color redColor = Color(0xFFed0000);

  /// The color value for orange color in the app.
  static const Color orangeColor = Color(0xFFf04f00);

  /// The color value for the light primary color in the app.
  static const Color lightPrimaryColor = Color(0xFF57BD90);

  /// The secondary color used for contrasting
  /// the primary in the app.
  static const Color secondaryColor = Color(0xFF7350BE);

  /// The tertiary blackish color used for contrasting
  /// the secondary in the app.
  static const Color tertiaryColor = Color.fromARGB(255, 43, 43, 43);

  /// The darker greyish color used for background surfaces
  /// of the app like behind scrolling screens or scaffolds etc.
  static const Color backgroundColor = Color.fromARGB(255, 24, 24, 24);

  /// The light greyish color used for container/card surfaces
  /// of the app.
  static const Color surfaceColor = Color(0xFF2b2b2b);

  /// The light greyish color used for filling fields of the app.
  static const Color fieldFillColor = Colors.white;

  /// The color value for rating stars in the app.
  static const Color starsColor = Color.fromARGB(255, 247, 162, 64);

  /// The color value for dark grey skeleton containers in the app.
  static const Color darkSkeletonColor = Color(0xFF656565);

  /// The color value for light grey skeleton containers in the app.
  static const Color lightSkeletonColor = Colors.grey;

  /// The color value for grey borders in the app.
  static const Color greyOutlineColor = Color.fromARGB(255, 207, 207, 207);

  /// The color value for light grey borders in the app.
  static const Color lightOutlineColor = Color.fromARGB(255, 224, 224, 224);

  /// The primary [LinearGradient] for buttons in the app.
  static const Gradient buttonGradientPrimary = LinearGradient(
    colors: [primaryColor, secondaryColor],
  );

  /// The orange [LinearGradient] for disabled buttons in the app.
  static const Gradient buttonGradientGrey = LinearGradient(
    colors: [textGreyColor, surfaceColor],
  );

  /// The orange [LinearGradient] for buttons in the app.
  static const Gradient buttonGradientDanger = LinearGradient(
    colors: [orangeColor, redColor],
  );

  /// The white [LinearGradient] for fading movies carousel in the app.
  static const Gradient movieCarouselGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.3, 0.6, 1],
    colors: [
      Color.fromRGBO(255, 255, 255, 0.95),
      Colors.white70,
      Colors.transparent,
    ],
  );

  /// The black [LinearGradient] used to overlay movie backgrounds in the app.
  static const Gradient blackOverlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.2, 0.5, 0.7, 1],
    colors: [
      Color.fromRGBO(0, 0, 0, 0.6),
      Color.fromRGBO(0, 0, 0, 0.45),
      Color.fromRGBO(0, 0, 0, 0.3),
      Colors.transparent,
    ],
  );

  /// The color value for dark grey buttons in the app.
  static const Color buttonGreyColor = Color(0xFF1c1c1c);

  /// The color value for grey text in the app.
  static const Color textGreyColor = Color.fromARGB(255, 122, 122, 122);

  /// The color value for light grey text in the app.
  static const Color textLightGreyColor = Color.fromARGB(255, 171, 180, 185);

  /// The color value for dark grey text in the app.
  static const Color textBlackColor = Color.fromARGB(255, 43, 43, 43);

  /// The color value for white text in the app.
  static const Color textWhite80Color = Color(0xFFf2f2f2);

  /// The color value for dark grey [CustomDialog] in the app.
  static const Color barrierColor = Colors.black87;

  /// The color value for light grey [CustomDialog] in the app.
  static const Color barrierColorLight = Color(0xBF000000);
}
