import 'package:kartograph/api/data/place.dart';

/// Base state for profile.
abstract class BasePlaceState{

}

/// Base state containing profile.
class PlaceContentState extends BasePlaceState {

}

/// Base state containing profile.
class PlaceContentTestState extends BasePlaceState {
  final List<Place> list;

  PlaceContentTestState({required this.list});
}
