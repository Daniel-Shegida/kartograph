import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/setting/screen/setting_screen_wm.dart';
import 'package:kartograph/features/setting/widgets/cardWidget.dart';

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
        title: const Text(ProjectStrings.settings),
      ),
      body: Column(
        children: [
          StateNotifierBuilder<bool>(
            listenableState: wm.themeNotifier,
            builder: (ctx, value) {
              return _ThemeChangerCard(
                cardName: wm.currentTheme,
                swithFlag: value ?? false,
                switchFunc: wm.onThemeTap,
              );
            },
          ),
          _TutorialWatcherCard(
            helperFunc: wm.onTutorialTap,
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
  final bool swithFlag;

  /// функция переключающая тему
  final Function(bool) switchFunc;

  const _ThemeChangerCard(
      {required this.cardName,
      required this.swithFlag,
      required this.switchFunc,
      Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget.withSwitch(
      cardName: cardName,
      onPressed: () {},
      switchFlag: swithFlag,
      switchFun: switchFunc,
    );
  }
}

class _TutorialWatcherCard extends StatelessWidget {
  /// функция которая активируется при нажатии на иконку
  final Function() helperFunc;

  const _TutorialWatcherCard({required this.helperFunc, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget.withHelper(
      cardName: ProjectStrings.tutorialCard,
      onPressed: () {},
      icon: SvgPicture.asset(
        ProjectIcons.list,
        color: ProjectColors.mainLightTheme,
      ),
      onHelper: helperFunc,
    );
  }
}
