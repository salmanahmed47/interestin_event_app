import 'package:flutter/material.dart';

class ColorTheme {
  // primary
  static Color primary = const Color.fromRGBO(1, 117, 97, 1);
  static Color primaryShade1 = const Color.fromARGB(255, 1, 97, 81);
  static Color primaryTint1 = const Color.fromARGB(255, 0, 168, 140);
  static Color primaryDisabled = const Color.fromARGB(255, 1, 117, 97);
  static Color onPrimaryText = Colors.white;

  //secondary color
  static Color secondary = Colors.black;
  static Color onSecondaryText = Colors.white;

  static Color primaryWithOpacity(double opacity) {
    opacity = 255 * opacity;
    return Color.fromARGB(opacity.toInt(), 1, 117, 97);
  }

  static Color secondaryWithOpacity(int opacity) {
    return Color.fromARGB(255, 253, 129, opacity);
  }

  static Color colorWithOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
