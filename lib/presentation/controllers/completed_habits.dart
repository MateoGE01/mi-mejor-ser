// lib/presentation/controllers/completed_habits.dart
import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/repositories/user_repository.dart';

class CompletedHabitsController extends GetxController {
  final User user;
  final UserRepository userRepository = Get.find<UserRepository>();

  var level = 0.obs;
  var experience = 0.obs;

  CompletedHabitsController(this.user) {
    level.value = user.level;
    experience.value = user.experience;
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
    user.experience = experience.value;
    userRepository.updateUser(user); // Actualizado para usar el repositorio
  }

  void saveUserData() {
    user.level = level.value;
    user.experience = experience.value;
    userRepository.updateUser(user); // Actualizado para usar el repositorio
  }

  @override
  void onClose() {
    saveUserData();
    super.onClose();
  }
}