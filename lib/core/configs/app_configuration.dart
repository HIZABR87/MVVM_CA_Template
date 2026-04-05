import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class AppConfiguration {
  late bool _isAuthorized;
  late String _appVersion;

  void init() async {
    initAuthorized();
    _appVersion = await getAppVersion();
  }

  void initAuthorized() async {
    // _isAuthorized = getIt<GetAuthHive>().getAuthorized();
    _isAuthorized = false;
  }

  bool get isAuthorized => _isAuthorized;
  String get appVersion => _appVersion;

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    return version;
  }
}
