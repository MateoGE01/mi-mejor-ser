import 'package:hive/hive.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Box<User> userBox;

  UserRepositoryImpl(this.userBox);

  @override
  Future<void> registerUser(User user) async {
    if (userBox.containsKey(user.username)) {
      throw Exception('Username already exists');
    }
    await userBox.put(user.username, user);
  }

  @override
  Future<User?> loginUser(String username, String password) async {
    final user = userBox.get(username);
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }
}