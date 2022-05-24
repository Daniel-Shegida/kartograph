

import 'package:go_router/go_router.dart';
import 'package:kartograph/features/map/screen/map_screen.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_names.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:kartograph/features/places/screen/places_screen.dart';
import 'package:kartograph/features/setting/screen/setting_screen.dart';
import 'package:kartograph/features/temp/screens/temp_screen/temp_screen.dart';

/// All routes for the temp feature.
final List<GoRoute> tempRoutes = [
  GoRoute(
    path: AppRoutePaths.tempScreen,
    name: AppRouteNames.tempScreen,
    builder: (context, state) => const TempScreen(),
  ),
  GoRoute(
    path: AppRoutePaths.placesScreen,
    name: AppRouteNames.placesScreen,
    builder: (context, state) => const PlacesScreen(),
  ),
  GoRoute(
    path: AppRoutePaths.mapScreen,
    name: AppRouteNames.mapScreen,
    builder: (context, state) => const MapScreen(),
  ),
  GoRoute(
    path: AppRoutePaths.settingScreen,
    name: AppRouteNames.settingScreen,
    builder: (context, state) => const SettingScreen(),
  ),
];