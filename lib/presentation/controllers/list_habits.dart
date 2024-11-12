// lib/presentation/controllers/list_habits.dart
import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/repositories/user_repository.dart';

class HabitsController extends GetxController {
  final User user;
  final UserRepository userRepository = Get.find<UserRepository>();

  RxList<Habit> habits = <Habit>[].obs;

  HabitsController(this.user) {
    // Inicializa los hábitos del usuario
    habits.value = List<Habit>.from(user.habits);
  }

  List<Habit> get predefinedHabits => [
        Habit(name: 'Exercise'),
        Habit(name: 'Drink Water'),
        Habit(name: 'Read a Book'),
        Habit(name: 'Meditate'),
        Habit(name: 'Walk the Dog'),
        Habit(name: 'Brush Teeth'),
        Habit(name: 'Practice a Hobby'),
      ];

  void addHabit(DateTime date, String name, int timesPerDay, String frequency) {
    final newHabit = Habit(
      name: name,
      timesPerDay: timesPerDay,
      frequency: frequency,
      startDate: date, // Usar directamente el objeto DateTime
    );
    habits.add(newHabit);
    updateUserHabits();
  }

  List<Habit> getHabitsForDate(DateTime currentDate) {
    List<Habit> habitsForDate = [];
    for (var habit in habits) {
      if (habitAppliesToDate(habit, currentDate)) {
        habitsForDate.add(habit);
      }
    }
    return habitsForDate;
  }

  bool habitAppliesToDate(Habit habit, DateTime currentDate) {
    DateTime startDate = habit.startDate ?? DateTime.now();
    switch (habit.frequency) {
      case 'Daily':
        return !currentDate.isBefore(startDate);
      case 'Weekly':
        return !currentDate.isBefore(startDate) &&
            currentDate.difference(startDate).inDays % 7 == 0;
      case 'Monthly':
        return !currentDate.isBefore(startDate) && currentDate.day == startDate.day;
      case 'Only Today':
        return currentDate.isAtSameMomentAs(startDate);
      default:
        return false;
    }
  }

  void deleteHabit(int index) {
    habits.removeAt(index);
    updateUserHabits();
  }

  void updateUserHabits() {
    user.habits = List<Habit>.from(habits);
    userRepository.updateUser(user); // Actualizado para usar el repositorio
  }

  void saveUserData() {
    user.habits = List<Habit>.from(habits);
    userRepository.updateUser(user); // Actualizado para usar el repositorio
  }

  @override
  void onClose() {
    saveUserData();
    super.onClose();
  }
}