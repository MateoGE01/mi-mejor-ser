// Mateo: Aquí se irá sumando cuando se marque como completado un habit, tal vez sirva de algo, no sé gg
import 'package:get/get.dart';

class CompletedHabitsController extends GetxController {
  final _completedHabitsTotal = 0.obs;// Variable stores the total of completed habits
  int get completedHabitsTotal => _completedHabitsTotal.value;

  final _experienceGained = 0.obs;// Variable stores the experience gained
  int get experienceGained => _experienceGained.value;

  // Function adds one to the total of completed habits
  void addCompletedHabit() {
    // Tal vez lo use después
    _completedHabitsTotal.value++;
  }

  // Function gives experience to the user when a habit is completed
  int givingExperiencePerHabit(int timesPerDay) {
    int baseExperience = 5;
    int bonusExperience = (timesPerDay / 2).round();
    int experiencia = baseExperience + bonusExperience;
    return _experienceGained.value += experiencia;
  }
}