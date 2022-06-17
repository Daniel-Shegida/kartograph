import 'dart:core';

import 'package:flutter/material.dart';
import 'package:kartograph/assets/enums/categories.dart';

/// список типов мест для показа и выбора из них в списке мест
@immutable
class ListPlacesToShow {
  /// список мест для отображения на экране мест
  late final List<PlaceTypeToShow> listCategoriesToShow;

  /// конструктор создания [ListPlacesToShow]
  // из-за именного конструктора
  // ignore: prefer_const_constructors_in_immutables
  ListPlacesToShow({
    required this.listCategoriesToShow,
  });

  ListPlacesToShow.createStandard() {
    listCategoriesToShow = [
      PlaceTypeToShow(category: Categories.hotel, isChosen: true),
      PlaceTypeToShow(category: Categories.restaurant, isChosen: true),
      PlaceTypeToShow(category: Categories.other, isChosen: true),
      PlaceTypeToShow(category: Categories.cafe, isChosen: true),
      PlaceTypeToShow(category: Categories.museum, isChosen: true),
      PlaceTypeToShow(category: Categories.park, isChosen: true),
    ];
  }

  /// создание копии списка с измененным логическим значением элемента
  ListPlacesToShow copyWith({
    required int indexToChange,
    required bool valueToChange,
  }) {
    listCategoriesToShow[indexToChange].isChosen = valueToChange;
    return ListPlacesToShow(listCategoriesToShow: listCategoriesToShow);
  }
}

/// категория, которая может быть выбрана или нет
class PlaceTypeToShow {
  /// тип категории
  final Categories category;

  /// выбрана категория или нет
  bool isChosen;

  /// стандартный конструктор[PlaceTypeToShow]
  PlaceTypeToShow({
    required this.category,
    required this.isChosen,
  });
}
