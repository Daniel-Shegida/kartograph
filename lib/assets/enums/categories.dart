import 'package:kartograph/assets/strings/projectStrings.dart';

/// темы проекта
enum Categories {
  /// отель
  hotel(ProjectStrings.hotel),

  /// рестаран
  restaurant(ProjectStrings.restaurant),

  /// другое
  other(ProjectStrings.other),

  /// кафе
  cafe(ProjectStrings.cafe),

  /// музей
  museum(ProjectStrings.museum),

  /// парк
  park(ProjectStrings.park);

  /// имя категории
  final String categoryName;

  /// конструктор [Categories]
  const Categories(
      this.categoryName,
      );
}