import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen_wm.dart';

class PlaceAddingScreen extends ElementaryWidget<IPlaceAddingWidgetModel> {
  /// standard consctructor for elem
  const PlaceAddingScreen({
    Key? key,
    WidgetModelFactory wmFactory = placeAddingWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final String test = 'One';

  @override
  Widget build(IPlaceAddingWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            ProjectStrings.newPlace,
            style: const TextStyle(
                color: ProjectColors.textColorGrey, fontSize: 16),
          ),
        ),
        leading: TextButton(
          onPressed: () {},
          child: const Text(ProjectStrings.cancel),
        ),
        leadingWidth: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PlaceTitles(
              titleText: ProjectStrings.category,
            ),
            DropdownButton<String>(
              value: test,
              icon: SvgPicture.asset(
                ProjectIcons.view,
                color: ProjectColors.mainLightTheme,
              ),
              isExpanded: true,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {},
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 24,
            ),
            _PlaceTitles(
              titleText: ProjectStrings.name,
            ),
            _textInput(),
            _PlaceTitles(
              titleText: ProjectStrings.description,
            ),
            _textInput(
              lines: 4,
            ),
            _coordinates(),
            TextButton(
              onPressed: () {},
              child: Text(
                ProjectStrings.show,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(child: Container()),
            _AddPlaceButton(),
          ],
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

class _coordinates extends StatelessWidget {
  const _coordinates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlaceTitles(
                titleText: ProjectStrings.latitude,
              ),
              _textInput(),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlaceTitles(
                titleText: ProjectStrings.longitude,
              ),
              _textInput(),
            ],
          ),
        ),
      ],
    );
  }
}

class _AddPlaceButton extends StatelessWidget {
  const _AddPlaceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: ProjectColors.textColorGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              ProjectStrings.create,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}

class _textInput extends StatelessWidget {
  final int lines;

  const _textInput({this.lines = 1, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: ProjectStrings.hint,
        hintStyle:
            TextStyle(fontSize: 16.0, color: ProjectColors.textColorGrey),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
      minLines: lines,
      maxLines: lines,
    );
  }
}
