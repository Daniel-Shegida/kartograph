import 'package:equatable/equatable.dart';
import 'package:kartograph/api/data/place.dart';

/// Базовое состояние места.
abstract class BasePlaceState extends Equatable{

  @override
  List<Object?> get props => [];
}

/// Иницилизирующие состояние места.
class InitPlaceContentState extends BasePlaceState {}

/// Состояние поиска мест.
class PlaceContentState extends BasePlaceState {
  /// список найденных мест
  final List<Place> list;

  @override
  List<Object?> get props => [list];

  /// конструктор [PlaceContentState]
  PlaceContentState({required this.list});
}
