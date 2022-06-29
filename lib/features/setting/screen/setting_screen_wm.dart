import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/setting/domain/themes.dart';
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
  final _themeNotifier = StateNotifier<Themes>();

  @override
  StateNotifier<Themes> get themeNotifier => _themeNotifier;

  /// standard consctructor for elem
  SettingWidgetModel(SettingModel model) : super(model);

  @override
  void initWidgetModel() {
    _themeNotifier.accept(Themes.light);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onChangedTheme(bool switchFlag) {
    if (switchFlag) {
      _themeNotifier.accept(Themes.dark);
    } else {
      _themeNotifier.accept(Themes.light);
    }
  }

  @override
  void onTutorialTap() {}
}

/// Interface of [SettingWidgetModel].
abstract class ISettingWidgetModel extends IWidgetModel {
  /// уведомитель флага темы
  StateNotifier<Themes> get themeNotifier;

  /// метод свитчера карточки темы
  // ignore: avoid_positional_boolean_parameters
  void onChangedTheme(bool switchFlag);

  /// метод карточки туториала
  void onTutorialTap();
}
