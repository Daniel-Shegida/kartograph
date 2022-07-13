import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/setting/domain/themes.dart';
import 'package:kartograph/features/setting/screen/setting_screen_wm.dart';

/// экран настроек
class SettingScreen extends ElementaryWidget<ISettingWidgetModel> {
  /// standard consctructor for elem
  const SettingScreen({
    Key? key,
    WidgetModelFactory wmFactory = settingWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISettingWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const _SettingAppBar(),
      ),
      body: Column(
        children: [
          StateNotifierBuilder<Themes>(
            listenableState: wm.themeNotifier,
            builder: (ctx, value) {
              return _ThemeChangerCard(
                cardName: value!.themeName,
                swithValue: value.condition,
                onChanged: wm.onChangedTheme,
              );
            },
          ),
          _TutorialWatcherCard(
            onTap: wm.onTutorialTap,
          ),
        ],
      ),
    );
  }
}

class _ThemeChangerCard extends StatelessWidget {
  /// текущая тема
  final String cardName;

  /// текущий флаг темы
  final bool swithValue;

  /// функция переключающая тему
  final Function(bool) onChanged;

  const _ThemeChangerCard({
    required this.cardName,
    required this.swithValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        title: Text(cardName),
        value: swithValue,
        onChanged: onChanged,
      ),
    );
  }
}

class _TutorialWatcherCard extends StatelessWidget {
  /// функция которая активируется при нажатии на иконку
  final Function() onTap;

  const _TutorialWatcherCard({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text(ProjectStrings.tutorialCard),
        trailing: SvgPicture.asset(
          ProjectIcons.infoIcon,
          color: Theme.of(context).focusColor,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ignore: prefer_mixin
class _SettingAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _SettingAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Center(
        child: Text(
          ProjectStrings.settings,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
