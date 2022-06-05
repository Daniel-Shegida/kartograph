
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen_wm.dart';

class PlaceAddingScreen extends ElementaryWidget<IPlaceAddingWidgetModel> {

  /// standard consctructor for elem
  const PlaceAddingScreen({
    Key? key,
    WidgetModelFactory wmFactory = placeAddingWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlaceAddingWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed: () {  }, child: Text("da"),),
      ),
      body:  Column(
        children: [
          Text("place"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
