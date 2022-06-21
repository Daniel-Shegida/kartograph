import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/place_adding/domain/entity_place.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen.dart';
import 'package:provider/provider.dart';

/// Роут экрана [PlaceAddingScreen]
class PlaceAddScreenRoute extends MaterialPage<PlaceAddingScreen> {
  final Categories category;
  final int? id;
  final String? name;
  final String? description;
  final double? lat;
  final double? lng;

  /// конструктор MaterialPage экрана [PlaceAddingScreen]
  PlaceAddScreenRoute({
    this.category = Categories.other,
    this.id,
    this.name,
    this.description,
    this.lat,
    this.lng,
  }) : super(
                child:  PlaceAddingScreen(place: EntityPlace(),),
        );

// child: constonst PlaceAddingScreen(),
}
