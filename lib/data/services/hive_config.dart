// Importaciones
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/models/pending_operation.dart';

class HiveConfig {
  static Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);

    // Registrar adaptadores
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(HabitAdapter());
    Hive.registerAdapter(OperationTypeAdapter()); // Añadido
    Hive.registerAdapter(PendingOperationAdapter());

    // Abrir todas las cajas necesarias
    await Hive.openBox<User>('users');
    await Hive.openBox<PendingOperation>('pending_operations');
  }
}