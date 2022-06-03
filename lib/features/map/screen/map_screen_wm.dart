import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
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
    location: LatLng(35.68, 51.41),
  );

  final _markers = [
    LatLng(35.674, 51.41),
    LatLng(35.678, 51.41),
    LatLng(35.682, 51.41),
    LatLng(35.686, 51.41),
  ];

  /// controller for map
  @override
  MapController get controller => _controller;

  @override
  List<LatLng> get markers => _markers;

  late Offset? _dragStart;

  double _scaleStart = 1.0;

  /// standard consctructor for elem
  MapWidgetModel(MapModel model) : super(model);

  @override
  void initWidgetModel() {
    model.mapStateStream.listen(_updateState);
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



  void _updateState(BaseMapState state) {

  }
}


/// Interface of [MapWidgetModel].
abstract class IMapWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  MapController get controller;

  /// Text editing controller Main Screen.
  List<LatLng> get markers;

  /// action to go back tp detail
  void gotoDefault();

  /// action for DoubleTap
  void onDoubleTap();

  /// action for starting scale
  void onScaleStart(ScaleStartDetails details);

  /// action for changing scale
  void onScaleUpdate(ScaleUpdateDetails details);
}
