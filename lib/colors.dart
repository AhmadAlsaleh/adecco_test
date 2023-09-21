// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const COLOR_GRAY = Color(0xFF4C4C4C);
  static const COLOR_LIGHT_GRAY = Color.fromARGB(255, 241, 241, 241);
  static const COLOR_RED = Color(0xFFDF1515);
  static const COLOR_BLACK = Color(0xFF0E0E0E);
  static const COLOR_WHITE = Color(0xFFFFFFFF);

  static const MaterialColor colorpalette =
      MaterialColor(_colorpalettePrimaryValue, <int, Color>{
    50: Color(0xFFE6EDF2),
    100: Color(0xFFC0D3E0),
    200: Color(0xFF96B6CB),
    300: Color(0xFF6C98B6),
    400: Color(0xFF4D82A6),
    500: Color(_colorpalettePrimaryValue),
    600: Color(0xFF28648E),
    700: Color(0xFF225983),
    800: Color(0xFF1C4F79),
    900: Color(0xFF113D68),
  });
  static const int _colorpalettePrimaryValue = 0xFF2D6C96;

  static const MaterialColor colorpaletteAccent =
      MaterialColor(_colorpaletteAccentValue, <int, Color>{
    100: Color(0xFF9DCBFF),
    200: Color(_colorpaletteAccentValue),
    400: Color(0xFF3795FF),
    700: Color(0xFF1E87FF),
  });
  static const int _colorpaletteAccentValue = 0xFF6AB0FF;
}
