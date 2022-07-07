import 'package:kartograph/api/domain/place.dart';
import 'package:latlng/latlng.dart';

/// Base state for profile.
abstract class BaseMapState {}

/// Состояние карты и текущего состояния
class MapContentState extends BaseMapState {
  /// координаты текущего расположения
  final LatLng currentLocation;

  /// конструктор состояния карты при получении координат
  MapContentState({
    required this.currentLocation,
  });
}

/// Состояние загрузки данных для карты.
class LoadingState extends BaseMapState {}

/// Состояние поиска мест.
class MapPlacesContentState extends BaseMapState {
  /// список найденных мест
  final List<Place> list;

  /// конструктор [MapPlacesContentState]
  MapPlacesContentState({required this.list});
}
