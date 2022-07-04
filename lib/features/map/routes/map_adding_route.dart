import 'package:flutter/material.dart';
import 'package:kartograph/features/map/screen/map_adding_screen/map_adding_screen.dart';
import 'package:latlng/latlng.dart';

/// Роут экрана [MapAddingScreen]
class MapAddingScreenRoute extends MaterialPage<MapAddingScreen> {
  /// широта отображаемая при переходе на экран
  final double lat;
  /// долгота отображаемая при переходе на экран
  final double lng;

  /// конструктор MaterialPage экрана [MapAddingScreen]
  MapAddingScreenRoute({
    required this.lat,
    required this.lng,
  }) : super(

            child: MapAddingScreen(coordinates: LatLng(lat, lng,),),
        );
}
