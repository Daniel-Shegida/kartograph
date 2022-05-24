
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/map/screen/map_screen.dart';
import 'package:kartograph/features/map/screen/map_screen_model.dart';


/// Builder for [MapWidgetModel]
MapWidgetModel mapWidgetModelFactory(BuildContext context) {
  return MapWidgetModel(MapModel());
}

/// WidgetModel for [MapScreen]
class MapWidgetModel extends WidgetModel<MapScreen, MapModel>
    implements IMapWidgetModel {

  /// standard consctructor for elem
  MapWidgetModel(MapModel model) : super(model);


  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

}

/// Interface of [MapWidgetModel].
abstract class IMapWidgetModel extends IWidgetModel {

}
