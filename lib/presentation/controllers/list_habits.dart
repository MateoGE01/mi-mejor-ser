import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:intl/intl.dart';

class HabitsController extends GetxController {
  final User user;
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

  void addHabit(String date, String name, int timesPerDay, String frequency) {
    final newHabit = Habit(
      name: name,
      timesPerDay: timesPerDay,
      frequency: frequency,
      startDate: DateFormat.yMMMMd().parse(date),
    );
    habits.add(newHabit);
    updateUserHabits();
  }

  List<Habit> getHabitsForDate(String date) {
    List<Habit> habitsForDate = [];
    for (var habit in habits) {
      if (habitAppliesToDate(habit, date)) {
        habitsForDate.add(habit);
      }
    }
    return habitsForDate;
  }

  bool habitAppliesToDate(Habit habit, String currentDate) {
    DateTime startDate = habit.startDate ?? DateTime.now();
    DateTime current = DateFormat.yMMMMd().parse(currentDate);

    switch (habit.frequency) {
      case 'Daily':
        return !current.isBefore(startDate);
      case 'Weekly':
        return !current.isBefore(startDate) &&
            current.difference(startDate).inDays % 7 == 0;
      case 'Monthly':
        return !current.isBefore(startDate) && current.day == startDate.day;
      case 'Only Today':
        return current.isAtSameMomentAs(startDate);
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
    user.save();
  }

  void saveUserData() {
    user.habits = List<Habit>.from(habits);
    user.save();
  }

  @override
  void onClose() {
    saveUserData();
    super.onClose();
  }
}