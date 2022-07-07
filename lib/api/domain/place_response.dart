import 'package:json_annotation/json_annotation.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/assets/enums/categories.dart';

part 'place_response.g.dart';

/// класс ответа с сервера
@JsonSerializable()
class PlaceResponse {
  /// id места на сервере
  final int id;

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
  PlaceResponse({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  /// сгенерированная функция получающая [PlaceResponse] c json
  factory PlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseFromJson(json);

  /// сгенерированная функция создающая [PlaceResponse] json для сервера
  Map<String, dynamic> toJson() => _$PlaceResponseToJson(this);
}

/// функция трансформирующая ответ с сервера под конкретную реализацию места
Place mapResponseToPlace(PlaceResponse response) => Place(
      id: response.id,
      lat: response.lat,
      lng: response.lng,
      name: response.name,
      urls: response.urls,
      placeType: Categories.values.byName(response.placeType),
      description: response.description,
    );
