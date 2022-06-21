import 'package:flutter/material.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/place_adding/domain/entity_place.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen.dart';

/// Роут экрана [PlaceAddingScreen]
class PlaceAddScreenRoute extends MaterialPage<PlaceAddingScreen> {
  final String category;
  final int? id;
  final String? name;
  final String? description;
  final double? lat;
  final double? lng;

  /// конструктор MaterialPage экрана [PlaceAddingScreen]
  PlaceAddScreenRoute({
    required this.category,
    this.id,
    this.name,
    this.description,
    this.lat,
    this.lng,
  }) : super(
          child: PlaceAddingScreen(
            place: EntityPlace(
              placeType: Categories.values.byName(category),
              id: id,
              lat: lat,
              lng: lng,
              name: name,
              description: description,
            ),
          ),
        );

// child: constonst PlaceAddingScreen(),
}
