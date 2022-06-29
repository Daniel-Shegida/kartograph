import 'package:flutter/material.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/places/domain/entity_place.dart';
import 'package:kartograph/features/places/screen/place_detail_screen/place_add_screen.dart';

/// Роут экрана [PlaceAddingScreen]
class PlaceAddScreenRoute extends MaterialPage<PlaceAddingScreen> {
  /// передоваемая категория на экран создания места
  final String category;
  /// передовай id на экран создания места
  final int? id;
  /// передоваемое имя на экран создания места
  final String? name;
  /// передоваемое описание на экран создания места
  final String? description;
  /// передоваемая широта на экран создания места
  final double? lat;
  /// передоваемая долгота на экран создания места
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
