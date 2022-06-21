import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_screen.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';

/// Роут экрана [MapAddingScreen]
class MapAddingScreenRoute extends MaterialPage<MapAddingScreen> {
  final double lat;
  final double lng;

  /// конструктор MaterialPage экрана [MapAddingScreen]
  MapAddingScreenRoute({
    required this.lat,
    required this.lng,
  }) : super(

            child: MapAddingScreen(coordinates: LatLng(lat, lng,),),
        );
}
