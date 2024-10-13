// Mateo: Aquí se irá sumando cuando se marque como completado un habit, tal vez sirva de algo, no sé gg
import 'package:get/get.dart';

class CompletedHabitsController extends GetxController {
  final _completedHabitsTotal = 0.obs; // Variable stores the total of completed habits
  int get completedHabitsTotal => _completedHabitsTotal.value;

  final _experienceGained = 0.obs; // Variable stores the experience gained
  int get experienceGained => _experienceGained.value;

  static const int limitExperience = 20; // Variable stores the limit of experience to level up
  int _limitExperience = limitExperience;

  final _level = 1.obs; // Variable stores the level of the user
  int get level => _level.value;

  // Function adds one to the total of completed habits
  void addCompletedHabit() {
    // Tal vez lo use después
    _completedHabitsTotal.value++;
  }

  // Function gives experience to the user when a habit is completed
  int givingExperiencePerHabit(int timesPerDay) {
    const int baseExperience = 5;
    int bonusExperience = (timesPerDay / 2).round();
    int experiencia = baseExperience + bonusExperience;
    _experienceGained.value += experiencia;
    checkLevelUp();
    return _experienceGained.value;
  }

  // Function to check if the user has enough experience to level up
  int checkLevelUp() {
    if (_experienceGained.value >= _limitExperience) {
      _level.value++;
      _experienceGained.value -= _limitExperience;
      _limitExperience += 50;
    }
    return _level.value;
  }
}
