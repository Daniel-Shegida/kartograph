// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_place_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutPlaceResponse _$PutPlaceResponseFromJson(Map<String, dynamic> json) =>
    PutPlaceResponse(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      name: json['name'] as String,
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      placeType: json['placeType'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$PutPlaceResponseToJson(PutPlaceResponse instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'urls': instance.urls,
      'placeType': instance.placeType,
      'description': instance.description,
    };
