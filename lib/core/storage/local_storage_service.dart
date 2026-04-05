import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

abstract class LocalStorageService {
  Future<void> write(String key, dynamic value);
  T? read<T>(String key);
  Future<void> remove(String key);
}

@LazySingleton(as: LocalStorageService)
class LocalStorageServiceImp implements LocalStorageService {
  final GetStorage _getStorage;

  LocalStorageServiceImp(this._getStorage);

  @override
  Future<void> write(String key, dynamic value) async {
    await _getStorage.write(key, value);
  }

  @override
  T? read<T>(String key) {
    return _getStorage.read<T>(key);
  }

  @override
  Future<void> remove(String key) async {
    await _getStorage.remove(key);
  }
}
