import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<void> call(User user) async {
    return await repository.registerUser(user);
  }
}

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<User?> call(String username, String password) async {
    return await repository.loginUser(username, password);
  }
}