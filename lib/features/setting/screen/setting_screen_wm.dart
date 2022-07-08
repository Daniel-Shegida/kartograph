import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/app/di/theme_provider.dart';
import 'package:kartograph/features/setting/domain/themes.dart';
import 'package:kartograph/features/setting/screen/setting_screen.dart';
import 'package:kartograph/features/setting/screen/setting_screen_model.dart';
import 'package:provider/provider.dart';

/// typedef функции смены темы
typedef ChangeTheme = void Function(Themes currentTheme);

/// Builder for [SettingWidgetModel]
SettingWidgetModel settingWidgetModelFactory(BuildContext context) {
  return SettingWidgetModel(SettingModel());
}

/// WidgetModel for [SettingScreen]
class SettingWidgetModel extends WidgetModel<SettingScreen, SettingModel>
    with SingleTickerProviderWidgetModelMixin
    implements ISettingWidgetModel {
  final _themeNotifier = StateNotifier<Themes>();

  late final ChangeTheme _changeTheme;

  @override
  StateNotifier<Themes> get themeNotifier => _themeNotifier;

  /// standard consctructor for elem
  SettingWidgetModel(SettingModel model) : super(model);

  @override
  void initWidgetModel() {
    _themeNotifier.accept(Themes.light);
    _changeTheme = Provider.of<ThemeProvider>(context).changeThemeMode;
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
      _changeTheme(Themes.dark);
    } else {
      _themeNotifier.accept(Themes.light);
      _changeTheme(Themes.light);
    }
  }

  @override
  void onTutorialTap() {
    _showDialogOfUnready();
  }

  void _showDialogOfUnready() {
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Еще в производстве'),
        content: const Text('будет скоро'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
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
