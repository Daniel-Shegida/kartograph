import 'package:flutter/material.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';

/// темы проекта
enum Categories {
  /// отель
  hotel(ProjectStrings.hotel, Colors.blue),

  /// рестаран
  restaurant(ProjectStrings.restaurant, Colors.red),

  /// другое
  other(ProjectStrings.other, Colors.grey),

  /// кафе
  cafe(ProjectStrings.cafe, Colors.deepOrangeAccent),

  /// музей
  museum(ProjectStrings.museum, Colors.orange),

  /// парк
  park(ProjectStrings.park, Colors.green);

  /// имя категории
  final String categoryName;

  /// цвет категории
  final Color categoryColor;

  /// конструктор [Categories]
  const Categories(
      this.categoryName,
      this.categoryColor,
      );
}