import 'package:kartograph/api/data/place.dart';

/// Базовое состояние места.
abstract class BasePlaceState {}

/// Иницилизирующие состояние места.
class InitPlaceContentState extends BasePlaceState {}

/// Состояние поиска мест.
class PlaceContentState extends BasePlaceState {
  /// список найденных мест
  final List<Place> list;

  /// конструктор [PlaceContentState]
  PlaceContentState({required this.list});
}
