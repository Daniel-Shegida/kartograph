import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/config/app_config.dart';
import 'package:kartograph/config/environment/environment.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_model.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_screen.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

/// Builder for [MapAddingWidgetModel]
MapAddingWidgetModel mapAddingWidgetModelFactory(BuildContext context) {
  return MapAddingWidgetModel(
    MapAddingModel(
      MapBloc(),
    ),
  );
}

/// WidgetModel for [MapAddingScreen]
class MapAddingWidgetModel extends WidgetModel<MapAddingScreen, MapAddingModel>
    with SingleTickerProviderWidgetModelMixin
    implements IMapAddingWidgetModel {
  final _controller = MapController(
    location: LatLng(
      Environment<AppConfig>.instance().config.lat,
      Environment<AppConfig>.instance().config.lng,
    ),
  );
  final StateNotifier<List<Place>> _markers = StateNotifier<List<Place>>();

  late final Place _place;

  /// controller for map
  @override
  MapController get controller => _controller;

  @override
  StateNotifier<List<Place>> get markers => _markers;

  late Offset? _dragStart;

  double _scaleStart = 1.0;

  /// standard consctructor for elem
  MapAddingWidgetModel(MapAddingModel model) : super(model);

  @override
  void initWidgetModel() {
    model.mapStateStream.listen(_updateState);
    _markers.accept([]);
    _place = context.read<Place>();
    if (_place.lng != 0 && _place.lng != null) {
      _controller.center = LatLng(_place.lat!, _place.lng!);
    }
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  @override
  void onDoubleTap() {
    _controller.zoom += 0.5;
  }

  @override
  void gotoDefault() {
    _controller.center = LatLng(
      Environment<AppConfig>.instance().config.lat,
      Environment<AppConfig>.instance().config.lng,
    );
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      _controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      _controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      _controller.drag(diff.dx, diff.dy);
    }
  }

  @override
  void onTap(TapUpDetails details, MapTransformer transformer) {
    final location = transformer.fromXYCoordsToLatLng(details.localPosition);
    _markers.accept([
      _createPlaceAdder(
        location.latitude,
        location.longitude,
      ),
    ]);
  }

  @override
  void pop() {
    Routemaster.of(context).pop();
  }

  @override
  void geo() {
    model.getCurrentLocation();
  }

  @override
  void create() {
    if (_markers.value?.isNotEmpty ?? false) {
      Routemaster.of(context).pop();
      if (_place.id != null) {
        Routemaster.of(context).push(
          '${AppRoutePaths.changingPlaceScreen}${_place.id}',
          queryParameters: {
            'category': _place.placeType.name,
            'name': _place.name ?? '',
            'description': _place.description ?? '',
            'lat': _markers.value![0].lat.toString(),
            'lng': _markers.value![0].lng.toString(),
          },
        );
      } else {
        Routemaster.of(context).push(
          '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.creatingPlaceScreen}',
          queryParameters: {
            'category': _place.placeType.name,
            'name': _place.name ?? '',
            'description': _place.description ?? '',
            'lat': _markers.value![0].lat.toString(),
            'lng': _markers.value![0].lng.toString(),
          },
        );
      }
    }
  }

  void _updateState(BaseMapState state) {
    if (state is MapContentState) {
      controller.center = state.currentLocation;
    }
  }
  @override
  void onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final delta = event.scrollDelta;

      _controller.zoom -= delta.dy / 1000.0;
    }
  }

  void _updateState(BaseMapState state) {}

  Place _createPlaceAdder(double lat, double long) {
    return Place(
      id: 1,
      lat: lat,
      lng: long,
      name: 'name',
      urls: [],
      placeType: Categories.newPlace,
      description: 'description',
    );
  }
}

/// интерфейс [MapAddingWidgetModel].
abstract class IMapAddingWidgetModel extends IWidgetModel {
  /// контроллер карты
  MapController get controller;

  /// Список мест, трансформурющуюсиеся в карту.
  StateNotifier<List<Place>> get markers;

  /// ивент вернуться к изначальному значениб
  void gotoDefault();

  /// ивент при двойном нажатии на карту
  void onDoubleTap();

  /// ивент при начале изменения масштаба
  void onScaleStart(ScaleStartDetails details);

  /// ивент при изменении мастштаба
  void onScaleUpdate(ScaleUpdateDetails details);

  /// ивень при нажатии на карту
  void onTap(TapUpDetails details, MapTransformer transformer);

  /// om pop
  void pop();

  /// передать координаты точки
  void create();

  /// получение текущих координат
  void geo();

  /// ивент обрабатывающий взаимодействия пользователя с картой
  /// (на данный момент только ивент изменения масштаба)
  void onPointerSignal(PointerSignalEvent event);
}
