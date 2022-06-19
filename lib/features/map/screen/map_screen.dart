import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/map/screen/map_screen_wm.dart';
import 'package:kartograph/features/map/widgets/marker_stack.dart';
import 'package:kartograph/features/map/widgets/round_button.dart';
import 'package:kartograph/util/map_widget.dart';
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
                  StateNotifierBuilder<List<Place>>(
                    listenableState: wm.placesListState,
                    builder: (_, value) {
                      return MarkersStack(
                        controller: wm.controller,
                        transformer: transformer,
                        markers: value ?? [],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _RoundRefreshButton(
                              onPressed: wm.refresh,
                            ),
                            _AddPlaceButton(onPressed: wm.addPlace,),
                            _RoundGeoButton(
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
  final VoidCallback onPressed;
  const _AddPlaceButton({required this.onPressed, Key? key}) : super(key: key);

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
        onPressed: onPressed,
      ),
    );
  }
}

class _RoundRefreshButton extends StatelessWidget {
  /// функция  по нажатию на кнопку
  final VoidCallback onPressed;

  const _RoundRefreshButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      svgPath: ProjectIcons.refresh,
      onPressed: onPressed,
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
