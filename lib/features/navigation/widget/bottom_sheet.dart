import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartograph/assets/res/kartograph_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';

/// widget for bottom navigation
class BottomNavigator extends StatefulWidget {
  /// index of selected screen
  final int selectedIndex;
  /// selected screen
  final Widget body;

  /// constructor for bottom navigation
  const BottomNavigator({
    required this.selectedIndex,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  bool get _drawerSize => MediaQuery.of(context).size.width >= 600;

  @override
  Widget build(BuildContext context) => AdaptiveNavigationScaffold(
        selectedIndex: widget.selectedIndex,
        destinations: const [
          AdaptiveScaffoldDestination(
              title: ProjectStrings.placesBottom, icon: Kartograph.list_full,),
          AdaptiveScaffoldDestination(
              title: ProjectStrings.mapBottom, icon: Kartograph.map,),
          AdaptiveScaffoldDestination(
              title: ProjectStrings.settingBottom, icon: Kartograph.settings,),
        ],
        navigationTypeResolver: (context) =>
            _drawerSize ? NavigationType.drawer : NavigationType.bottom,
        onDestinationSelected: (index) async {
          if (_drawerSize) Navigator.pop(context);
          switch (index) {
            case 0:
              context.go(AppRoutePaths.placesScreen);
              break;
            case 1:
              context.go(AppRoutePaths.mapScreen);
              break;
            case 2:
              context.go(AppRoutePaths.settingScreen);
              break;
            default:
              throw Exception('Invalid index');
          }
        },
        body: widget.body,
      );
}
