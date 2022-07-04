import 'package:json_annotation/json_annotation.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/assets/enums/categories.dart';

part 'place_dto.g.dart';

/// класс ответа dto с сервера
@JsonSerializable()
class PlaceDto {
  /// id места на сервере
  final int id;

  /// широта места
  final double lat;

  /// долгота места
  final double lng;

  /// дистанция до места места
  final double distance;

  /// название места
  final String name;

  /// тип места
  final String placeType;

  /// описание места
  final String description;

  /// urls картинок места
  final List<String> urls;

  /// полный конструктор ответа с сервера
  PlaceDto({
    required this.id,
    required this.lat,
    required this.lng,
    required this.distance,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  /// сгенерированная функция получающая [PlaceDto] c json
  factory PlaceDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDtoFromJson(json);

  /// сгенерированная функция создающая [PlaceDto] json для сервера
  Map<String, dynamic> toJson() => _$PlaceDtoToJson(this);
}

/// функция трансформирующая ответ с сервера под конкретную реализацию места
Place mapDtoResponseToPlace(PlaceDto response) => Place(
  id: response.id,
  lat: response.lat,
  lng: response.lng,
  name: response.name,
  urls: response.urls,
  placeType: Categories.values.byName(response.placeType),
  description: response.description,
);
