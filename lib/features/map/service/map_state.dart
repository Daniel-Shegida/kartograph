import 'package:equatable/equatable.dart';
import 'package:latlng/latlng.dart';

/// Base state for profile.
abstract class BaseMapState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Состояние карты с информацией о ней
class MapContentState extends BaseMapState {
  /// координаты текущего расположения
  final LatLng currentLocation;

  @override
  List<Object> get props => [];
  /// конструктор состояния карты при получении координат
  MapContentState({
    required this.currentLocation,
  });
}

/// Состояние загрузки данных для карты.
class LoadingState extends BaseMapState {


  @override
  List<Object> get props => [];
}
