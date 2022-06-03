import 'package:equatable/equatable.dart';
import 'package:latlng/latlng.dart';

/// Base state for profile.
abstract class BaseMapState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Состояние карты и текущего состояния
class MapContentState extends BaseMapState {
  /// координаты текущего расположения
  final LatLng currentLocation;

  /// костыльное решение, чтобы получать геолокацию даже одинаковых состояний
  /// возможно стоит изменить в будущем
  final Kostil = DateTime.now();

  @override
  List<Object> get props => [Kostil];
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
