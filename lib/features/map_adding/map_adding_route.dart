import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_screen.dart';
import 'package:provider/provider.dart';

/// Роут экрана [MapAddingScreen]
class MapAddingScreenRoute extends MaterialPage<MapAddingScreen> {
  final String category;
  final int? id;
  final String? name;
  final String? description;
  final double? lat;
  final double? lng;

  /// конструктор MaterialPage экрана [MapAddingScreen]
  MapAddingScreenRoute({
    required this.category,
    this.id,
    this.name,
    this.description,
    this.lat,
    this.lng,
  }) : super(
          child: Provider.value(
            value: Place(
              id: id,
              lat: lat,
              lng: lng,
              name: name,
              urls: [''],
              placeType: Categories.values.byName(category),
              description: description,
            ),
            child: MapAddingScreen(test: 3,),
          ),
        );
}
