import 'package:kartograph/assets/enums/categories.dart';

/// класс места на картах и в списке
class Place {
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
  Categories placeType;

  /// описание места
  String? description;

  /// полный конструктор места
  Place({
    required this.placeType,
    this.id,
    this.lat,
    this.lng,
    this.name,
    this.urls,
    this.description,
  });
}
