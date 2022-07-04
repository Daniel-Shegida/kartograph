
/// Basic map event.
abstract class BaseMapEvent{
  /// Constructor.
  const BaseMapEvent();
}

/// map get current location event.
class MapGetLocationEvent extends BaseMapEvent {}

/// map get current location event.
class MapGetPlacesEvent extends BaseMapEvent {}

/// map init event.
class MapInitEvent extends BaseMapEvent {}
