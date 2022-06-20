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

    '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.changingPlaceScreen}:id':
        (route) => PlaceAddScreenRoute(
              id: int.tryParse(route.pathParameters['id'] ?? 'q'),
              category:
                  route.queryParameters['category'] ?? Categories.other.name,
              name: route.queryParameters['name'],
              description: route.queryParameters['description'],
              lat: double.parse(route.queryParameters['lat'] ?? '0'),
              lng: double.parse(route.queryParameters['lng'] ?? '0'),
            ),

    '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.creatingPlaceScreen}':
        (route) => PlaceAddScreenRoute(
              category:
                  route.queryParameters['category'] ?? Categories.other.name,
              name: route.queryParameters['name'],
              description: route.queryParameters['description'],
              lat: double.parse(route.queryParameters['lat'] ?? '0'),
              lng: double.parse(route.queryParameters['lng'] ?? '0'),
            ),

    '${AppRoutePaths.tabs}${AppRoutePaths.mapScreen}${AppRoutePaths.mapAdding}': (route) => MapAddingScreenRoute(
      category: route.queryParameters['category'] ?? Categories.other.name,
      name: route.queryParameters['name'],
      description: route.queryParameters['description'],
      lat: double.parse(route.queryParameters['lat'] ?? '0'),
      lng: double.parse(route.queryParameters['lng'] ?? '0'),
    ),
    '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.creatingPlaceScreen}${AppRoutePaths.mapAdding}': (route) => MapAddingScreenRoute(
      category: route.queryParameters['category'] ?? Categories.other.name,
      name: route.queryParameters['name'],
      description: route.queryParameters['description'],
      lat: double.parse(route.queryParameters['lat'] ?? '0'),
      lng: double.parse(route.queryParameters['lng'] ?? '0'),
    ),
    '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.changingPlaceScreen}:id/${AppRoutePaths.mapAdding}': (route) => MapAddingScreenRoute(
      id: int.tryParse(route.pathParameters['id'] ?? 'q'),
      category: route.queryParameters['category'] ?? Categories.other.name,
      name: route.queryParameters['name'],
      description: route.queryParameters['description'],
      lat: double.parse(route.queryParameters['lat'] ?? '0'),
      lng: double.parse(route.queryParameters['lng'] ?? '0'),
    ),

// 'SettingScreenRoute': (_) => PlaceAddScreenRoute(),

// '/tabs/profile/topicProgress/:search': (route) =>  ProfileTopicNamedRoute(
//   route.queryParameters['search'] ?? '0',
// ),
  },
);
