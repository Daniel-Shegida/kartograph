import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';
import 'splash_screen_model.dart';

/// Builder for [SplashWidgetModel]
SplashWidgetModel specialWidgetModelFactory(BuildContext context) {
  return SplashWidgetModel(SplashModel());
}

/// WidgetModel for [SplashScreen]
class SplashWidgetModel extends WidgetModel<SplashScreen, SplashModel> with SingleTickerProviderWidgetModelMixin
    implements ISplashWidgetModel  {
  SplashWidgetModel(SplashModel model) : super(model);

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

/// Interface of [SplashWidgetModel].
abstract class ISplashWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get factState;
  /// а вдруш понадобится
  AnimationController get controller;
  /// action for [floatingActionButton]
  Future<void> start();
}