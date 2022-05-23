// Builder for [SpecialWidgetModel]
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/modules/places/screen/places_screen.dart';

import 'places_screeen_model.dart';

PlacesWidgetModel placesWidgetModelFactory(BuildContext context) {
  return PlacesWidgetModel(PlacesModel());
}

/// WidgetModel for [PlacesScreen]
class PlacesWidgetModel extends WidgetModel<PlacesScreen, PlacesModel> with SingleTickerProviderWidgetModelMixin
    implements IPlacesWidgetModel  {
  PlacesWidgetModel(PlacesModel model) : super(model);

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

/// Interface of [PlacesWidgetModel].
abstract class IPlacesWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get factState;
  /// а вдруш понадобится
  AnimationController get controller;
  /// action for [floatingActionButton]
  Future<void> start();
}
