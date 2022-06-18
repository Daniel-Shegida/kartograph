import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/map/map_route.dart';
import 'package:kartograph/features/map_adding/map_adding_route.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:kartograph/features/navigation/widget/bottom_sheet.dart';
import 'package:kartograph/features/place_adding/place_add_route.dart';
import 'package:kartograph/features/places/place_route.dart';
import 'package:kartograph/features/setting/setting_route.dart';
import 'package:routemaster/routemaster.dart';

/// all routes for kartograph project
final routes = RouteMap(
  routes: {
    /// 'путь': (_) => MaterialPage(child: виджет),
// '/': (_) =>
// const Redirect('${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}'),
    '/': (_) =>
        const Redirect('${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}'),
    AppRoutePaths.tabs: (route) => const TabPage(
          child: BottomNavigator(),
          paths: [
            AppRoutePaths.placesScreen,
            AppRoutePaths.mapScreen,
            AppRoutePaths.settingScreen,
          ],
        ),
    '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}': (_) =>
        const PlaceScreenRoute(),

    '${AppRoutePaths.tabs}${AppRoutePaths.mapScreen}': (_) =>
        const MapScreenRoute(),

    '${AppRoutePaths.tabs}${AppRoutePaths.settingScreen}': (_) =>
        const SettingScreenRoute(),
    '/Rest': (route) => PlaceAddScreenRoute(
          category: route.queryParameters['category'] ?? '0',
          name: route.queryParameters['name'] ?? '0',
          description: route.queryParameters['description'] ?? '0',
          lat: double.parse(route.queryParameters['lat'] ?? '0'),
          lng: double.parse(route.queryParameters['lng'] ?? '0'),
        ),

    '/MapAdding': (_) => const MapAddingScreenRoute(),
// 'SettingScreenRoute': (_) => PlaceAddScreenRoute(),

// '/tabs/profile/topicProgress/:search': (route) =>  ProfileTopicNamedRoute(
//   route.queryParameters['search'] ?? '0',
// ),
  },
);
