// import 'dart:async';
// import 'package:elementary/elementary.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:kartograph/api/domain/place.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:kartograph/features/app/di/app_scope.dart';
// import 'package:kartograph/features/map/screen/map_screen/map_screen.dart';
// import 'package:kartograph/features/map/screen/map_screen/map_screen_model.dart';
// import 'package:kartograph/features/map/service/map_bloc.dart';
// import 'package:kartograph/features/map/service/map_state.dart';
// import 'package:kartograph/features/map/widgets/marker.dart';
// import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:map/map.dart';
// import 'package:provider/provider.dart';
// import 'package:routemaster/routemaster.dart';


import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/features/app/di/app_scope.dart';
import 'package:kartograph/features/map/screen/map_screen/map_screen.dart';
import 'package:kartograph/features/map/screen/map_screen/map_screen_model.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/features/map/widgets/marker.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

/// Builder for [MapWidgetModel]
MapWidgetModel mapWidgetModelFactory(BuildContext context) {
  return MapWidgetModel(MapModel(
    MapBloc(
      context.read<IAppScope>().repository,
    ),
  ));
}

/// WidgetModel for [MapScreen]
class MapWidgetModel extends WidgetModel<MapScreen, MapModel>
    implements IMapWidgetModel {
  // final _controller = MapController(
  //   location: LatLng(
  //     Environment<AppConfig>.instance().config.lat,
  //     Environment<AppConfig>.instance().config.lng,
  //   ),
  // );

  final StateNotifier<List<Marker> > _placesListState =
      StateNotifier<List<Marker> >();

  // /// controller for map
  // @override
  // MapController get controller => _controller;

  @override
  StateNotifier<List<Marker> > get placesListState => _placesListState;

  late Offset? _dragStart;

  late final MapController mapController;

  late StreamSubscription _blocSubscription;

  double _scaleStart = 1.0;

  List<Marker> _test = [];

  /// standard consctructor for elem
  MapWidgetModel(MapModel model) : super(model);

  @override
  void initWidgetModel() {
    mapController = MapController();
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
  void getCurrentLocation() {
    model.getCurrentLocation();
  }

  @override
  void refresh() {
    model.getCurrentLocation();
  }

  @override
  void addPlace() {
    Routemaster.of(context).push(AppRoutePaths.mapAdding, queryParameters: {
      'lat': mapController.center.latitude.toString(),
      'lng': mapController.center.longitude.toString(),
    });
  }

  void _updateState(BaseMapState state) {
    if (state is MapContentState) {
      // controller.center = state.currentLocation;
    }
    if (state is MapPlacesContentState) {

      List<Marker> test1 = [];
      for (Place e in state.list) {
        // ignore: avoid_print
        print(test1);
        test1.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(e.lat, e.lng),
            builder: (ctx) => TransferMarker(place: e),
            // const FlutterLogo(
            //   textColor: Colors.green,
            //   key: ObjectKey(Colors.green),
            // ),
          ),
        );
        // ignore: avoid_print
        print(e);
      }
      _test = test1;
      // ignore: avoid_print
      print(test.length);
      _placesListState.accept(test1);

      // state.list.map((e) {
      //   // ignore: avoid_print
      //   print(_test.length);
      //   _test.add(Marker(point: LatLng(e.lng, e.lng),
      //       builder: (context) =>
      //       KMarker(iconData: Icons.add_circle, color: Colors.green, onPressed: () {  },)
      //   ));
      // });
    }
  }

  void _searchPlace() {
    model.search();
  }

  @override
  // TODO: implement test
  List<Marker> get test => _test;

  @override
  // TODO: implement controller
  MapController get controller => mapController;
}

/// Interface of [MapWidgetModel].
abstract class IMapWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  MapController get controller;

  /// показываемые темы
  StateNotifier<List<Marker> > get placesListState;

  List<Marker> get test;

  // /// action to go back tp detail
  // void gotoDefault();
  //
  // /// action for DoubleTap
  // void onDoubleTap();
  //
  // /// action for starting scale
  // void onScaleStart(ScaleStartDetails details);
  //
  // /// action for changing scale
  // void onScaleUpdate(ScaleUpdateDetails details);
  //
  // /// action for changing scale
  // void onTap(TapUpDetails details, MapTransformer transformer);
  //
  // /// action to go back to current location
  // void getCurrentLocation();

  /// пока ивента для него нет
  void refresh();

  /// переходит на экран добавления места
  void addPlace();
}
