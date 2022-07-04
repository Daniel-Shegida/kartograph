import 'package:json_annotation/json_annotation.dart';

part 'places_filter_request_dto.g.dart';

/// класс запроса на сервер для dto
@JsonSerializable()
class PlacesFilterRequestDto {
  /// широта места
  final double lat;

  /// долгота места
  final double lng;

  /// радиус в котором стоит искать места
  final double radius;

  /// типы мест
  final List<String> typeFilter;

  /// фильтр по имени места
  final String nameFilter;

  /// полный конструктор ответа с сервера
  PlacesFilterRequestDto({
    required this.lat,
    required this.lng,
    required this.radius,
    required this.typeFilter,
    required this.nameFilter,
  });

  /// сгенерированная функция получающая [PlacesFilterRequestDto] c json
  factory PlacesFilterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PlacesFilterRequestDtoFromJson(json);

  /// сгенерированная функция создающая [PlacesFilterRequestDto] json для сервера
  Map<String, dynamic> toJson() => _$PlacesFilterRequestDtoToJson(this);
}
