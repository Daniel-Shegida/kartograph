import 'package:kartograph/assets/strings/projectStrings.dart';

/// темы проекта
enum Themes {
  /// темная тема
  dark(ProjectStrings.darkTheme, true),

  /// светлая тема
  light(ProjectStrings.lightTheme, false);

  /// имя темы
  final String themeName;

  /// ологическое состояние темы
  final bool condition;

  /// конструктор [Themes]
  const Themes(this.themeName, this.condition);
}
