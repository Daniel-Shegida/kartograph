import 'package:equatable/equatable.dart';
import 'package:kartograph/api/domain/place.dart';

/// Базовое событие места.
abstract class BasePlaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Событие поиска мест.
class PlaceSearchEvent extends BasePlaceEvent {
  /// типы мест, которые будут отображены в поиске
  final List<String> searchingTypeList;

  /// строка, что будет в месте
  final String search;

  @override
  List<Object?> get props => [searchingTypeList, search];

  /// конструктор [PlaceSearchEvent]
  PlaceSearchEvent({required this.searchingTypeList, required this.search});
}

/// Событие Добавления места на сервер.
class PlacePostEvent extends BasePlaceEvent {
  /// Класс места для добавления на сервер
  final Place place;

  @override
  List<Object?> get props => [place];

  /// конструктор [PlacePostEvent]
  PlacePostEvent({required this.place});
}

/// Событие изменения места на сервере.
class PlacePutEvent extends BasePlaceEvent {
  /// Класс места для добавления на сервер
  final Place place;

  @override
  List<Object?> get props => [place];

  /// конструктор [PlacePutEvent]
  PlacePutEvent({required this.place});
}
