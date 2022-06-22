import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/place_adding/domain/entity_place.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen_wm.dart';
import 'package:kartograph/features/place_adding/widgets/custom_text_field.dart';
import 'package:kartograph/features/place_adding/widgets/locked_button.dart';
import 'package:kartograph/features/place_adding/widgets/selector.dart';

/// экран добавления места
class PlaceAddingScreen extends ElementaryWidget<IPlaceAddingWidgetModel> {
  /// standard consctructor for elem
  PlaceAddingScreen({
    required EntityPlace place,
    Key? key,
  }) : super(placeAddingWidgetModelFactoryWithParams(place), key: key);

  @override
  Widget build(IPlaceAddingWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            wm.isChange ? ProjectStrings.change : ProjectStrings.newPlace,
            style: const TextStyle(
              color: ProjectColors.textColorPrimary,
              fontSize: 16,
            ),
          ),
        ),
        leading: TextButton(
          style: TextButton.styleFrom(
            primary: ProjectColors.textColorGrey,
          ),
          onPressed: wm.pop,
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
                      StateNotifierBuilder<Categories>(
                        listenableState: wm.currentTypeState,
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
                      TextButton(
                        onPressed: wm.moveToMap,
                        child: const Text(
                          ProjectStrings.show,
                          style: TextStyle(
                            color: ProjectColors.mainGreenColor,
                            fontSize: 20,
                          ),
                        ),
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
      style: const TextStyle(color: ProjectColors.textColorGrey, fontSize: 16),
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
