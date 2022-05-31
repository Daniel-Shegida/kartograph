import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/map/screen/map_screen_wm.dart';
import 'package:kartograph/util/map_widget.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

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
      body:
      ValueListenableBuilder<MapController>(
            builder: (BuildContext context, MapController value, Widget? child){
              return MapLayoutBuilder(
        controller: wm.controller,
        builder: (context, transformer) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: wm.onDoubleTap,
                onScaleStart: wm.onScaleStart,
                onScaleUpdate: wm.onScaleUpdate,
                onTapUp: (details) {
                  final location =
                      transformer.fromXYCoordsToLatLng(details.localPosition);
                  wm.markers.add(location);
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
                      MapWidget(mapController: wm.controller,),
                      MarkersStack(
                          controller: wm.controller, transformer: transformer, markers: wm.markers,),
                    ],
                  ),
                ),
              );
        },
      );

            },
        valueListenable: ValueNotifier<MapController>(wm.controller),

      ),
          );

  }
}

/// виджет, что подготавливает стек маркеров для карты
class MarkersStack extends StatefulWidget {
  /// Map controller.
  final MapController controller;

  /// Map transformer
  final MapTransformer transformer;

  /// маркеры на карие
  final List<LatLng> markers;

  /// MarkersStack constructor.
  const MarkersStack({
    required this.controller,
    required this.transformer,
    required this.markers,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MarkersStackState();
}

class _MarkersStackState extends State<MarkersStack> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _build);
  }

  Widget _buildMarkerWidget(Offset pos, Color color,
      [IconData icon = Icons.location_on,]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 24,
      width: 48,
      height: 48,
      child: GestureDetector(
        child: Icon(
          icon,
          color: color,
          size: 48,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _build(BuildContext context, BoxConstraints constraints) {
    final children = <Widget>[];

    final markerPositions =
        widget.markers.map(widget.transformer.fromLatLngToXYCoords);

    final markerWidgets = markerPositions.map(
      (pos) {
        return _buildMarkerWidget(pos, Colors.red);
      },
    );

    children.addAll(markerWidgets);

    final stack = Stack(children: children);

    return stack;
  }
}
