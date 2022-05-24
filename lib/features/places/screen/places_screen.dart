import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/places/screen/places_screeen_wm.dart';

class PlacesScreen extends ElementaryWidget<IPlacesWidgetModel> {

  /// standard consctructor for elem
  const PlacesScreen({
    Key? key,
    WidgetModelFactory wmFactory = placesWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlacesWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
      ),
    );
  }
}
