import 'package:dio/dio.dart';
import 'package:kartograph/api/data/place_response.dart';
import 'package:retrofit/retrofit.dart';

part 'place_api.g.dart';

@RestApi(baseUrl: 'https://test-backend-flutter.surfstudio.ru/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('place')
  Future<List<PlaceResponse>> getPlaces(
    @Query('count') int id,
  );

  //
  // @POST('place')
  // void postPlace(
  //     @Body() PlaceResponse body,
  //     );

  @GET('place/{id}')
  Future<PlaceResponse> getPlace(
    @Path('id') String id,
  );

  @DELETE('place/{id}')
  Future<PlaceResponse> deletePlace(
    @Path('id') String id,
  );

  @GET('place/{id}')
  Future<PlaceResponse> putPlace(
    @Path('id') String id,
    @Body() PlaceResponse body,
  );
}
