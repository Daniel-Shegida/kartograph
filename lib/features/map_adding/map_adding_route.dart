

import 'package:flutter/material.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_screen.dart';

/// Роут экрана [MapAddingScreen]
class MapAddingScreenRoute extends MaterialPage<MapAddingScreen> {

  /// конструктор MaterialPage экрана [MapAddingScreen]
  const MapAddingScreenRoute()
      : super(
    child: const MapAddingScreen(),
  );
}
