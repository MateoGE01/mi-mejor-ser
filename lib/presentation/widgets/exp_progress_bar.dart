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
            borderRadius: BorderRadius.circular(20), // Bordes redondeados
            child: Container(
              width: 100, // Ajusta el ancho según sea necesario
              height: 10, // Altura de la barra de progreso
              decoration: BoxDecoration(
                color: Colors.grey[300], // Color de fondo fijo
                border: Border.all(
                  color: Colors.black, // Color del borde
                  width: 1.5, // Ancho del borde
                ),
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromRGBO(247, 214, 224, 1),
                            const Color.fromRGBO(242, 181, 212, 1),
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
