import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/presentation/controllers/user_controller.dart';
import 'package:mi_mejor_ser/presentation/pages/habit_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final UserController userController = Get.find();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _registerUser(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios');
      return;
    }

    final user = User(username: username, password: password);

    try {
      await userController.registerUser(user);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HabitPage(user: user)),
      );
    } catch (e) {
      Get.snackbar('Error', 'Error al registrar el usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Color de fondo
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              // Logo o imagen
              SizedBox(
                height: 150,
                width: 150,
                child: ClipOval(
                  child: Image.asset(
                    'lib/presentation/assets/images/Mi_Mejor_Ser_Logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Campo de usuario
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              // Campo de contraseña
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              // Botón de registro
              ElevatedButton(
                onPressed: () => _registerUser(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white, // Color del texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              // Botón para volver al inicio de sesión
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '¿Ya tienes cuenta? Inicia Sesión',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}