import 'package:json_annotation/json_annotation.dart';
import 'package:kartograph/api/data/place_responce.dart';
import 'package:kartograph/features/places/place_api/placeDto.dart';
import 'package:kartograph/features/places/place_api/req.dart';
import 'package:kartograph/features/places/place_api/task.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'example.g.dart';

@RestApi(baseUrl: "https://test-backend-flutter.surfstudio.ru/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/place/1")
  Future<PlaceResponse> getTasks();

  @GET("/filtered_places")
  Future<List<PlaceDto>> getPlaces(
      @Body() double lat,
      @Body() double lng,
      @Body() double radius,
      @Body() List<String> typeFilter,
      @Body() String nameFilter,
      );
}

