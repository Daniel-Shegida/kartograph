import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/map/screen/map_adding_screen/map_adding_wm.dart';
import 'package:kartograph/features/map/utils/mapSettings.dart';
import 'package:kartograph/features/map/widgets/round_button.dart';
import 'package:latlong2/latlong.dart';

/// экран добавления места
class MapAddingScreen extends ElementaryWidget<IMapAddingWidgetModel> {
  /// standard consctructor for elem
  MapAddingScreen({
    required LatLng coordinates,
    Key? key,
  }) : super(mapAddingWidgetModelFactoryWithParams(coordinates), key: key);

  @override
  Widget build(IMapAddingWidgetModel wm) {
    return Scaffold(
      appBar: _MapAddingAppbar(
        pop: wm.pop,
        create: wm.create,
      ),
      body: StateNotifierBuilder<Marker>(
        listenableState: wm.marker,
        builder: (ctx, value) {
          return FlutterMap(
            options: MapOptions(
              onTap: (tapPositon, latlng) => wm.onTap(latlng),
              zoom: ProjectMapSettings.zoom,
              interactiveFlags: ProjectMapSettings.interactiveFlags,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: wm.getMapUrl(),
              ),
              MarkerLayerOptions(markers: (value != null) ? [value] : []),
            ],
            nonRotatedChildren: [
              FractionallySizedBox(
                alignment: Alignment.topCenter,
                widthFactor: 1,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Theme.of(ctx).primaryColorDark,
                  child: Text(
                    ProjectStrings.mapAddHint,
                    textAlign: TextAlign.center,
                    style: Theme.of(ctx).textTheme.bodySmall,
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
                    onPressed: wm.getCurrentGeolocation,
                  ),
                ),
              ),
            ],
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

// ignore: prefer_mixin
class _MapAddingAppbar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback pop;
  final VoidCallback create;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _MapAddingAppbar({required this.pop, required this.create, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Center(
        child: TextButton(
          onPressed: pop,
          child: Text(
            ProjectStrings.cancel,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
      leadingWidth: 106,
      title: Center(
        child: Text(
          ProjectStrings.location,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      actions: [
        TextButton(
          onPressed: create,
          child: Text(
            ProjectStrings.ready,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
