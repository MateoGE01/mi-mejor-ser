import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/presentation/controllers/completed_habits.dart';
import 'package:mi_mejor_ser/presentation/controllers/list_habits.dart';
import 'package:mi_mejor_ser/presentation/my_app.dart';

void main() {
  Get.put(CompletedHabitsController());
  Get.put(HabitsController());
  runApp(const MyApp());
}
