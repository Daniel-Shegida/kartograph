import 'package:flutter/material.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';

/// темы проекта
enum Categories {
  /// отель
  hotel(ProjectStrings.hotel, Colors.blue, Icons.location_on),

  /// рестаран
  restaurant(ProjectStrings.restaurant, Colors.red, Icons.location_on),

  /// другое
  other(ProjectStrings.other, Colors.grey, Icons.location_on),

  /// кафе
  cafe(ProjectStrings.cafe, Colors.deepOrangeAccent, Icons.location_on),

  /// музей
  museum(ProjectStrings.museum, Colors.orange, Icons.location_on),

  /// парк
  park(ProjectStrings.park, Colors.green, Icons.location_on),

  /// добавление места
  newPlace('_', Colors.grey, Icons.add_circle);

  /// имя категории
  final String categoryName;

  /// цвет категории
  final Color categoryColor;

  /// иконка категории
  final IconData categoryIcon;

  /// конструктор [Categories]
  const Categories(
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
  );
}
