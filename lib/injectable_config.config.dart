// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mvvm_architecture_template/core/api/dio_client.dart' as _i527;
import 'package:mvvm_architecture_template/core/api/dio_client_impl.dart'
    as _i342;
import 'package:mvvm_architecture_template/core/configs/app_configuration.dart'
    as _i378;
import 'package:mvvm_architecture_template/core/configs/configuration.dart'
    as _i1051;
import 'package:mvvm_architecture_template/core/interceptors/logging_interceptor.dart'
    as _i514;
import 'package:mvvm_architecture_template/core/interceptors/token_interceptor.dart'
    as _i339;
import 'package:mvvm_architecture_template/core/permissions/permission_manager.dart'
    as _i1065;
import 'package:mvvm_architecture_template/core/storage/local_storage_service.dart'
    as _i127;
import 'package:mvvm_architecture_template/core/storage/token_service.dart'
    as _i983;
import 'package:mvvm_architecture_template/injectable_modules.dart' as _i947;

const String _staging = 'staging';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    final utilsModule = _$UtilsModule();
    gh.lazySingleton<_i514.LoggingInterceptor>(
        () => _i514.LoggingInterceptor());
    gh.lazySingleton<_i1065.PermissionManager>(
        () => _i1065.PermissionManager());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dioInstance);
    gh.lazySingleton<_i361.CancelToken>(() => networkModule.compute());
    gh.lazySingleton<_i792.GetStorage>(() => utilsModule.getStorage);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => utilsModule.secureStorage);
    gh.lazySingleton<_i127.LocalStorageService>(
        () => _i127.LocalStorageServiceImp(gh<_i792.GetStorage>()));
    gh.lazySingleton<_i1051.Configuration>(
      () => _i1051.StagingConfiguration(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i983.ITokenService>(() => _i983.TokenServiceImpl());
    gh.lazySingleton<_i1051.Configuration>(
      () => _i1051.DevConfiguration(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i1051.Configuration>(
      () => _i1051.ProductionConfiguration(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i378.AppConfiguration>(
        () => _i378.AppConfiguration(gh<_i983.ITokenService>()));
    gh.lazySingleton<_i527.IDioClient>(
        () => _i342.DioClient(client: gh<_i361.Dio>()));
    gh.lazySingleton<_i339.TokenInterceptor>(() => _i339.TokenInterceptor(
          gh<_i983.ITokenService>(),
          gh<_i361.Dio>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i947.NetworkModule {}

class _$UtilsModule extends _i947.UtilsModule {}
