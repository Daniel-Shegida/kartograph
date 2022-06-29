import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/app/di/app_scope.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/features/map/screen/map_adding_screen/map_adding_model.dart';
import 'package:kartograph/features/map/screen/map_adding_screen/map_adding_screen.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

/// фабрака по создания [MapAddingWidgetModel]
MapAddingWidgetModel Function(BuildContext context)
    mapAddingWidgetModelFactoryWithParams(LatLng value) {
  return (context) {
    return MapAddingWidgetModel(
      MapAddingModel(
        MapBloc(
          context.read<IAppScope>().repository,
        ),
      ),
      value,
    );
  };
}

/// WidgetModel for [MapAddingScreen]
class MapAddingWidgetModel extends WidgetModel<MapAddingScreen, MapAddingModel>
    with SingleTickerProviderWidgetModelMixin
    implements IMapAddingWidgetModel {
  /// передаваемые координаты для отображения места
  final LatLng coordinates;

  late final MapController _controller;
  final StateNotifier<Place> _marker = StateNotifier<Place>();

  /// controller for map
  @override
  MapController get controller => _controller;

  @override
  StateNotifier<Place> get marker => _marker;

  late Offset? _dragStart;

  double _scaleStart = 1.0;

  /// standard consctructor for elem
  MapAddingWidgetModel(MapAddingModel model, this.coordinates) : super(model);

  @override
  void initWidgetModel() {
    model.mapStateStream.listen(_updateState);
    _controller = MapController(
      location: coordinates,
    );
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
    _marker.accept(
      _createPlaceAdder(
        location.latitude,
        location.longitude,
      ),
    );
  }

  @override
  void pop() {
    Navigator.pop(context);
  }

  @override
  void getCurrentGeolocation() {
    model.getCurrentLocation();
  }

  @override
  void create() {
    if (_marker.value != null) {
      if (Routemaster.of(context).currentRoute.path ==
          '${AppRoutePaths.tabs}${AppRoutePaths.mapScreen}${AppRoutePaths.mapAdding}') {
        Routemaster.of(context).pop();
        Routemaster.of(context).push(
          '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.creatingPlaceScreen}',
          queryParameters: {
            'category': 'other',
            'name': '',
            'description': '',
            'lat': _marker.value!.lat.toString(),
            'lng': _marker.value!.lng.toString(),
          },
        );
      } else {
        Navigator.pop(
          context,
          LatLng(_marker.value!.lat, _marker.value!.lng),
        );
      }
    }
  }

  @override
  void onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final delta = event.scrollDelta;

      _controller.zoom -= delta.dy / 1000.0;
    }
  }

  void _updateState(BaseMapState state) {
    if (state is MapContentState) {
      controller.center = state.currentLocation;
    }
  }

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
  StateNotifier<Place> get marker;

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
  void getCurrentGeolocation();

  /// ивент обрабатывающий взаимодействия пользователя с картой
  /// (на данный момент только ивент изменения масштаба)
  void onPointerSignal(PointerSignalEvent event);
}
