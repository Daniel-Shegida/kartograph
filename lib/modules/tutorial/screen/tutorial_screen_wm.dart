import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'tutorial_screen.dart';
import 'tutorial_screen_model.dart';

/// Builder for [TutorialWidgetModel]
TutorialWidgetModel specialWidgetModelFactory(BuildContext context) {
  return TutorialWidgetModel(TutorialModel());
}

/// WidgetModel for [TutorialScreen]
class TutorialWidgetModel extends WidgetModel<TutorialScreen, TutorialModel> with SingleTickerProviderWidgetModelMixin
    implements ITutorialWidgetModel  {
  TutorialWidgetModel(TutorialModel model) : super(model);

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

/// Interface of [TutorialWidgetModel].
abstract class ITutorialWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get factState;
  /// а вдруш понадобится
  AnimationController get controller;
  /// action for [floatingActionButton]
  Future<void> start();
}
