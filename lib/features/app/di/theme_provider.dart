import 'package:flutter/material.dart';
import 'package:kartograph/features/setting/domain/themes.dart';

/// DI для передачи состояния темы в materialApp
class ThemeProvider extends ChangeNotifier {
  /// текущее состояние темы
  ThemeMode themeMode = ThemeMode.system;

  /// изменение текущего состоянии темы
  /// true -> change to darkTheme
  /// false -> change to lightTheme
  void changeThemeMode(Themes currentTheme) {
    themeMode = currentTheme.mode;

    notifyListeners();
  }
}
