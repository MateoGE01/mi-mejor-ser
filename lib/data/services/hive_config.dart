import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:mi_mejor_ser/domain/models/user.dart'; // Importa el modelo de usuario

class HiveConfig {
  static Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
    // Register adapters here
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(HabitAdapter());
  }
}