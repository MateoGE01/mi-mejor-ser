import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/presentation/controllers/user_controller.dart';
import 'package:mi_mejor_ser/presentation/pages/habit_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserController userController = Get.find();

  RegisterPage({Key? key}) : super(key: key);

  void _registerUser(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username and password cannot be empty');
      return;
    }

    final user = User(username: username, password: password);
    try {
      await userController.registerUser(user);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HabitPage(user: user)),
      );
    } catch (e) {
      if (e.toString().contains('Username already exists')) {
        Get.snackbar('Error', 'Username already exists');
      } else {
        Get.snackbar('Error', 'Failed to register user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _registerUser(context),
                child: Text('Register'),
              ),
            ],
          ),
        ));
  }
}
