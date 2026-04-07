import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:mvvm_architecture_template/core/configs/app_configuration.dart';
import 'package:mvvm_architecture_template/core/configs/simple_bloc_observer.dart';
import 'package:mvvm_architecture_template/core/hive/hive_database.dart';
import 'package:mvvm_architecture_template/core/routes/app_routes.dart';
import 'package:mvvm_architecture_template/core/translations/my_translations_config.dart';
import 'package:mvvm_architecture_template/injectable_config.dart';
import 'package:mvvm_architecture_template/theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bloc.Bloc.observer = SimpleBlocObserver();
  configureDependencies(Environment.dev);
  // HiveDatabase uses flutter_secure_storage (hardware-backed) internally;
  // no prerequisite init needed before it.
  await HiveDatabase.init();
  await GetStorage.init();
  getIt<AppConfiguration>().init();
  await initializeDateFormatting('en', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MVVM Architecture Template',
      scrollBehavior: _MyCustomScrollBehavior(),
      enableLog: true,
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale ?? const Locale('en', 'US'),
      fallbackLocale: Get.deviceLocale ?? const Locale('en', 'US'),
      translations: MyTranslationsConfig(),
      defaultTransition:
          (kIsWeb) ? Transition.noTransition : Transition.cupertino,
      routingCallback: (value) {},
      theme: context.lightTheme,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: AppRoutes.splashRoute,
    );
  }
}

class _MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
