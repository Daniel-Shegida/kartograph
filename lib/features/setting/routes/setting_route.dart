import 'package:flutter/material.dart';
import 'package:kartograph/features/setting/screen/setting_screen.dart';

/// Роут экрана [SettingScreen]
class SettingScreenRoute extends MaterialPage<SettingScreen> {
  /// конструктор MaterialPage экрана [SettingScreen]
  const SettingScreenRoute()
      : super(
          child: const SettingScreen(),
        );
}
