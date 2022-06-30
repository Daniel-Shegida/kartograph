import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/api/domain/place_dto.dart';
import 'package:kartograph/api/domain/place_response.dart';
import 'package:kartograph/api/domain/places_filter_request_dto.dart';
import 'package:kartograph/api/service/place_api/place_api.dart';

///  репозиторий экрана мест
class PlaceRepository {
  final PlaceApi _placeRepositoryApi;

  /// конструктор репозитория экрана меси
  PlaceRepository(this._placeRepositoryApi);

  // /// Получает место с сервера по id
  // Future<Place> getPlace(String placeId) async {
  //   final placeResponse = await _placeRepositoryApi.getPlace(placeId);
  //
  //   return mapResponseToPlace(placeResponse);
  // }
  //
  // /// удаляет место с сервера по id
  // Future<void> deletePlace(String placeId) async {
  //   await _placeRepositoryApi.deletePlace(placeId);
  // }

  /// заменяет место на сервере по id
  Future<Place> putPlace(String placeId, PlaceResponse body) async {
    final placeResponse = await _placeRepositoryApi.putPlace(placeId, body);

    return mapResponseToPlace(placeResponse);
  }

  /// создает новое место на сервере
  Future<void> postPlace(PlaceResponse body) async {
    await _placeRepositoryApi.postPlace(body);
  }

  // /// получает список мест с сервера
  // Future<List<Place>> getPlaces(int amount) async {
  //   final testResponses = await _placeRepositoryApi.getPlaces(amount);
  //
  //   return testResponses.map(mapResponseToPlace).toList();
  // }

  /// получает список мест с сервера по фильтру
  Future<List<Place>> getSearchedPlaces(
    double lat,
    double lng,
    double radius,
    List<String> typeFilter,
    String nameFilter,
  ) async {
    final test = PlacesFilterRequestDto(
      lat: lat,
      lng: lng,
      radius: radius,
      typeFilter: typeFilter,
      nameFilter: nameFilter,
    );
    final testResponses = await _placeRepositoryApi.getFilteredPlaces(test);

    return testResponses.map(mapDtoResponseToPlace).toList();
  }
}
