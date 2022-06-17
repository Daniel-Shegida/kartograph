import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_model.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_screen.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

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
    location: LatLng(35.68, 51.41),
  );
  final StateNotifier<List<Place>> _markers = StateNotifier<List<Place>>();

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
    _controller.center = LatLng(35.68, 51.41);
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

  void _updateState(BaseMapState state) {}

  Place _createPlaceAdder(double lat, double long) {
    return Place(
      id: 1,
      lat: lat,
      lng: long,
      name: 'name',
      urls: [],
      placeType: Categories.placeAdder,
      description: 'description',
    );
  }
}

/// Interface of [MapAddingWidgetModel].
abstract class IMapAddingWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  MapController get controller;

  /// Text editing controller Main Screen.
  StateNotifier<List<Place>> get markers;

  /// action to go back tp detail
  void gotoDefault();

  /// action for DoubleTap
  void onDoubleTap();

  /// action for starting scale
  void onScaleStart(ScaleStartDetails details);

  /// action for changing scale
  void onScaleUpdate(ScaleUpdateDetails details);

  /// action for changing scale
  void onTap(TapUpDetails details, MapTransformer transformer);
}
