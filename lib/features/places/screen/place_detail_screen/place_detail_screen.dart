import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/places/domain/entity_place.dart';
import 'package:kartograph/features/places/screen/place_detail_screen/place_detail_screen_wm.dart';
import 'package:kartograph/features/places/widgets/custom_text_field.dart';
import 'package:kartograph/features/places/widgets/locked_button.dart';
import 'package:kartograph/features/places/widgets/selector.dart';

/// экран добавления места
class PlaceDetailScreen extends ElementaryWidget<IPlaceDetailWidgetModel> {
  /// standard consctructor for elem
  PlaceDetailScreen({
    required EntityPlace place,
    Key? key,
  }) : super(placeDetailWidgetModelFactoryWithParams(place), key: key);

  @override
  Widget build(IPlaceDetailWidgetModel wm) {
    return Scaffold(
      appBar: addingAppbar1(
        pop: wm.pop,
        isChange: wm.isChange,
      ),
      // AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Center(
      //     child: Text(
      //       wm.isChange ? ProjectStrings.change : ProjectStrings.newPlace,
      //       style: const TextStyle(
      //         color: ProjectColors.textColorPrimary,
      //         fontSize: 16,
      //       ),
      //     ),
      //   ),
      //   leading: TextButton(
      //     style: TextButton.styleFrom(
      //       primary: ProjectColors.textColorGrey,
      //     ),
      //     onPressed: wm.pop,
      //     child: const Text(ProjectStrings.cancel),
      //   ),
      //   leadingWidth: 100,
      // ),
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
                      StateNotifierBuilder<Categories>(
                        listenableState: wm.categoriesState,
                        builder: (_, value) {
                          return SelectorWidget(
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
                        builder: (_, value) {
                          return CustomTextField(
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
                        builder: (_, value) {
                          return CustomTextField(
                            lines: 4,
                            isPrepare: value ?? false,
                            controller: wm.describeController,
                          );
                        },
                      ),
                      _CoordsIput(
                        latState: wm.latState,
                        longState: wm.lonState,
                        latController: wm.latController,
                        lonController: wm.lonController,
                      ),
                      _MoveToMapButton(
                        onPressed: wm.moveToMap,
                      ),
                      Expanded(child: Container()),
                      StateNotifierBuilder<bool>(
                        listenableState: wm.readyState,
                        builder: (_, value) {
                          return LockedButton(
                            onPressed: wm.createPlace,
                            isReady: value ?? false,
                            isChange: wm.isChange,
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
      style: Theme.of(context).textTheme.labelMedium,
      textAlign: TextAlign.start,
    );
  }
}

class _CoordsIput extends StatelessWidget {
  final ListenableState<bool> latState;
  final ListenableState<bool> longState;
  final TextEditingController latController;
  final TextEditingController lonController;

  const _CoordsIput({
    required this.latState,
    required this.longState,
    required this.latController,
    required this.lonController,
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
                listenableState: latState,
                builder: (_, value) {
                  return CustomTextField(
                    isPrepare: value ?? false,
                    controller: latController,
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
                listenableState: longState,
                builder: (_, value) {
                  return CustomTextField(
                    isPrepare: value ?? false,
                    controller: lonController,
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

class addingAppbar1 extends StatelessWidget with PreferredSizeWidget {
  VoidCallback pop;
  bool isChange;

  addingAppbar1({required this.pop, required this.isChange, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Center(
        child: Text(
          isChange ? ProjectStrings.change : ProjectStrings.newPlace,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16),
        ),
      ),
      leading: TextButton(
        // style: TextButton.styleFrom(
        //   primary: ProjectColors.textColorGrey,
        // ),
        onPressed: pop,
        child: Text(
          ProjectStrings.cancel,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      leadingWidth: 100,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MoveToMapButton extends StatelessWidget {
  VoidCallback onPressed;

  _MoveToMapButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        ProjectStrings.show,
        style: TextStyle(
          color: Theme.of(context).focusColor,
          fontSize: 20,
        ),
      ),
    );
  }
}
