import 'package:flutter/painting.dart';
import 'package:kartograph/assets/colors/colors.dart';

//ignore_for_file: public_member_api_docs

/// TextStyles Проекта картограф
abstract class ProjectTypography {
  /// Светлая тема
  static const TextStyle bodySecondaryLight14 =
      TextStyle(color: ProjectColors.secondaryLightTheme, fontSize: 14);

  static const TextStyle secondaryLight16 =
      TextStyle(color: ProjectColors.secondaryLightTheme, fontSize: 16);

  static const TextStyle titleMainLight16 =
      TextStyle(color: ProjectColors.mainLightTheme, fontSize: 16);

  static const TextStyle displayMainLight16 =
      TextStyle(color: ProjectColors.mainLightTheme, fontSize: 16);

  static const TextStyle headlineMainLight18 =
      TextStyle(color: ProjectColors.mainLightTheme, fontSize: 18);

  static const TextStyle headlineMainLight24 =
      TextStyle(color: ProjectColors.mainLightTheme, fontSize: 24);

  static const TextStyle labelLightActive16 = TextStyle(
    color: ProjectColors.lightThemeActiveGreenColor,
    fontSize: 16,
  );

  /// Темная тема
  static const TextStyle titleWhite16 =
      TextStyle(color: ProjectColors.white, fontSize: 16);

  static const TextStyle displayWhite16 =
      TextStyle(color: ProjectColors.white, fontSize: 16);

  static const TextStyle headlineWhite18 =
      TextStyle(color: ProjectColors.white, fontSize: 18);

  static const TextStyle headlineWhite24 =
      TextStyle(color: ProjectColors.white, fontSize: 24);

  static const TextStyle bodySecondaryDark16 =
      TextStyle(color: ProjectColors.secondary2DarkTheme, fontSize: 14);

  static const TextStyle labelDarkGreen16 = TextStyle(
    color: ProjectColors.darkThemeActiveGreenColor,
    fontSize: 16,
  );
}
