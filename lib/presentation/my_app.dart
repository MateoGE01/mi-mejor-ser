import 'package:flutter/material.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/presentation/pages/habit_page.dart';

class MyApp extends StatelessWidget {
  final User user;

  const MyApp({super.key, required this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Mejor Ser',
      debugShowCheckedModeBanner: false,
      home: HabitPage(user: user),
    );
  }
}
