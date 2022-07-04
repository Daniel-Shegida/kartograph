import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kartograph/features/map/service/map_event.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/api/service/place_rep/place_rep.dart';
import 'package:latlng/latlng.dart';

/// Bloc for working with profile states.
class MapBloc extends Bloc<BaseMapEvent, BaseMapState> {
  final PlaceRepository _rep;

  /// Constructor of [MapBloc]
  MapBloc(this._rep) : super(LoadingState()) {
    /// при событии загрузки статей запускаем стейт со статьями
    on<MapGetLocationEvent>((event, emit) async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // TODO: create state with error
        // return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // TODO: create state with error
          // return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        // TODO: create state with error
        // return Future.error(
        //     'Location permissions are permanently denied, we cannot request permissions.');
      }

      final location = await Geolocator.getCurrentPosition();

      emit(MapContentState(
        currentLocation: LatLng(location.latitude, location.longitude),
      ));
    });

    /// обработка события загрузки мест на карте
    on<MapGetPlacesEvent>((event, emit) async {
      final list = await _rep.getSearchedPlaces(
        /// TODO посмотреть возможность добавления координат при связывании приложения
        37,
        -122,
        3000000.0,
        ['hotel', 'restaurant', 'other', 'cafe', 'museum', 'park'],
        '',
      );
      emit(MapPlacesContentState(list: list));
    });
  }
}
