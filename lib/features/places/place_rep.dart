import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/api/data/place_responce.dart';
import 'package:kartograph/features/places/place_api/example.dart';
import 'package:kartograph/features/places/place_api/example2.dart';
import 'package:kartograph/features/places/place_api/place_api.dart';
import 'package:kartograph/features/places/place_api/task.dart';

class PlaceRepository {
  PlaceRepository(this._placeRepositoryApi);

  final RestClient _placeRepositoryApi;

  /// Получает тест с сервера и маппит в доменные модели
  Future<List<PlaceResponse> > getTest(int testId) async {
    final List<PlaceResponse> testResponse = await _placeRepositoryApi.getTasks(
    );

    return testResponse;

  }

}
