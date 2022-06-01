import 'package:json_annotation/json_annotation.dart';
import 'package:kartograph/api/data/place.dart';

part 'task.g.dart';

/// Модель темы статьи с сервера
@JsonSerializable()
class PlaceResponse {
  String? id;
  String? name;
  String? avatar;
  String? createdAt;

  PlaceResponse({this.id, this.name, this.avatar, this.createdAt});


  factory PlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceResponseToJson(this);
}


