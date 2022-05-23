
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/modules/map/screen/map_screen_model.dart';

import 'map_screen.dart';

/// Builder for [MapWidgetModel]
MapWidgetModel mapWidgetModelFactory(BuildContext context) {
  return MapWidgetModel(MapModel());
}

/// WidgetModel for [MapScreen]
class MapWidgetModel extends WidgetModel<MapScreen, MapModel>
    implements IMapWidgetModel {

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
