import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/map/screen/map_screen_wm.dart';
import 'package:kartograph/features/map/widgets/marker.dart';
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
      body: MapLayoutBuilder(
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
                  MapWidget(
                    mapController: wm.controller,
                  ),
                  MarkersStack(
                    controller: wm.controller,
                    transformer: transformer,
                    markers: wm.markers,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _RoundMapButton(
                              svgPath: ProjectIcons.refresh,
                              onPressed: wm.refresh,
                            ),
                            const _AddPlaceButton(),
                            _RoundMapButton(
                              svgPath: ProjectIcons.geo,
                              onPressed: wm.getCurrentLocation,
                            ),
                          ],
                        ),
                      ],
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

class _AddPlaceButton extends StatelessWidget {
  const _AddPlaceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 48,
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.yellow, Colors.green],
        ),
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              ProjectIcons.plus,
              color: ProjectColors.white,
            ),
            const Text(
              ProjectStrings.addPlace,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}

class _RoundMapButton extends StatelessWidget {
  /// путь к svg
  final String svgPath;

  /// функция  по нажатию на кнопку
  final VoidCallback onPressed;

  const _RoundMapButton(
      {required this.svgPath, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: MaterialButton(
        onPressed: onPressed,
        child: SvgPicture.asset(
          svgPath,
          color: ProjectColors.textColorPrimary,
        ),
        shape: const CircleBorder(),
        color: ProjectColors.white,
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
          iconData: Icons.location_on,
          color: Colors.red,
          onPressed: () {
            // ignore: avoid_print
            print('touch');
          },
        );
      },
    ).toList();

    // return LayoutBuilder(builder: _build);
    return Stack(children: markerWidgets);
  }
}
