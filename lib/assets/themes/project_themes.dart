import 'package:flutter/material.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/themes/project_text_style.dart';

/// Темы картогрофа
abstract class ProjectThemes {
  /// Светлая тема проекта
  static ThemeData lightTheme = ThemeData.light().copyWith(
    focusColor: ProjectColors.lightThemeActiveGreenColor,
    textTheme: const TextTheme(
      /// подсказка на карточке
      bodySmall: ProjectTypography.bodySecondaryLight14,

      /// обычный текст и текст на карточках
      titleMedium: ProjectTypography.titleMainLight16,

      /// Кнопки выхода и отмен
      displayMedium: ProjectTypography.displayMainLight16,

      /// Название экранов
      headlineLarge: ProjectTypography.headlineMainLight18,
      headlineMedium: ProjectTypography.headlineMainLight24,

      /// Кнопки создания и принятия
      labelMedium: ProjectTypography.labelLightActive16,
    ),
    primaryColorDark: ProjectColors.mainLightThemeDark,
    hintColor: ProjectColors.hintColor,
    brightness: Brightness.light,
    backgroundColor: ProjectColors.white,
    scaffoldBackgroundColor: ProjectColors.white,
    cardColor: ProjectColors.white,
    primaryIconTheme: const IconThemeData(
      color: ProjectColors.secondaryLightTheme,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ProjectColors.white,
    ),
  );

  /// Темная тема проекта
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    focusColor: ProjectColors.darkThemeActiveGreenColor,
    textTheme: const TextTheme(
      /// подсказка на карточке
      bodySmall: ProjectTypography.bodySecondaryDark16,

      /// обычный текст и текст на карточках
      titleMedium: ProjectTypography.titleWhite16,

      /// Кнопки выхода и отмен
      displayMedium: ProjectTypography.displayWhite16,

      /// Название экранов
      headlineLarge: ProjectTypography.headlineMainLight24,
      headlineMedium: ProjectTypography.headlineWhite18,

      /// Кнопки создания и принятия
      labelMedium: ProjectTypography.labelDarkGreen16,
    ),
    primaryColorDark: ProjectColors.mainDarkThemeDark,
    hintColor: ProjectColors.hintColor,
    brightness: Brightness.dark,
    backgroundColor: ProjectColors.secondaryDarkTheme,
    scaffoldBackgroundColor: ProjectColors.mainDarkTheme,
    cardColor: ProjectColors.mainDarkTheme,
    primaryIconTheme: const IconThemeData(
      color: ProjectColors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ProjectColors.mainDarkTheme,
    ),
  );
}
