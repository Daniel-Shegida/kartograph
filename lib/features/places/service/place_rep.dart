import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/api/data/place_response.dart';
import 'package:kartograph/features/places/place_api/place_api.dart';

///  репозиторий экрана мест
class PlaceRepository {
  final RestClient _placeRepositoryApi;

  /// конструктор репозитория экрана меси
  PlaceRepository(this._placeRepositoryApi);

  /// Получает место с сервера по id
  Future<Place> getPlace(String placeId) async {
    final placeResponse = await _placeRepositoryApi.getPlace(placeId);

    return mapResponseToPlace(placeResponse);
  }

  /// удаляет место с сервера по id
  Future<void> deletePlace(String placeId) async {
    await _placeRepositoryApi.deletePlace(placeId);
  }

  /// заменяет место на сервере по id
  Future<Place> putPlace(String placeId, PlaceResponse body) async {
    final placeResponse = await _placeRepositoryApi.putPlace(placeId, body);

    return mapResponseToPlace(placeResponse);
  }

  /// создает новое место на сервере
  Future<void> postPlace(PlaceResponse body) async {
    await _placeRepositoryApi.postPlace(body);
  }

  /// получает список мест с сервера
  Future<List<Place>> getPlaces(int amount) async {
    final testResponses = await _placeRepositoryApi.getPlaces(amount);

    return testResponses.map(mapResponseToPlace).toList();
  }
}