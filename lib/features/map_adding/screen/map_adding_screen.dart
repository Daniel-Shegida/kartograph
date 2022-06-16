import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_wm.dart';
import 'package:map/map.dart';

class MapAddingScreen extends ElementaryWidget<IMapAddingWidgetModel> {
  /// standard consctructor for elem
  const MapAddingScreen({
    Key? key,
    WidgetModelFactory wmFactory = mapAddingWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMapAddingWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Center(
            child: TextButton(
          onPressed: () {},
          child: Text(
            "отмена",
            style: TextStyle(color: ProjectColors.textColorGrey),
          ),
        )),
        leadingWidth: 106,
        title: Text(
          "Местоположение",
          style:
              TextStyle(decorationColor: Colors.black87, color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "готово",
              style: TextStyle(color: Colors.green),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            child: Container(
              padding: EdgeInsets.all(16.0 ),
              color: ProjectColors.mapScreenHelper,
              child: Text(
                "потяните карту чтобы выбрать правильное местоположение",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,

                ),
              ),
            ),
          ),
          MapLayoutBuilder(
            controller: wm.controller,
            builder: (context, transformer) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: wm.onDoubleTap,
                onScaleStart: wm.onScaleStart,
                onScaleUpdate: wm.onScaleUpdate,
                onTapUp: (details) {
                  wm.onTap(details, transformer);
                },
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final delta = event.scrollDelta;

                      wm.controller.zoom -= delta.dy / 1000.0;
                    }
                  },
                  child: Stack(
                    children: [
                      MapWidget(
                        mapController: wm.controller,
                      ),
                      MarkersStack(
                        controller: wm.controller,
                        transformer: transformer,
                        markers: wm.markers,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
