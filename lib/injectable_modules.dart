import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  CancelToken compute() => CancelToken();

  @lazySingleton
  Dio get dioInstance => Dio();
}

@module
abstract class UtilsModule {
  /// Plain GetStorage — used for non-sensitive preferences (e.g. language).
  @lazySingleton
  GetStorage get getStorage => GetStorage();

  /// Hardware-backed secure storage (Android Keystore / iOS Keychain).
  /// The AES-256 Hive encryption key lives here via [HiveDatabase].
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );
}
