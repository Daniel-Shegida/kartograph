import 'package:flutter/material.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen.dart';

/// Роут экрана [PlaceAddingScreen]
class PlaceAddScreenRoute extends MaterialPage<PlaceAddingScreen> {

  /// конструктор MaterialPage экрана [PlaceAddingScreen]
  const PlaceAddScreenRoute()
      : super(

    child: const PlaceAddingScreen(),

  );
}