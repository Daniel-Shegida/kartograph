import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/map/widgets/marker_stack.dart';
import 'package:kartograph/features/map/widgets/round_button.dart';
import 'package:kartograph/features/map_adding/screen/map_adding_wm.dart';
import 'package:kartograph/util/map_widget.dart';
import 'package:map/map.dart';

/// экран добавления места
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
            child: const Text(
              ProjectStrings.cancel,
              style:
                  TextStyle(color: ProjectColors.textColorGrey, fontSize: 16),
            ),
          ),
        ),
        leadingWidth: 106,
        title: const Text(
          ProjectStrings.location,
          style: TextStyle(color: ProjectColors.mainLightTheme, fontSize: 24),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              ProjectStrings.ready,
              style:
                  TextStyle(color: ProjectColors.mainGreenColor, fontSize: 16),
            ),
          ),
        ],
      ),
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
              onPointerSignal: wm.onPointerSignal,
              child: Stack(
                children: [
                  MapWidget(
                    mapController: wm.controller,
                  ),
                  StateNotifierBuilder<List<Place>>(
                    listenableState: wm.markers,
                    builder: (ctx, value) {
                      return MarkersStack(
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
                      padding: const EdgeInsets.all(16.0),
                      color: ProjectColors.mapScreenHelper,
                      child: const Text(
                        ProjectStrings.mapAddHint,
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
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
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
