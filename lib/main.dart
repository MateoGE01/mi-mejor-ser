import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mi_mejor_ser/data/services/hive_config.dart';
import 'package:mi_mejor_ser/domain/models/pending_operation.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/repositories/user_repository.dart';
import 'package:mi_mejor_ser/domain/use_case/user_usecases.dart';
import 'package:mi_mejor_ser/presentation/controllers/user_controller.dart';
import 'package:mi_mejor_ser/presentation/pages/login_page.dart';
import 'package:mi_mejor_ser/presentation/pages/register_page.dart';
import 'package:mi_mejor_ser/presentation/pages/habit_page.dart';

import 'data/repositories/user_repository_impl.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializa Hive
  await HiveConfig.init();

 // Obtén las cajas ya abiertas
  final userBox = Hive.box<User>('users');
  final pendingOperationsBox = Hive.box<PendingOperation>('pending_operations');


  // Configura los use cases y el controlador de usuario
  final userRepository = UserRepositoryImpl(userBox, pendingOperationsBox); // Actualizado
  final registerUser = RegisterUser(userRepository);
  final loginUser = LoginUser(userRepository);
  
  // Registrar UserRepository en GetX
  Get.put<UserRepository>(userRepository);

  // Sincronizar datos al iniciar
  await userRepository.synchronizeData();

  Get.put<UserController>(
    UserController(
      registerUserUseCase: registerUser,
      loginUserUseCase: loginUser,
    ),
  );

// Iniciar escucha de cambios remotos y conectividad
  userRepository.listenToRemoteChanges();
  userRepository.listenToConnectivityChanges();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mi Mejor Ser',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        // Ruta nombrada para HabitPage
        GetPage(
          name: '/habit',
          page: () => HabitPage(user: Get.arguments),
        ),
      ],
    );
  }
}
