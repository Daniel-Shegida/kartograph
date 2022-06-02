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
