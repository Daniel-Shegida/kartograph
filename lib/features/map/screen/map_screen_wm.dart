import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/map/screen/map_screen.dart';
import 'package:kartograph/features/map/screen/map_screen_model.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:routemaster/routemaster.dart';

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

  List<Place> _markers = [

  ];

  final StateNotifier<List<Place>> _placesListState =
  StateNotifier<List<Place>>();

  /// controller for map
  @override
  MapController get controller => _controller;

  @override
  List<Place> get markers => _markers;

  @override
  StateNotifier<List<Place>> get placesListState => _placesListState;


  late Offset? _dragStart;

  late StreamSubscription _blocSubscription;


  double _scaleStart = 1.0;

  /// standard consctructor for elem
  MapWidgetModel(MapModel model) : super(model);

  @override
  void initWidgetModel() {
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

  @override
  void addPlace() {
    Place _place = Place(id: 1, lat: 1, lng: 1, name: "name", urls: [], placeType: Categories.other, description: 'description');
    Routemaster.of(context).push('MapAdding', queryParameters: {
      'category': _place.placeType.name,
      'name': _place.name,
      'description': _place.description,
      // 'lat': _place.lat.toString(),
      // 'lng': _place.lng.toString(),
    });
  }

  void _updateState(BaseMapState state) {
    if (state is MapContentState) {
      controller.center = state.currentLocation;
    }
    if (state is MapPlacesContentState) {
      // ignore: avoid_print
      print("MapPlacesContentState");
      // ignore: avoid_print
      _markers = state.list;
      // ignore: avoid_print
      print(_markers);
      _placesListState.accept(state.list);

    }
  }

  void _searchPlace() {
    model.search();

  }
}

/// Interface of [MapWidgetModel].
abstract class IMapWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  MapController get controller;

  /// Text editing controller Main Screen.
  List<Place> get markers;

  /// показываемые темы
  StateNotifier<List<Place>> get placesListState;

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

  /// переходит на экран добавления места
  void addPlace();
}
