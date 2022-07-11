import 'package:flutter/material.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';

/// темы проекта
enum Themes {
  /// темная тема
  dark(ProjectStrings.darkTheme, true, ThemeMode.dark),

  /// светлая тема
  light(ProjectStrings.lightTheme, false, ThemeMode.light);

  /// имя темы
  final String themeName;

  /// логическое состояние темы
  /// передается на свитчер в экране настроек
  final bool condition;

  /// Состояние темы для MaterialApp
  final ThemeMode mode;

  /// конструктор [Themes]
  // ignore: avoid_positional_boolean_parameters
  const Themes(this.themeName, this.condition, this.mode);
}
