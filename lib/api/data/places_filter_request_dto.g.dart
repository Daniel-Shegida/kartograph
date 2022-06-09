// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_filter_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesFilterRequestDto _$PlacesFilterRequestDtoFromJson(
        Map<String, dynamic> json) =>
    PlacesFilterRequestDto(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      radius: (json['radius'] as num).toDouble(),
      typeFilter: (json['typeFilter'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nameFilter: json['nameFilter'] as String,
    );

Map<String, dynamic> _$PlacesFilterRequestDtoToJson(
        PlacesFilterRequestDto instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'radius': instance.radius,
      'typeFilter': instance.typeFilter,
      'nameFilter': instance.nameFilter,
    };
