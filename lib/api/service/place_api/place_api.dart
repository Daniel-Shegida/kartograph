import 'package:dio/dio.dart';
import 'package:kartograph/api/domain/place_dto.dart';
import 'package:kartograph/api/domain/place_response.dart';
import 'package:kartograph/api/domain/places_filter_request_dto.dart';
import 'package:kartograph/assets/strings/urls.dart';
import 'package:retrofit/retrofit.dart';

part 'place_api.g.dart';

/// апи со всеми функциями для обработки мест
@RestApi(baseUrl: baseUrl)
abstract class PlaceApi {
  /// фабрика для ретрофита
  factory PlaceApi(Dio dio, {String baseUrl}) = _RestClient;

  /// создает новое место на сервере
  @POST(PlaceUrls.place)
  Future<void> postPlace(
    @Body() PlaceResponse body,
  );

  /// заменяет место на сервере по id
  @PUT('${PlaceUrls.place}/{id}')
  Future<PlaceResponse> putPlace(
    @Path('id') String id,
    @Body() PlaceResponse body,
  );

  /// получает список мест с сервера по фильтру
  @POST(PlaceUrls.filteredPlaces)
  Future<List<PlaceDto>> getFilteredPlaces(
    @Body() PlacesFilterRequestDto body,
  );
}
