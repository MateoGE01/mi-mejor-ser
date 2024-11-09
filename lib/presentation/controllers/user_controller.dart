import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/use_case/user_usecases.dart';

class UserController extends GetxController {
  final RegisterUser registerUserUseCase;
  final LoginUser loginUserUseCase;

  UserController({
    required this.registerUserUseCase,
    required this.loginUserUseCase
  });

  Future<void> registerUser(User user) async {
    await registerUserUseCase.call(user);
  }

  Future<User?> loginUser(String username, String password) async {
    return await loginUserUseCase.call(username, password);
  }
}