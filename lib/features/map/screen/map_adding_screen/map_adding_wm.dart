import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/app/di/app_scope.dart';
import 'package:kartograph/features/app/di/theme_provider.dart';
import 'package:kartograph/features/map/screen/map_adding_screen/map_adding_model.dart';
import 'package:kartograph/features/map/screen/map_adding_screen/map_adding_screen.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_state.dart';
import 'package:kartograph/features/map/utils/mapSettings.dart';
import 'package:kartograph/features/map/widgets/marker.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:kartograph/features/navigation/utils/navigation_helper.dart';
import 'package:latlong2/latlong.dart';
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
          context.read<IAppScope>().lastCordsStorage,
        ),
      ),
      value,
      context.read<IAppScope>().navigationHelper,
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

  final StateNotifier<Marker> _marker = StateNotifier<Marker>();

  final NavigationHelper _navigationHelper;

  late final ThemeMode _currentTheme;

  @override
  ListenableState<Marker> get marker => _marker;

  @override
  MapController get controller => _controller;

  /// standard consctructor for elem
  MapAddingWidgetModel(
    MapAddingModel model,
    this.coordinates,
    this._navigationHelper,
  ) : super(model);

  @override
  void initWidgetModel() {
    _currentTheme = Provider.of<ThemeProvider>(context).themeMode;
    model.mapStateStream.listen(_updateState);
    _controller = MapController();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
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
        _navigationHelper.moveToCreationInDetailScreen(
          _marker.value!.point.latitude,
          _marker.value!.point.longitude,
          context,
        );
        Routemaster.of(context).pop();
      } else {
        Navigator.pop(
          context,
          _marker.value,
        );
      }
    }
  }

  @override
  void onTap(LatLng latLng) {
    _marker.accept(
      _createPlaceAdder(
        latLng,
      ),
    );
  }

  @override
  String getMapUrl() {
    if (_currentTheme != ThemeMode.dark) {
      return ProjectStrings.getLightUrl();
    } else {
      return ProjectStrings.getDarkUrl();
    }
  }

  void _updateState(BaseMapState state) {
    if (state is MapContentState) {
      controller.move(state.currentLocation, controller.zoom);
    }
  }

  Marker _createPlaceAdder(LatLng latLng) {
    return Marker(
      width: ProjectMapSettings.markersWidth,
      height: ProjectMapSettings.markersHeight,
      point: latLng,
      builder: (_) => TransferMarker(
        place: _createBasicPlace(latLng),
        onTap: _navigationHelper.moveToPlaceDetailScreen,
      ),
    );
  }

  Place _createBasicPlace(LatLng latLng) {
    return Place(
      id: 1,
      lat: latLng.latitude,
      lng: latLng.longitude,
      name: 'name',
      urls: [],
      placeType: Categories.newPlace,
      description: 'description',
    );
  }
}

/// интерфейс [MapAddingWidgetModel].
abstract class IMapAddingWidgetModel extends IWidgetModel {
  /// Контроллер для карты.
  MapController get controller;

  /// Список мест, трансформурющуюсиеся в карту.
  ListenableState<Marker> get marker;

  /// ивень при нажатии на карту
  void onTap(LatLng latLng);

  /// при навигации назад
  void pop();

  /// передать координаты точки
  void create();

  /// получение текущих координат
  void getCurrentGeolocation();

  /// получение url карты
  String getMapUrl();
}
