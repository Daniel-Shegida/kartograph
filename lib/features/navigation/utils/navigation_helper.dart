import 'package:flutter/material.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/features/map/screen/map_adding_screen/map_adding_screen.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:latlong2/latlong.dart';
import 'package:routemaster/routemaster.dart';

/// Модель унифицирующая навигацию между экранами
class NavigationHelper {
  /// Метод перехода на экран получения координат на карте с экрана карты
  void moveToMapAddingScreen(
    double latitude,
    double longitude,
    BuildContext context,
  ) {
    Routemaster.of(context).push(AppRoutePaths.mapAdding, queryParameters: {
      'lat': latitude.toString(),
      'lng': longitude.toString(),
    });
  }

  /// Метод перехода на экран деталей места с карты
  void moveToCreationInDetailScreen(
    double latitude,
    double longitude,
    BuildContext context,
  ) {
    Routemaster.of(context).push(
      '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.creatingPlaceScreen}',
      queryParameters: {
        'category': 'other',
        'name': '',
        'description': '',
        'lat': latitude.toString(),
        'lng': longitude.toString(),
      },
    );
  }

  /// Метод перехода на экран получения координат на карте с детального
  /// просмотра места для получения координат
  Future<LatLng?> getCordsFromMapAddingScreen(
    double latitude,
    double longitude,
    BuildContext context,
  ) async {
    return Navigator.push<LatLng?>(
      context,
      MaterialPageRoute(
        builder: (context) => MapAddingScreen(
          coordinates: LatLng(latitude, longitude),
        ),
      ),
    );
  }

  /// Метод перехода на экран детального просмотра места с экрана мест
  void moveToPlaceDetailScreen(
    Place place,
    BuildContext context,
  ) {
    Routemaster.of(context).push(
      '${AppRoutePaths.changingPlaceScreen}${place.id}',
      queryParameters: {
        'category': place.placeType.name,
        'name': place.name,
        'description': place.description,
        'lat': place.lat.toString(),
        'lng': place.lng.toString(),
      },
    );
  }

  /// Метод перехода на экран детального просмотра места с карты
  void moveToPlaceDetailScreenFromMap(
    Place place,
    BuildContext context,
  ) {
    Routemaster.of(context).push(
      '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.changingPlaceScreen}${place.id}',
      queryParameters: {
        'category': place.placeType.name,
        'name': place.name,
        'description': place.description,
        'lat': place.lat.toString(),
        'lng': place.lng.toString(),
      },
    );
  }
}
