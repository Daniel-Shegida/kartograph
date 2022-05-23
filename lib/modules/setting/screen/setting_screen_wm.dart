import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'setting_screen.dart';
import 'setting_screen_model.dart';

/// Builder for [SettingWidgetModel]
SettingWidgetModel settingWidgetModelFactory(BuildContext context) {
  return SettingWidgetModel(SettingModel());
}

/// WidgetModel for [SettingScreen]
class SettingWidgetModel extends WidgetModel<SettingScreen, SettingModel> with SingleTickerProviderWidgetModelMixin
    implements ISettingWidgetModel  {
  SettingWidgetModel(SettingModel model) : super(model);

  late final EntityStateNotifier<String> _factState;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  ListenableState<EntityState<String>> get factState => _factState;

  @override
  AnimationController get controller => _controller;

  @override
  Future<void> start() async {}

  @override
  void initWidgetModel() {
    _factState = EntityStateNotifier<String>.value('Strings.initFact');
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _factState.dispose();
    super.dispose();
  }
}

/// Interface of [SettingWidgetModel].
abstract class ISettingWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get factState;
  /// а вдруш понадобится
  AnimationController get controller;
  /// action for [floatingActionButton]
  Future<void> start();
}
