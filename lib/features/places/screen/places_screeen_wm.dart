// Builder for [SpecialWidgetModel]
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/features/places/screen/places_screeen_model.dart';
import 'package:kartograph/features/places/screen/places_screen.dart';

PlacesWidgetModel placesWidgetModelFactory(BuildContext context) {
  return PlacesWidgetModel(PlacesModel());
}

/// WidgetModel for [PlacesScreen]
class PlacesWidgetModel extends WidgetModel<PlacesScreen, PlacesModel>
    with SingleTickerProviderWidgetModelMixin
    implements IPlacesWidgetModel {
  final StateNotifier<List<Place>> _places = StateNotifier<List<Place>>();

  @override
  StateNotifier<List<Place>> get places => _places;

  /// standard consctructor for elem
  PlacesWidgetModel(PlacesModel model) : super(model);

  @override
  void initWidgetModel() {
    _places.accept([
      Place(
          lng: 2,
          id: 1,
          urls: [],
          name: 'sadasd',
          description: '',
          placeType: '',
          lat: 2,),
    ]);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Interface of [PlacesWidgetModel].
abstract class IPlacesWidgetModel extends IWidgetModel {
  /// показываемые темы
  StateNotifier<List<Place>> get places;
}
