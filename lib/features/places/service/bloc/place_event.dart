/// Basic map event.
abstract class BasePlaceEvent  {

}


/// map load event.
class PlaceLoadEvent extends BasePlaceEvent {}

/// map load event.
class PlaceSearchEvent extends BasePlaceEvent {
  final List<String> list;
  PlaceSearchEvent({required this.list});
}
