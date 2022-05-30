import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/map/screen/map_screen_wm.dart';

/// Main Screen
class MapScreen extends ElementaryWidget<IMapWidgetModel> {
  /// standard consctructor for elem
  const MapScreen({
    Key? key,
    WidgetModelFactory wmFactory = mapWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMapWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Center(
        child: Text("map"),
      ),
    );
  }
}
