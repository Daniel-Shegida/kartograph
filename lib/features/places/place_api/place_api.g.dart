// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://test-backend-flutter.surfstudio.ru/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<PlaceResponse>> getPlaces(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'count': id};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PlaceResponse>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'place',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => PlaceResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> postPlace(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'place',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<PlaceResponse> getPlace(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PlaceResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'place/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaceResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlaceResponse> deletePlace(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PlaceResponse>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'place/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaceResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlaceResponse> putPlace(id, body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PlaceResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'place/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaceResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
