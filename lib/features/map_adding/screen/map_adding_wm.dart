
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_model.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_screen.dart';

/// Builder for [MapAddingWidgetModel]
MapAddingWidgetModel mapAddingWidgetModelFactory(BuildContext context) {
  return MapAddingWidgetModel(MapAddingModel());
}

/// WidgetModel for [MapAddingScreen]
class MapAddingWidgetModel extends WidgetModel<MapAddingScreen, MapAddingModel> with SingleTickerProviderWidgetModelMixin
    implements IMapAddingWidgetModel  {

  /// standard consctructor for elem
  MapAddingWidgetModel(MapAddingModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Interface of [MapAddingWidgetModel].
abstract class IMapAddingWidgetModel extends IWidgetModel {
}
