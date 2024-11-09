import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';

class CompletedHabitsController extends GetxController {
  final User user;
  var level = 0.obs;
  var experience = 0.obs;

  CompletedHabitsController(this.user) {
    level.value = user.level;
    experience.value = user.experience; // Actualizado
  }

  void addCompletedHabit() {
    experience.value += 10; // Ejemplo de aumento de experiencia
    checkLevelUp();
    updateUserProgress();
  }

  void givingExperiencePerHabit(int timesPerDay) {
    experience.value += timesPerDay * 5; // Ejemplo de cálculo de experiencia
    checkLevelUp();
    updateUserProgress();
  }

  void checkLevelUp() {
    while (experience.value >= 100) {
      level.value += 1;
      experience.value -= 100;
    }
  }

  void updateUserProgress() {
    user.level = level.value;
    user.experience = experience.value; // Actualizado
    user.save();
  }

  void saveUserData() {
    user.level = level.value;
    user.experience = experience.value; // Actualizado
    user.save();
  }

  @override
  void onClose() {
    saveUserData();
    super.onClose();
  }
}