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
          Container(
            width: 100, // Ajusta el ancho según sea necesario
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              minHeight: 10,
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