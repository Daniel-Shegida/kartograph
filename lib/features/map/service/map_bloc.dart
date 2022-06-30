import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kartograph/config/coordinates.dart';
import 'package:kartograph/features/map/service/map_event.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/features/map/service/storage/last_cords_storage.dart';
import 'package:kartograph/features/places/service/place_rep.dart';
import 'package:latlng/latlng.dart';

const double maxRadius = 3000000;

/// Bloc for working with profile states.
class MapBloc extends Bloc<BaseMapEvent, BaseMapState> {
  final PlaceRepository _rep;
  final LastCordsStorage _cordsStorage;

  /// Constructor of [MapBloc]
  MapBloc(this._rep, this._cordsStorage) : super(LoadingState()) {
    /// при событии загрузки статей запускаем стейт со статьями
    on<MapGetLocationEvent>((event, emit) async {
      final cords = await _getCordsFormGeolocator();

      _cordsStorage.saveLastCords(cords!);
      emit(MapContentState(
        currentLocation: cords!,
      ));
    });

    /// обработка события загрузки мест на карте
    on<MapGetPlacesEvent>((event, emit) async {
      // ignore: omit_local_variable_types
      LatLng? cords = await _cordsStorage.getLastCords();

      final list = await _rep.getSearchedPlaces(
        cords?.latitude ?? ProjectCoordinates.staringCords.latitude,
        cords?.longitude ?? ProjectCoordinates.staringCords.latitude,
        maxRadius,
        ['hotel', 'restaurant', 'other', 'cafe', 'museum', 'park'],
        '',
      );
      emit(MapPlacesContentState(list: list));
    });

    /// обработка события иницилизации карты
    on<MapInitEvent>((event, emit) async {
      // ignore: omit_local_variable_types
      LatLng? cords = await _cordsStorage.getLastCords();
      if (cords != null) {
        emit(
          MapContentState(
            currentLocation: cords,
          ),
        );
      } else {
        cords = await _getCordsFormGeolocator();
      }
      emit(
        MapContentState(
          currentLocation: cords!,
        ),
      );
    });
  }

  Future<LatLng?> _getCordsFormGeolocator() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    final location = await Geolocator.getCurrentPosition();

    return LatLng(location.latitude, location.longitude);
  }
}
