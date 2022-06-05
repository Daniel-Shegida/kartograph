import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen.dart';
import 'package:kartograph/features/place_adding/screen/place_screen_model.dart';

PlaceAddingWidgetModel placeAddingWidgetModelFactory(BuildContext context) {
  return PlaceAddingWidgetModel(PlaceAddingModel());
}

/// WidgetModel for [PlaceAddingScreen]
class PlaceAddingWidgetModel extends WidgetModel<PlaceAddingScreen, PlaceAddingModel> with SingleTickerProviderWidgetModelMixin
    implements IPlaceAddingWidgetModel  {

  /// standard consctructor for elem
  PlaceAddingWidgetModel(PlaceAddingModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Interface of [PlaceAddingWidgetModel].
abstract class IPlaceAddingWidgetModel extends IWidgetModel {
}
