import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/presentation/controllers/completed_habits.dart';

class ExperienceProgressBar extends StatelessWidget {
  final int experience;
  final int level;

  ExperienceProgressBar({
    Key? key,
    required this.experience,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = experience /
        100; // Suponiendo que 100 es la experiencia máxima por nivel

    return Container(
      height: 20,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0), // Asegura que esté entre 0 y 1
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
