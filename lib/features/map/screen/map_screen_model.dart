import 'package:elementary/elementary.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_event.dart';
import 'package:kartograph/features/map/service/map_state.dart';

/// Model of NumberWidgetModel
class MapModel extends ElementaryModel {
  /// Bloc for working with profile states.
  final MapBloc _mapBloc;

  /// Stream to track the state of the profile_bloc.
  Stream<BaseMapState> get mapStateStream => _mapBloc.stream;

  /// Gives the current state.
  BaseMapState get currentState => _mapBloc.state;

  /// Create an instance [MapModel].
  MapModel(
    this._mapBloc,
  ) : super();

  @override
  void init() {
    super.init();
    _mapBloc.add(MapGetLocationEvent());
  }

  /// Method for update personal data to the [MapBloc].
  void getCurrentLocation() {
    _mapBloc.add(
      MapGetLocationEvent(),
    );
  }

  /// получить список мест для карты
  void search() {
    _mapBloc.add(
      MapGetPlacesEvent(),
    );
  }
}
