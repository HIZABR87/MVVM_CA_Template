import 'package:dio/dio.dart';
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
  @lazySingleton
  GetStorage get getStorage => GetStorage();
}
