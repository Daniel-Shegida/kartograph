// // ignore_for_file: implicit_dynamic_parameter
//
// import 'package:dio/dio.dart';
// import 'package:kartograph/api/data/place_responce.dart';
// import 'package:kartograph/api/data/urls.dart';
// import 'package:retrofit/http.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'place_api.g.dart';
//
// // /// Апи для работы с сервером для экрана кариы
// // @RestApi(baseUrl: baseUrl)
// // abstract class PlaceApi {
// //   factory PlaceApi(Dio dio, {String baseUrl}) = _PlaceApi;
// //
// //   @GET(Map.docs)
// //   Future<PlaceResponse> getTest({
// //     @Path('id') int? id,
// //   });
// // }
//
// @RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
// abstract class RestClient {
//   factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
//
//   @GET("/tasks")
//   Future<List<Task>> getTasks();
// }
//
// @JsonSerializable()
// class Task {
//   String? id;
//   String? name;
//   String? avatar;
//   String? createdAt;
//
//   Task({this.id, this.name, this.avatar, this.createdAt});
//
//   factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
//   Map<String, dynamic> toJson() => _$TaskToJson(this);
// }

