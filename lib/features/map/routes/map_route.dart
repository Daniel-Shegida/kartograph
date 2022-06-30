import 'package:flutter/material.dart';
import 'package:kartograph/features/map/screen/map_screen/map_screen.dart';

/// Роут экрана [MapScreen]
class MapScreenRoute extends MaterialPage<MapScreen> {

  /// конструктор MaterialPage экрана [MapScreen]
  const MapScreenRoute()
      : super(
          child: const MapScreen(),
        );
}
