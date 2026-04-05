import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvvm_architecture_template/core/hive/hive_boxes.dart';

class HiveDatabase {
  static Future<void> init() async {
    await Hive.initFlutter();
    // await adapterRegistration();
    await publicBoxes();
  }

  // static Future<void> adapterRegistration() async {}

  static Future<void> publicBoxes() async {
    await Hive.openBox(HiveBoxes.authorization);
    await Hive.openBox(HiveBoxes.userInfo);
  }
}
