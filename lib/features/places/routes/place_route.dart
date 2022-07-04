import 'package:flutter/material.dart';
import 'package:kartograph/features/places/screen/places_screen/places_screen.dart';

/// Роут экрана [PlacesScreen]
class PlaceScreenRoute extends MaterialPage<PlacesScreen> {
  /// конструктор MaterialPage экрана [PlacesScreen]
  const PlaceScreenRoute()
      : super(
          child: const PlacesScreen(),
        );
}
