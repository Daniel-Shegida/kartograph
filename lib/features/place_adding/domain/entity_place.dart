import 'package:kartograph/assets/enums/categories.dart';

class EntityPlace {
  /// id места на сервере
  int? id;

  /// широта места
  double? lat;

  /// долгота места
  double? lng;

  /// название места
  String? name;

  /// urls картинок места
  List<String>? urls;

  /// тип места
  Categories? placeType;

  /// описание места
  String? description;

  /// стандартный конструктор
  EntityPlace({
    this.placeType,
    this.id,
    this.lat,
    this.lng,
    this.name,
    this.urls,
    this.description,
  });
}