import 'package:flutter/material.dart';
import 'package:mi_mejor_ser/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mi Mejor Ser',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
