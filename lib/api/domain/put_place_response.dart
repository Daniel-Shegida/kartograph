import 'package:json_annotation/json_annotation.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/assets/enums/categories.dart';

part 'put_place_response.g.dart';

/// класс ответа с сервера
@JsonSerializable()
class PutPlaceResponse {
  /// широта места
  final double lat;

  /// долгота места
  final double lng;

  /// название места
  final String name;

  /// urls картинок места
  final List<String> urls;

  /// тип места
  final String placeType;

  /// описание места
  final String description;

  /// полный конструктор ответа с сервера
  PutPlaceResponse({
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  /// сгенерированная функция получающая [PutPlaceResponse] c json
  factory PutPlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PutPlaceResponseFromJson(json);

  /// сгенерированная функция создающая [PutPlaceResponse] json для сервера
  Map<String, dynamic> toJson() => _$PutPlaceResponseToJson(this);
}

/// функция трансформирующая ответ с сервера под конкретную реализацию места
Place mapPutResponseToPlace(PutPlaceResponse response) => Place(
      id: 0,
      lat: response.lat,
      lng: response.lng,
      name: response.name,
      urls: response.urls,
      placeType: Categories.values.byName(response.placeType),
      description: response.description,
    );
