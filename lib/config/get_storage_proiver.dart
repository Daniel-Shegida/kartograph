import 'package:get_storage/get_storage.dart';

/// Позволяет получить [GetStorage] для конкретных нужд
class GetStorageProvider {
  final _getStorage = GetStorage();
  final _lastCordsStorage = GetStorage('_lastCordsStorage');

  GetStorage get lastCordsStorage => _lastCordsStorage;

  Future<void> init() {
    return Future.wait([
      _getStorage.initStorage,
      _lastCordsStorage.initStorage,
    ]);
  }
}
