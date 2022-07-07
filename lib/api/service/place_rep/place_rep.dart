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

  /// заменяет место на сервере по id
  Future<Place> putPlace(String placeId, PlaceResponse body) async {
    final placeResponse = await _placeRepositoryApi.putPlace(placeId, body);

    return mapResponseToPlace(placeResponse);
  }

  /// создает новое место на сервере
  Future<void> postPlace(PlaceResponse body) async {
    await _placeRepositoryApi.postPlace(body);
  }

  /// получает список мест с сервера по фильтру
  Future<List<Place>> getSearchedPlaces(
    double lat,
    double lng,
    double radius,
    List<String> typeFilter,
    String nameFilter,
  ) async {
    final placeDto = PlacesFilterRequestDto(
      lat: lat,
      lng: lng,
      radius: radius,
      typeFilter: typeFilter,
      nameFilter: nameFilter,
    );
    final PlaceResponses =
        await _placeRepositoryApi.getFilteredPlaces(placeDto);

    return PlaceResponses.map(mapDtoResponseToPlace).toList();
  }
}
