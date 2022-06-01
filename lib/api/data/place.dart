// {"id":0,
// "lat":56.8490809,
// "lng":53.247786,
// "name":"Тестовое задание",
// "urls":["https://test-backend-flutter.surfstudio.ru/files/1631212257609.jpg"],
// "placeType":"other","description":"Описание тестового места"}

import 'package:json_annotation/json_annotation.dart';

class Place {
  Place({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  int id;
  double lat;
  double lng;
  String name;
  List<String> urls;
  String placeType;
  String description;
}
