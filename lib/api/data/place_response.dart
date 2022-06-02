// Модель темы статьи с сервера
import 'package:json_annotation/json_annotation.dart';
import 'package:kartograph/api/data/place.dart';

part 'place_response.g.dart';

@JsonSerializable()
class PlaceResponse {
  final int id;
  final double lat;
  /// Категория теста
  final double lng;

  /// Прогресс теста
  final String name;

  /// Количество раз прохождения теста
  final List<String>  urls;

  /// Задачи для теста
  final String placeType;

  /// Массив, означающий правильно ли был отправлен ответ на вопрос или нет
  final String description;

  PlaceResponse({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  factory PlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceResponseToJson(this);
}

Place mapResponseToTest(PlaceResponse response) => Place(
  id: response.id,
  lat: response.lat,
  lng: response.lng,
  name: response.name,
  urls: response.urls,
  placeType: response.placeType,
  description: response.description,
);