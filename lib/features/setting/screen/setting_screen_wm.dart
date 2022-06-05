import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/setting/screen/setting_screen.dart';
import 'package:kartograph/features/setting/screen/setting_screen_model.dart';

/// Builder for [SettingWidgetModel]
SettingWidgetModel settingWidgetModelFactory(BuildContext context) {
  return SettingWidgetModel(SettingModel());
}

/// WidgetModel for [SettingScreen]
class SettingWidgetModel extends WidgetModel<SettingScreen, SettingModel>
    with SingleTickerProviderWidgetModelMixin
    implements ISettingWidgetModel {
  final _themeNotifier = StateNotifier<bool>();

  @override
  String get currentTheme => _currentTheme;

  @override
  StateNotifier<bool> get themeNotifier => _themeNotifier;

  String _currentTheme = ProjectStrings.lightTheme;

  /// standard consctructor for elem
  SettingWidgetModel(SettingModel model) : super(model);

  @override
  void initWidgetModel() {
    _themeNotifier.accept(false);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onThemeTap(bool switchFlag) {
    _themeNotifier.accept(switchFlag);
    if (_themeNotifier.value ?? false) {
      _currentTheme = ProjectStrings.darkTheme;
    } else {
      _currentTheme = ProjectStrings.lightTheme;
    }
  }

  @override
  void onTutorialTap() {}
}

/// Interface of [SettingWidgetModel].
abstract class ISettingWidgetModel extends IWidgetModel {
  /// уведомитель флага темы
  StateNotifier<bool> get themeNotifier;

  /// текущая тема
  String get currentTheme;

  /// метод свитчера карточки темы
  // ignore: avoid_positional_boolean_parameters
  void onThemeTap(bool switchFlag);

  /// метод карточки туториала
  void onTutorialTap();
}
