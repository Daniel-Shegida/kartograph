

import 'package:go_router/go_router.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_names.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:kartograph/features/temp/screens/temp_screen/temp_screen.dart';

/// All routes for the temp feature.
final List<GoRoute> tempRoutes = [
  GoRoute(
    path: AppRoutePaths.tempScreen,
    name: AppRouteNames.tempScreen,
    builder: (context, state) => const TempScreen(),
  ),
];