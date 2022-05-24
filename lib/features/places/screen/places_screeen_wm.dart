// Builder for [SpecialWidgetModel]
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/places/screen/places_screeen_model.dart';
import 'package:kartograph/features/places/screen/places_screen.dart';


PlacesWidgetModel placesWidgetModelFactory(BuildContext context) {
  return PlacesWidgetModel(PlacesModel());
}

/// WidgetModel for [PlacesScreen]
class PlacesWidgetModel extends WidgetModel<PlacesScreen, PlacesModel> with SingleTickerProviderWidgetModelMixin
    implements IPlacesWidgetModel  {

  /// standard consctructor for elem
  PlacesWidgetModel(PlacesModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Interface of [PlacesWidgetModel].
abstract class IPlacesWidgetModel extends IWidgetModel {
}
