import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/places/screen/places_screeen_wm.dart';

// class PlacesScreen extends ElementaryWidget<IPlacesWidgetModel> {
//
//   /// standard consctructor for elem
//   const PlacesScreen({
//     Key? key,
//     WidgetModelFactory wmFactory = placesWidgetModelFactory,
//   }) : super(wmFactory, key: key);
//
//   @override
//   Widget build(IPlacesWidgetModel wm) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//       child: Row(
//       children: [
//
//       OutlinedButton(
//       onPressed: () {},
//     child: Text('Button'),
//     style: OutlinedButton.styleFrom(
//     shape: CircleBorder(),
//     padding: EdgeInsets.all(24),
//     ),
//     ),
//     Container(
//     decoration: BoxDecoration(
//     boxShadow: [
//     BoxShadow(
//     color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
//     ],
//     gradient: LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     stops: [0.0, 1.0],
//     colors: [
//     Colors.deepPurple.shade400,
//     Colors.deepPurple.shade200,
//     ],
//     ),
//     color: Colors.deepPurple.shade300,
//     borderRadius: BorderRadius.circular(20),
//     ),
//     child: ElevatedButton(
//     onPressed: () {},
//     child: Row(
//     children: [
//     SvgPicture.asset(
//     "iconAddress",
//     // color: ProjectColors.mainLightTheme,
//
//     ),
//
//     Text('Button'),
//     ],
//     ),
//     style: ButtonStyle(
//     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//     RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(20.0),
//     ),
//     ),
//     // minimumSize: MaterialStateProperty.all(Size(widthdth, 50)),
//     backgroundColor:
//     MaterialStateProperty.all(Colors.transparent),
//     // elevation: MaterialStateProperty.all(3),
//     shadowColor:
//     MaterialStateProperty.all(Colors.transparent),
//     ),
//
//
//     ),
//     ),
//     Container(
//     width: 300,
//     height: 100,
//     decoration: const ShapeDecoration(
//     shape: StadiumBorder(),
//     gradient: LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [Colors.blue, Colors.orange, Colors.green],
//     ),
//     ),
//     child: MaterialButton(
//     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     shape: const StadiumBorder(),
//     child: const Text(
//     'A Samll Button',
//     style: TextStyle(color: Colors.white, fontSize: 20),
//     ),
//     onPressed: () {
//     },
//     ),
//     ),
//     Text("place"),
//     ],
//     ),
//     );
//   }
// }
