import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:mvvm_architecture_template/core/constants/storage_keys.dart';

@LazySingleton()
class TokenInterceptor extends Interceptor {
  final GetStorage getStorage;
  TokenInterceptor({required this.getStorage});
  // final List<String> noAuthEndpoints = [
  //   AuthUrls.login,
  // ];

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // if (!noAuthEndpoints.contains(options.path)) {
    //   if (getIt<AppConfiguration>().isAuthorized) {
    //     final token = await getIt<LoginRepo>().getToken();
    //     options.headers['Authorization'] = token;
    //   }
    // }
    // ii<Dio>().options.extra.clear();
    super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // If the error is 401 Unauthorized, log out the user
    // if (err.response?.statusCode == 401) {
    //   if (Get.currentRoute != AuthorizationRoutes.loginScreen) {
    //     ii<LoginLogic>().logout();
    //   }
    // }
    super.onError(err, handler);
  }
}
