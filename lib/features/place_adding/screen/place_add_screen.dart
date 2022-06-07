import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen_wm.dart';

/// экран добавления места
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            ProjectStrings.newPlace,
            style: TextStyle(
              color: ProjectColors.textColorPrimary,
              fontSize: 16,
            ),
          ),
        ),
        leading: TextButton(
          style: TextButton.styleFrom(
            primary: ProjectColors.textColorGrey,
          ),
          onPressed: () {},
          child: const Text(ProjectStrings.cancel),
        ),
        leadingWidth: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.5),
        child: LayoutBuilder(
          builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PlaceTitles(
                        titleText: ProjectStrings.category,
                      ),
                      StateNotifierBuilder<String>(
                        listenableState: wm.currentState,
                        builder: (ctx, value) {
                          return ChoisesWidget(
                            currentValue: value!,
                            list: wm.choises,
                            onChange: wm.changeType,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const _PlaceTitles(
                        titleText: ProjectStrings.name,
                      ),
                      StateNotifierBuilder<bool>(
                        listenableState: wm.nameState,
                        builder: (ctx, value) {
                          return _textInput(
                            isPrepare: value ?? false,
                            controller: wm.nameController,
                          );
                        },
                      ),
                      const _PlaceTitles(
                        titleText: ProjectStrings.description,
                      ),
                      StateNotifierBuilder<bool>(
                        listenableState: wm.describeState,
                        builder: (ctx, value) {
                          return _textInput(
                            lines: 4,
                            isPrepare: value ?? false,
                            controller: wm.describeController,
                          );
                        },
                      ),
                      _Coordinates(
                        test: wm.latState,
                        test2: wm.lonState,
                        controller1: wm.latController,
                        controller2: wm.lonController,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          ProjectStrings.show,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      StateNotifierBuilder<bool>(
                        listenableState: wm.readyState,
                        builder: (ctx, value) {
                          return _AddPlaceButton(
                            onPressed: wm.createPlace,
                            isReady: value ?? false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlaceTitles extends StatelessWidget {
  final String titleText;

  const _PlaceTitles({required this.titleText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: const TextStyle(color: ProjectColors.textColorGrey, fontSize: 16),
      textAlign: TextAlign.start,
    );
  }
}

class _Coordinates extends StatelessWidget {
  final ListenableState<bool> test;
  final ListenableState<bool> test2;
  final TextEditingController controller1;
  final TextEditingController controller2;

  const _Coordinates({
    required this.test,
    required this.test2,
    required this.controller1,
    required this.controller2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _PlaceTitles(
                titleText: ProjectStrings.latitude,
              ),
              StateNotifierBuilder<bool>(
                listenableState: test,
                builder: (ctx, value) {
                  return _textInput(
                    isPrepare: value ?? false,
                    controller: controller1,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _PlaceTitles(
                titleText: ProjectStrings.longitude,
              ),
              StateNotifierBuilder<bool>(
                listenableState: test2,
                builder: (ctx, value) {
                  return _textInput(
                    isPrepare: value ?? false,
                    controller: controller2,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AddPlaceButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isReady;

  const _AddPlaceButton({
    required this.onPressed,
    required this.isReady,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              ProjectStrings.create,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
        onPressed: isReady ? onPressed : null,
      ),
    );
  }
}

class _textInput extends StatelessWidget {
  final int lines;
  final bool isPrepare;
  final TextEditingController controller;

  const _textInput({
    this.lines = 1,
    required this.isPrepare,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isPrepare ? Colors.green : ProjectColors.textColorGrey,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: ProjectStrings.hint,
        hintStyle:
            const TextStyle(fontSize: 16.0, color: ProjectColors.textColorGrey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
      minLines: lines,
      maxLines: lines,
    );
  }
}

class ChoisesWidget extends StatelessWidget {
  final String currentValue;

  final List<DropdownMenuItem<String>> list;

  final void Function(String?) onChange;

  const ChoisesWidget({
    required this.currentValue,
    required this.list,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentValue,
      icon: SvgPicture.asset(
        ProjectIcons.view,
        color: ProjectColors.mainLightTheme,
      ),
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(color: ProjectColors.textColorGrey),
      underline: Container(
        height: 2,
        color: ProjectColors.textColorGrey,
      ),
      onChanged: onChange,
      items: list,
    );
  }
}
