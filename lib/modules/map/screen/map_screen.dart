import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartograph/modules/map/screen/map_screen_wm.dart';

/// Main Screen
class MapScreen extends ElementaryWidget<IMapWidgetModel> {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // возможно стоило разделить это в виджеты или приватные виджеты
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            ],
          ),
        ));
  }
}

class _FloatingNumberScreenButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const _FloatingNumberScreenButton({
    Key? key,
    required this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'send',
      child: Icon(iconData),
    );
  }
}
