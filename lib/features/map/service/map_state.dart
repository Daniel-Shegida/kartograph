import 'package:equatable/equatable.dart';
import 'package:latlng/latlng.dart';

/// Base state for profile.
abstract class BaseMapState{
}

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
class LoadingState extends BaseMapState {
}
