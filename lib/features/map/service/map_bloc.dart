import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kartograph/api/service/place_rep/place_rep.dart';
import 'package:kartograph/config/coordinates.dart';
import 'package:kartograph/features/map/service/map_event.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/features/map/service/storage/last_cords_storage.dart';
import 'package:latlng/latlng.dart';

/// максимаотный ралиус, который поддерживается при запросе на сервер
const double maxRadius = 3000000;

/// все типы мест, поддерживаемые сервером
const List<String> allPlacesTypes = [
  'hotel',
  'restaurant',
  'other',
  'cafe',
  'museum',
  'park',
];

/// Bloc for working with profile states.
class MapBloc extends Bloc<BaseMapEvent, BaseMapState> {
  final PlaceRepository _rep;
  final LastCordsStorage _cordsStorage;

  /// Constructor of [MapBloc]
  MapBloc(this._rep, this._cordsStorage) : super(LoadingState()) {
    /// при событии загрузки статей запускаем стейт со статьями
    on<MapGetLocationEvent>((event, emit) async {
      final cords = await _getCordsFormGeolocator();

      await _cordsStorage.saveLastCords(cords!);
      emit(MapContentState(
        currentLocation: cords,
      ));
    });

    /// обработка события загрузки мест на карте
    on<MapGetPlacesEvent>((event, emit) async {
      final cords = await _cordsStorage.getLastCords();

      final list = await _rep.getSearchedPlaces(
        cords?.latitude ?? ProjectCoordinates.staringCords.latitude,
        cords?.longitude ?? ProjectCoordinates.staringCords.latitude,
        maxRadius,
        allPlacesTypes,
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

    await _cordsStorage
        .saveLastCords(LatLng(location.latitude, location.longitude));

    return LatLng(location.latitude, location.longitude);
  }
}
