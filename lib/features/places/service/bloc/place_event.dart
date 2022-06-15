/// Базовое событие места.
abstract class BasePlaceEvent {}

/// Событие поиска мест.
class PlaceSearchEvent extends BasePlaceEvent {
  /// типы мест, которые будут отображены в поиске
  final List<String> searchingTypeList;

  /// строка, что будет в месте
  final String search;

  /// конструктор [PlaceSearchEvent]
  PlaceSearchEvent({required this.searchingTypeList, required this.search});
}
