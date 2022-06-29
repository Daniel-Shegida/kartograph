import 'dart:core';

import 'package:flutter/material.dart';
import 'package:kartograph/assets/enums/categories.dart';

/// список типов мест для показа и выбора из них в списке мест
@immutable
class PlaceFiltersList {
  /// список мест для отображения на экране мест
  late final List<ChoseCategory> listCategoriesToShow;

  /// конструктор создания [PlaceFiltersList]
  // из-за именного конструктора
  // ignore: prefer_const_constructors_in_immutables
  PlaceFiltersList({
    required this.listCategoriesToShow,
  });

  /// создание базового списка фильтров
  PlaceFiltersList.init() {
    listCategoriesToShow = [
      ChoseCategory(category: Categories.hotel, isChosen: true),
      ChoseCategory(category: Categories.restaurant, isChosen: true),
      ChoseCategory(category: Categories.other, isChosen: true),
      ChoseCategory(category: Categories.cafe, isChosen: true),
      ChoseCategory(category: Categories.museum, isChosen: true),
      ChoseCategory(category: Categories.park, isChosen: true),
    ];
  }

  /// создание копии списка с измененным логическим значением элемента
  PlaceFiltersList copyWith({
    required int indexToChange,
    required bool valueToChange,
  }) {
    listCategoriesToShow[indexToChange].isChosen = valueToChange;
    return PlaceFiltersList(listCategoriesToShow: listCategoriesToShow);
  }
}

/// категория, которая может быть выбрана или нет
class ChoseCategory {
  /// тип категории
  final Categories category;

  /// выбрана категория или нет
  bool isChosen;

  /// стандартный конструктор[ChoseCategory]
  ChoseCategory({
    required this.category,
    required this.isChosen,
  });
}
