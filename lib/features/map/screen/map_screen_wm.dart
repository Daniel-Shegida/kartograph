import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/config/app_config.dart';
import 'package:kartograph/config/environment/environment.dart';
import 'package:kartograph/features/map/screen/map_screen.dart';
import 'package:kartograph/features/map/screen/map_screen_model.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

/// Builder for [MapWidgetModel]
MapWidgetModel mapWidgetModelFactory(BuildContext context) {
  return MapWidgetModel(MapModel(MapBloc()));
}

/// WidgetModel for [MapScreen]
class MapWidgetModel extends WidgetModel<MapScreen, MapModel>
    implements IMapWidgetModel {
  final _controller = MapController(
    location: LatLng(
      Environment<AppConfig>.instance().config.lat,
      Environment<AppConfig>.instance().config.lng,
    ),
  );

  final _markers = [
    Place(
      id: 1,
      lat: 31,
      lng: 32,
      name: 'name',
      urls: ['urls'],
      placeType: Categories.other,
      description: 'description',
    ),
  ];

  /// controller for map
  @override
  MapController get controller => _controller;

  @override
  List<Place> get markers => _markers;

  late Offset? _dragStart;

  double _scaleStart = 1.0;

  /// standard consctructor for elem
  MapWidgetModel(MapModel model) : super(model);

  @override
  void initWidgetModel() {
    final blocStream = model.mapStateStream;
    blocStream.listen(_updateState);
    model.getCurrentLocation();
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
  }

  @override
  void getCurrentLocation() {
    model.getCurrentLocation();
  }

  @override
  void refresh() {
    model.getCurrentLocation();
  }

  void _updateState(BaseMapState state) {
    if (state is MapContentState) {
      controller.center = state.currentLocation;
    }
  }
}

/// Interface of [MapWidgetModel].
abstract class IMapWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  MapController get controller;

  /// Text editing controller Main Screen.
  List<Place> get markers;

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

  /// action to go back to current location
  void getCurrentLocation();

  /// пока ивента для него нет
  void refresh();
}
