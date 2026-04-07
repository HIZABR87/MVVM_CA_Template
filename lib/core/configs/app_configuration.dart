import 'package:injectable/injectable.dart';
import 'package:mvvm_architecture_template/core/storage/token_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class AppConfiguration {
  final ITokenService _tokenService;
  late String _appVersion;

  AppConfiguration(this._tokenService);

  void init() async {
    _appVersion = await _getAppVersion();
  }

  bool get isAuthorized => _tokenService.isAuthenticated;
  String get appVersion => _appVersion;

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
