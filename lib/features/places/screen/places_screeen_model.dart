import 'package:elementary/elementary.dart';
import 'package:kartograph/features/places/service/bloc/place_bloc.dart';
import 'package:kartograph/features/places/service/bloc/place_event.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';

/// Model of SpecialWidgetModel
class PlacesModel extends ElementaryModel {
  /// Bloc for working with profile states.
  final PlaceBloc _placeBloc;

  /// Stream to track the state of the profile_bloc.
  Stream<BasePlaceState> get placeStateStream => _placeBloc.stream;

  /// Gives the current state.
  BasePlaceState get currentState => _placeBloc.state;

  /// Create an instance [PlacesModel].
  PlacesModel(
      this._placeBloc,
      ) : super();

  void init() {
    super.init();
    _placeBloc.add(PlaceLoadEvent());
  }

  void search(List<String> list) {
    // ignore: avoid_print
    print("model");
    _placeBloc.add(PlaceSearchEvent(list: list));
  }
}
