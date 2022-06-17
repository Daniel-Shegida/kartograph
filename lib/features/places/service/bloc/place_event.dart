import 'package:equatable/equatable.dart';

/// Базовое событие места.
abstract class BasePlaceEvent extends Equatable{

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
