// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/presentation/controllers/user_controller.dart';
import 'package:mi_mejor_ser/presentation/pages/login_page.dart';
import 'package:mi_mejor_ser/presentation/pages/register_page.dart';
import 'package:mi_mejor_ser/presentation/pages/habit_page.dart';
import 'package:mi_mejor_ser/presentation/widgets/exp_progress_bar.dart'; // Asegúrate de importar el widget
import 'package:mi_mejor_ser/domain/repositories/user_repository.dart';
import 'package:mi_mejor_ser/domain/use_case/user_usecases.dart';
import 'package:mockito/mockito.dart';

// Importa los mocks generados
import 'user_controller_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late UserController userController;

  setUp(() {
    mockUserRepository = MockUserRepository();
    final registerUser = RegisterUser(mockUserRepository);
    final loginUser = LoginUser(mockUserRepository);

    userController = UserController(
      registerUserUseCase: registerUser,
      loginUserUseCase: loginUser,
    );

    // Registrar los mocks en GetX
    Get.put<UserRepository>(mockUserRepository);
    Get.put<UserController>(userController);
  });

  tearDown(() {
    Get.reset();
  });

  group('LoginPage Tests', () {
    testWidgets('Verifica presencia de campos y botones en LoginPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: LoginPage(),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Iniciar Sesión'), findsOneWidget);
      expect(find.text('¿No tienes cuenta? Regístrate'), findsOneWidget);
    });

    testWidgets('Iniciar sesión con credenciales válidas',
        (WidgetTester tester) async {
      final testUser =
          User(username: 'test_user', password: 'test_password');
      when(mockUserRepository.loginUser('test_user', 'test_password'))
          .thenAnswer((_) async => testUser);

      await tester.pumpWidget(
        GetMaterialApp(
          home: LoginPage(),
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), 'test_user');
      await tester.enterText(find.byType(TextField).at(1), 'test_password');

      await tester.tap(find.text('Iniciar Sesión'));
      await tester.pumpAndSettle();

      expect(find.byType(HabitPage), findsOneWidget);
    });
  });

  group('RegisterPage Tests', () {
    testWidgets('Registrar usuario con datos válidos',
        (WidgetTester tester) async {
      final testUser =
          User(username: 'new_user', password: 'new_password');

      when(mockUserRepository.registerUser(testUser))
          .thenAnswer((_) async => Future.value());

      await tester.pumpWidget(
        GetMaterialApp(
          home: RegisterPage(),
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), 'new_user');
      await tester.enterText(find.byType(TextField).at(1), 'new_password');

      await tester.tap(find.text('Registrarse'));
      await tester.pumpAndSettle();

      expect(find.byType(HabitPage), findsOneWidget);
    });
  });

  group('HabitPage Tests', () {
    testWidgets('Agregar un nuevo hábito', (WidgetTester tester) async {
      final testUser =
          User(username: 'test_user', password: 'test_password');

      await tester.pumpWidget(
        GetMaterialApp(
          home: HabitPage(user: testUser),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'Leer un libro');
      await tester.enterText(find.byType(TextField).at(1), '1');

      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      expect(find.text('Leer un libro'), findsOneWidget);
    });
  });
}