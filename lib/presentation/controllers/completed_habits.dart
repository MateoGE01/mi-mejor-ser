// Mateo: Aquí se irá sumando cuando se marque como completado un habit, tal vez sirva de algo, no sé gg
import 'package:get/get.dart';

class CompletedHabitsController extends GetxController {
  final _completedHabitsTotal =
      0.obs; // Variable stores the total of completed habits
  int get completedHabitsTotal => _completedHabitsTotal.value;

  final _experienceGained = 0.obs; // Variable stores the experience gained
  int get experienceGained => _experienceGained.value;

  final _limitExperience =
      20.obs; // Variable stores the limit of experience to level up
  int get limitExperience => _limitExperience.value;

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
    if (_experienceGained.value >= _limitExperience.value) {
      _level.value++;
      _experienceGained.value -= _limitExperience.value;
      _limitExperience.value += 50;
    }
    return _level.value;
  }

  String avatarImage() {
    if (_completedHabitsTotal.value > 5 && _completedHabitsTotal.value <= 10) {
      return 'lib/presentation/assets/images/sloth-icon.png';
    } else if (_completedHabitsTotal.value > 10 &&
        _completedHabitsTotal.value <= 15) {
      return 'lib/presentation/assets/images/Raven.png';
    } else if (_completedHabitsTotal.value > 15 &&
        _completedHabitsTotal.value <= 20) {
      return 'lib/presentation/assets/images/Gryffindor.png';
    } else {
      return 'lib/presentation/assets/images/vacaPatineta.jpg';
    }
  }
}
