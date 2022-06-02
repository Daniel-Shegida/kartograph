import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/api/data/place_response.dart';
import 'package:kartograph/features/places/place_api/place_api.dart';

///  репозиторий экрана мест
class PlaceRepository {
  final RestClient _placeRepositoryApi;

  /// конструктор репозитория экрана меси
  PlaceRepository(this._placeRepositoryApi);

  /// Получает место с сервера по id
  Future<Place> getTest(String placeId) async {
    final placeResponse = await _placeRepositoryApi.getPlace(placeId);

    return mapResponseToTest(placeResponse);
  }

  /// удаляет место с сервера по id
  void deleteTest(String placeId) async {
    await _placeRepositoryApi.deletePlace(placeId);
  }

  /// заменяет место на сервере
  Future<Place> putTest(String placeId, PlaceResponse body) async {
    final placeResponse = await _placeRepositoryApi.putPlace(placeId, body);

    return mapResponseToTest(placeResponse);
  }

  //
  // /// Получает тест с сервера и маппит в доменные модели
  // Future<PlaceResponse> getTest(String testId) async {
  //   final PlaceResponse testResponse = await _placeRepositoryApi.postPlace(placeId, body);
  //
  //   return testResponse;
  // }

  /// получает список мест с сервера
  Future<List<Place>> getPlaces(int amount) async {
    final testResponses = await _placeRepositoryApi.getPlaces(amount);

    return testResponses.map(mapResponseToTest).toList();
  }
}
