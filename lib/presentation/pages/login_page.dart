import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de importar Get si lo estás usando
// Importa tu controlador de usuario
import 'package:mi_mejor_ser/presentation/controllers/user_controller.dart';
import 'package:mi_mejor_ser/presentation/pages/habit_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final userController = Get.find<UserController>(); // Asumiendo que estás usando GetX

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loginUser(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Por favor, ingresa tu usuario y contraseña');
      return;
    }

    try {
      final user = await userController.loginUser(username, password);
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HabitPage(user: user)),
        );
      } else {
        Get.snackbar('Error', 'Usuario o contraseña inválidos');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al iniciar sesión: $e');
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
              // Botón de inicio de sesión
              ElevatedButton(
                onPressed: () => _loginUser(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              // Botón de registro
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: Text(
                  '¿No tienes cuenta? Regístrate',
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