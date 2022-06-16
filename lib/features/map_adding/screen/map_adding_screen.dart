import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/features/map/screen/map_screen.dart';
import 'package:kartograph/features/map/widgets/marker.dart';
import 'package:kartograph/features/map/widgets/round_button.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_wm.dart';
import 'package:kartograph/util/map_widget.dart';
import 'package:latlng/latlng.dart';
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
      body:
          // Column(
          //   children: [
          // FractionallySizedBox(
          //   alignment: Alignment.topCenter,
          //   widthFactor: 1,
          //   child: Container(
          //     padding: EdgeInsets.all(16.0 ),
          //     color: ProjectColors.mapScreenHelper,
          //     child: Text(
          //       "потяните карту чтобы выбрать правильное местоположение",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontSize: 14,
          //
          //       ),
          //     ),
          //   ),
          // ),
          // SafeArea(
          //   child: Container(
          //     child:
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
                  StateNotifierBuilder<List<LatLng>>(
                    listenableState: wm.markers,
                    builder: (ctx, value) {
                      return MarkersStack1(
                        controller: wm.controller,
                        transformer: transformer,
                        markers: value ?? [],
                      );
                    },
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    widthFactor: 1,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: _RoundGeoButton(
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RoundGeoButton extends StatelessWidget {
  /// функция  по нажатию на кнопку
  final VoidCallback onPressed;

  const _RoundGeoButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      svgPath: ProjectIcons.geo,
      onPressed: onPressed,
    );
  }
}

/// виджет, что подготавливает стек маркеров для карты
class MarkersStack1 extends StatefulWidget {
  /// Map controller.
  final MapController controller;

  /// Map transformer
  final MapTransformer transformer;

  /// маркеры на карие
  final List<LatLng> markers;

  /// MarkersStack constructor.
  const MarkersStack1({
    required this.controller,
    required this.transformer,
    required this.markers,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MarkersStackState();
}

class _MarkersStackState extends State<MarkersStack1> {
  @override
  void initState() {
    super.initState();
    // dispose контроллера в wm
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final markerPositions =
        widget.markers.map(widget.transformer.fromLatLngToXYCoords);

    final markerWidgets = markerPositions.map(
      (pos) {
        return Marker(
          leftPos: pos.dx,
          topPos: pos.dy,
          iconData: Icons.add,
          color: Colors.blue,
          onPressed: () {},
        );
      },
    ).toList();

    // return LayoutBuilder(builder: _build);
    return Stack(children: markerWidgets);
  }
}
