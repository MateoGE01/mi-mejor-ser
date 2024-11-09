import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mi_mejor_ser/data/services/hive_config.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/use_case/user_usecases.dart';
import 'package:mi_mejor_ser/presentation/controllers/user_controller.dart';
import 'package:mi_mejor_ser/presentation/pages/login_page.dart';
import 'package:mi_mejor_ser/presentation/pages/register_page.dart';
import 'package:mi_mejor_ser/presentation/pages/habit_page.dart';

import 'data/repositories/user_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Hive
  await HiveConfig.init();

  // Abre la caja de usuarios
  final userBox = await Hive.openBox<User>('users');

  // Configura los use cases y el controlador de usuario
  final userRepository = UserRepositoryImpl(userBox);
  final registerUser = RegisterUser(userRepository);
  final loginUser = LoginUser(userRepository);

  Get.put<UserController>(
    UserController(
      registerUserUseCase: registerUser,
      loginUserUseCase: loginUser,
    ),
  );

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
