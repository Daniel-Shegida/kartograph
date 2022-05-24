import 'package:go_router/go_router.dart';
import 'package:kartograph/features/navigation/domain/entity/temp/temp_routes.dart';

/// All routes of the app.
class AppRoutes implements AppRoutesDelegate{
  /// List of registered routes.
  /// Fill this list with routes you want to use in your app.
  @override
  List<GoRoute> routeList = [
    ...tempRoutes,
  ];
}

/// Interface routes of the app.
abstract class AppRoutesDelegate {
  /// List of registered routes.
  List<GoRoute> get routeList;
}