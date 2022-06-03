import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/setting/screen/setting_screen_wm.dart';


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
      body:  Column(
        children: [
          
        ],
      ),
    );
  }
}

class ThemeChangerCard extends StatelessWidget {
  const ThemeChangerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TutorialWatcherCard extends StatelessWidget {
  const TutorialWatcherCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}