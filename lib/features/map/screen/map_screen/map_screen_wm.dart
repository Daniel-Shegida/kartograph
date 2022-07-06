import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/app/di/app_scope.dart';
import 'package:kartograph/features/map/screen/map_screen/map_screen.dart';
import 'package:kartograph/features/map/screen/map_screen/map_screen_model.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/features/map/utils/mapSettings.dart';
import 'package:kartograph/features/map/widgets/marker.dart';
import 'package:kartograph/features/navigation/utils/navigation_helper.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

/// Builder for [MapWidgetModel]
MapWidgetModel mapWidgetModelFactory(BuildContext context) {
  return MapWidgetModel(
    MapModel(
      MapBloc(
        context.read<IAppScope>().repository,
        context.read<IAppScope>().lastCordsStorage,
      ),
    ),
    context.read<IAppScope>().navigationHelper,
  );
}

/// WidgetModel for [MapScreen]
class MapWidgetModel extends WidgetModel<MapScreen, MapModel>
    implements IMapWidgetModel {
  final StateNotifier<List<Marker>> _placesListState =
      StateNotifier<List<Marker>>();

  final NavigationHelper _navigationHelper;

  late final MapController _controller;

  @override
  MapController get controller => _controller;

  @override
  StateNotifier<List<Marker>> get placesListState => _placesListState;

  late StreamSubscription _blocSubscription;

  /// standard consctructor for elem
  MapWidgetModel(
    MapModel model,
    this._navigationHelper,
  ) : super(model);

  @override
  void initWidgetModel() {
    _controller = MapController();
    _blocSubscription = model.mapStateStream.listen(_updateState);
    model.getCurrentLocation();
    _placesListState.accept([]);
    _searchPlace();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _blocSubscription.cancel();
    super.dispose();
  }

  @override
  void getCurrentLocation() {
    model.getCurrentLocation();
  }

  @override
  void refresh() {
    model.getCurrentLocation();
  }

  @override
  void addPlace() {
    _navigationHelper.moveToMapAddingScreen(
      _controller.center.latitude,
      _controller.center.longitude,
      context,
    );
  }

  @override
  String getMapUrl() {
    return ProjectStrings.getUrl();
  }

  void _updateState(BaseMapState state) {
    if (state is MapContentState) {
      controller.move(state.currentLocation, controller.zoom);
    }
    if (state is MapPlacesContentState) {
      final placesList = <Marker>[];
      for (final place in state.list) {
        placesList.add(
          Marker(
            width: ProjectMapSettings.markersWidth,
            height: ProjectMapSettings.markersHeight,
            point: LatLng(place.lat, place.lng),
            builder: (_) => TransferMarker(place: place),
          ),
        );
      }
      _placesListState.accept(placesList);
    }
  }

  void _searchPlace() {
    model.search();
  }
}

/// Interface of [MapWidgetModel].
abstract class IMapWidgetModel extends IWidgetModel {
  /// Контроллер для карты.
  MapController get controller;

  /// показываемые темы
  StateNotifier<List<Marker>> get placesListState;

  /// action to go back to current location
  void getCurrentLocation();

  /// пока ивента для него нет
  void refresh();

  /// переходит на экран добавления места
  void addPlace();

  /// получение url карты
  String getMapUrl();
}
