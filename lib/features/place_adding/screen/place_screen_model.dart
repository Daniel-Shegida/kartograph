import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/api/data/place_response.dart';
import 'package:kartograph/features/places/place_api/place_api.dart';
import 'package:kartograph/features/places/service/place_rep.dart';

/// Model of PlaceAddingWidgetModel
class PlaceAddingModel extends ElementaryModel {
  final PlaceRepository _rep = PlaceRepository(
    RestClient(
      Dio(),
    ),
  );

  /// метод для создания места.
  void postPlace(Place place) {
    // для создания уникального id который был бы еще и положительным
    final id = ((place.lng! + place.lat!) * 1000000).toInt().abs();
    _rep.postPlace(
      PlaceResponse(
        id: id,
        name: place.name ?? 'name',
        description: place.description ?? 'descr',
        placeType: place.placeType.name,
        urls: [],
        lng: place.lng ?? 0,
        lat: place.lat ?? 0,
      ),
    );
  }

  /// метод для изменения места.
  void putPlace(Place place) {
    _rep.putPlace(
      place.id.toString(),
      PlaceResponse(
        id: place.id!,
        name: place.name ?? 'name',
        description: place.description ?? 'descr',
        placeType: place.placeType.name,
        urls: [],
        lng: place.lng ?? 0,
        lat: place.lat ?? 0,
      ),
    );
  }
}
