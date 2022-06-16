import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/places/place_api/place_api.dart';
import 'package:kartograph/features/places/screen/places_screeen_wm.dart';
import 'package:kartograph/features/places/service/place_rep.dart';

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
        child: TextButton(onPressed: null, child: Text("Click")),
      ),
    );
  }
}
