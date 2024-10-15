import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/presentation/controllers/completed_habits.dart';

class ExperienceProgressBar extends StatelessWidget {
  final CompletedHabitsController completedHabitsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double progress = completedHabitsController.experienceGained /
          completedHabitsController.limitExperience;
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Bordes redondeados
            child: Container(
              width: 100, // Ajusta el ancho según sea necesario
              height: 10, // Altura de la barra de progreso
              decoration: BoxDecoration(
                color: Colors.grey[300], // Color de fondo fijo
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'EXP: ${completedHabitsController.experienceGained} / ${completedHabitsController.limitExperience}',
            style: TextStyle(fontSize: 12),
          ),
        ],
      );
    });
  }
}