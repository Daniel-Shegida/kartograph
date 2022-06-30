import 'package:elementary/elementary.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/api/domain/place_response.dart';
import 'package:kartograph/features/places/service/place_rep.dart';

/// модель PlaceAddingWidgetModel
class PlaceAddingModel extends ElementaryModel {
  late final PlaceRepository _rep;

  /// конструктор[PlaceAddingModel]
  PlaceAddingModel(this._rep);

  /// метод для создания места.
  void postPlace(Place place) {
    // для создания уникального id который был бы еще и положительным
    final id = ((place.lng + place.lat) * 1000000).toInt().abs();
    _rep.postPlace(
      PlaceResponse(
        id: id,
        name: place.name,
        description: place.description,
        placeType: place.placeType.name,
        urls: [],
        lng: place.lng,
        lat: place.lat,
      ),
    );
  }

  /// метод для изменения места.
  void putPlace(Place place) {
    _rep.putPlace(
      place.id.toString(),
      PlaceResponse(
        id: place.id,
        name: place.name,
        description: place.description,
        placeType: place.placeType.name,
        urls: [],
        lng: place.lng,
        lat: place.lat,
      ),
    );
  }
}
