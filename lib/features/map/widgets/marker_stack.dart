// import 'package:flutter/material.dart';
// import 'package:kartograph/api/domain/place.dart';
// import 'package:kartograph/assets/enums/categories.dart';
// import 'package:kartograph/features/map/widgets/marker.dart';
// import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
// import 'package:latlng/latlng.dart';
// import 'package:map/map.dart';
// import 'package:routemaster/routemaster.dart';
//
// /// виджет, что подготавливает стек маркеров для карты
// class MarkersStack extends StatefulWidget {
//   /// Map controller.
//   final MapController controller;
//
//   /// Map transformer
//   final MapTransformer transformer;
//
//   /// маркеры на карие
//   final List<Place> markers;
//
//   /// MarkersStack constructor.
//   const MarkersStack({
//     required this.controller,
//     required this.transformer,
//     required this.markers,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _MarkersStackState();
// }
//
// class _MarkersStackState extends State<MarkersStack> {
//   @override
//   void initState() {
//     super.initState();
//     // dispose контроллера в wm
//     widget.controller.addListener(() {
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final markerWidgets = widget.markers.map(
//       (e) {
//         final pos = widget.transformer.fromLatLngToXYCoords(
//           LatLng(e.lat, e.lng),
//         );
//         return TransferMarker(
//           iconData: e.placeType.categoryIcon,
//           color: e.placeType.categoryColor,
//           onPressed: () {
//             if (e.placeType != Categories.newPlace) {
//               Routemaster.of(context).push(
//                 '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.changingPlaceScreen}${e.id}',
//                 queryParameters: {
//                   'category': e.placeType.name,
//                   'name': e.name,
//                   'description': e.description,
//                   'lat': e.lat.toString(),
//                   'lng': e.lng.toString(),
//                 },
//               );
//             }
//           },
//         );
//       },
//     ).toList();
//     return Stack(children: markerWidgets);
//   }
// }
