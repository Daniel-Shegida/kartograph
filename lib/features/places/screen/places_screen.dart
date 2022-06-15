import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:kartograph/features/places/screen/places_screeen_wm.dart';

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
        title: const _SearchTextInput(),
      ),
      body:

      StateNotifierBuilder<List<Place>>(
        listenableState: wm.places,
        builder: (ctx, value) {
          return ListView.builder(
            itemCount: value!.length,
            itemBuilder: (context, index) {
              return _PlacesCard(cardText: value[index].name, cardColor: Colors.green, cardPlaceType: value[index].placeType,);
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

  const _PlacesCard({required this.cardColor, required this.cardText, required this.cardPlaceType, Key? key})
      : super(key: key);

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

  Color func(String type){
    switch(type){
      case ProjectStrings.
    }
    return Colors.white;
  }
}

class _SearchTextInput extends StatelessWidget {
  const _SearchTextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: ProjectColors.searchColor, borderRadius: BorderRadius.circular(5),),
          child: const Center(
            child: TextField(
              decoration: InputDecoration(
                  hintText: ProjectStrings.search, border: InputBorder.none,),
            ),
          ),
        ),
        Align(alignment: Alignment.centerRight, child: _FilterBtn(onPressed: () {  },)),
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
