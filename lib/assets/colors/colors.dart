import 'package:flutter/material.dart';

//ignore_for_file: public_member_api_docs
//
// /// Semantic aliases.
// /// Replenished as needed.
// /// Use only the main palette.
/// Цвета картографа
abstract class ProjectColors {
  // Палитра Темной темы
  static const Color darkThemeActiveGreenColor = _brightgreen;
  static const Color mainDarkTheme = _blackBlue;
  static const Color mainDarkThemeDark = _blackBlackBlue;
  static const Color secondaryDarkTheme = _blueDark;
  static const Color secondary2DarkTheme = _blueligth;

  // Палитра Светлой темы
  static const Color lightThemeActiveGreenColor = _green;
  static const Color mainLightTheme = _greyBlue;
  static const Color mainLightThemeDark = _lightGrey;
  static const Color secondaryLightTheme = _blueDark;
  static const Color secondary2LightTheme = _blueligth;

  // Универсальная палитра
  static const Color white = _white;
  static const Color hintColor = _black54;

// Main palette (https://www.figma.com/file/Bzz1tcNFWc28YHlm2CRmbd/дизайн-ver-0.1?node-id=237%3A1514);
  static const Color _black54 = Colors.black54;
  static const Color _greyBlue = Color(0xFF252849);
  static const Color _blackBlue = Color(0xFF21222C);
  static const Color _blackBlackBlue = Color(0xFF1A1A20);
  static const Color _blueDark = Color(0xFF3B3E5B);
  static const Color _blueligth = Color(0xFF7C7E92);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _lightGrey = Color(0xFFF5F5F5);
  static const Color _green = Color(0xFF4CAF50);
  static const Color _brightgreen = Color(0xFF71D675);
}
