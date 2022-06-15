import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/places/screen/places_screeen_wm.dart';

/// экран просмотра существующих мест
class PlacesScreen extends ElementaryWidget<IPlacesWidgetModel> {
  /// standard consctructor for elem
  const PlacesScreen({
    Key? key,
    WidgetModelFactory wmFactory = placesWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlacesWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _SearchTextInput(
          onTap: wm.showPicker,
          controller: wm.controller,
        ),
      ),
      body: StateNotifierBuilder<List<Place>>(
        listenableState: wm.placesListState,
        builder: (ctx, value) {
          return value?.isEmpty ?? false
              ? const _WrongSearchWidget()
              : ListView.builder(
                  itemCount: value!.length,
                  itemBuilder: (context, index) {
                    return _PlacesCard(
                      cardText: value[index].name,
                      cardColor: value[index].placeType.categoryColor,
                      cardPlaceType: value[index].placeType.categoryName,
                    );
                  },
                );
        },
      ),
    );
  }
}

class _PlacesCard extends StatelessWidget {
  final Color cardColor;
  final String cardText;
  final String cardPlaceType;

  const _PlacesCard({
    required this.cardColor,
    required this.cardText,
    required this.cardPlaceType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.circle,
          color: cardColor,
        ),
        title: Text(cardText),
        subtitle: Text(cardPlaceType),
      ),
    );
  }
}

class _SearchTextInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onTap;

  const _SearchTextInput({
    required this.onTap,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: ProjectColors.searchColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: ProjectStrings.search,
                  hintStyle: TextStyle(fontSize: 17.0, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: _FilterBtn(
            onPressed: onTap,
          ),
        ),
      ],
    );
  }
}

class _FilterBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const _FilterBtn({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 40,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          ProjectStrings.filter,
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class _WrongSearchWidget extends StatelessWidget {
  const _WrongSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          ProjectIcons.search,
          color: ProjectColors.textColorGrey,
          semanticsLabel: 'иконка поиска',
          width: 64,
          height: 64,
        ),
        const Text(
          ProjectStrings.wrongSearch,
          style: TextStyle(
            height: 18,
            color: ProjectColors.textColorGrey,
          ),
        ),
        const Text(
          ProjectStrings.wrongSearch2,
          style: TextStyle(
            height: 14,
            color: ProjectColors.textColorGrey,
          ),
        ),
      ],
    );
  }
}
