// Mateo: Aquí se irá sumando cuando se marque como completado un habit, tal vez sirva de algo, no sé gg
import 'package:get/get.dart';

class CompletedHabitsController extends GetxController {
  final _completedHabitsTotal = 0.obs;
  int get completedHabitsTotal => _completedHabitsTotal.value;

  final _experienceGained = 0.obs;
  int get experienceGained => _experienceGained.value;

  // Adds one to the total of completed habits
  void addCompletedHabit() {
    // Tal vez lo use después
    _completedHabitsTotal.value++;
  }

  // Gives experience to the user when a habit is completed
  int givingExperiencePerHabit(int timesPerDay) {
    // Lo cambiaré para que reciba el timesPerDay y según ese dato, de una cantidad especfica de experiencia
    int baseExperience = 5;
    int bonusExperience = (timesPerDay / 2).round();
    int experiencia = baseExperience + bonusExperience;
    return _experienceGained.value += experiencia;
  }
}
