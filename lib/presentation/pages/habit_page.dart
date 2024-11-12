// lib/presentation/pages/habit_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/presentation/controllers/completed_habits.dart';
import 'package:mi_mejor_ser/presentation/controllers/list_habits.dart';
import 'package:mi_mejor_ser/presentation/widgets/exp_progress_bar.dart';
import 'package:mi_mejor_ser/presentation/widgets/habit.dart';
import 'package:mi_mejor_ser/presentation/widgets/add_habit_box.dart';
import 'package:intl/intl.dart';

class HabitPage extends StatefulWidget {
  final User user;

  const HabitPage({Key? key, required this.user}) : super(key: key);

  @override
  _HabitPageState createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  late HabitsController habitsController;
  late CompletedHabitsController completedHabitsController;

  final TextEditingController _newHabitDialogController =
      TextEditingController();
  final TextEditingController _timesPerDayDialogController =
      TextEditingController();

  DateTime currentDate = DateTime.now();
  String? selectedFrequency = 'Daily';

  @override
  void initState() {
    super.initState();
    habitsController = HabitsController(widget.user);
    completedHabitsController = CompletedHabitsController(widget.user);

    // Registrar los controladores en GetX
    Get.put<HabitsController>(habitsController);
    Get.put<CompletedHabitsController>(completedHabitsController);
  }

  String getFormattedDate() {
    return DateFormat.yMMMMd().format(currentDate); // Solo para display
  }

  void previousDay() {
    setState(() {
      currentDate = currentDate.subtract(const Duration(days: 1));
    });
  }

  void nextDay() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 1));
    });
  }

  void addHabitAction() {
    setState(() {
      habitsController.addHabit(
        currentDate, // Pasar DateTime directamente
        _newHabitDialogController.text,
        int.tryParse(_timesPerDayDialogController.text) ?? 1,
        selectedFrequency ?? 'Daily',
      );
    });
    _newHabitDialogController.clear();
    _timesPerDayDialogController.clear();
  }

  void cancelAction() {
    setState(() {
      _newHabitDialogController.clear();
      _timesPerDayDialogController.clear();
      Navigator.of(context).pop();
      selectedFrequency = 'Daily';
    });
  }

  void createHabit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewHabitDialog(
          nameController: _newHabitDialogController,
          timesPerDayController: _timesPerDayDialogController,
          onAdd: addHabitAction,
          onCancel: cancelAction,
          onFrequencyChanged: (String frequency) {
            setState(() {
              selectedFrequency = frequency;
            });
          },
        );
      },
    );
  }

  void checkBoxTap(bool? value, int index) {
    setState(() {
      final habit =
          habitsController.getHabitsForDate(currentDate)[index];

      if (value == true) {
        habit.currentCount++;

        if (habit.currentCount >= habit.timesPerDay) {
          habit.completed = true;
          completedHabitsController.addCompletedHabit();
          completedHabitsController
              .givingExperiencePerHabit(habit.timesPerDay);
        }
      } else {
        if (habit.currentCount > 0) {
          habit.currentCount--;

          if (habit.completed && habit.currentCount < habit.timesPerDay) {
            habit.completed = false;
            // Aquí podrías restar experiencia si es necesario
          }
        }
      }

      // Actualizar el estado del usuario y guardar a través del repositorio
      habitsController.updateUserHabits();
      completedHabitsController.updateUserProgress();
    });
  }

  void deleteHabit(int index) {
    setState(() {
      habitsController.deleteHabit(index);
    });
  }

  void logout() {
    // Guarda los datos del usuario actual antes de cerrar sesión
    habitsController.saveUserData();
    completedHabitsController.saveUserData();

    // Elimina los controladores del contenedor de GetX
    Get.delete<HabitsController>();
    Get.delete<CompletedHabitsController>();

    Navigator.of(context).pushReplacementNamed('/login');
  }

  Color getAuraColor(int level) {
    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.red,
    ];
    return colors[level % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${widget.user.username}'),
        actions: [
          Obx(() {
            Color auraColor =
                getAuraColor(completedHabitsController.level.value);
            return GestureDetector(
              onTap: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(1000, 80, 0, 0),
                  items: [
                    PopupMenuItem(
                      child: Text('Cerrar sesión'),
                      value: 'logout',
                    ),
                  ],
                ).then((value) {
                  if (value == 'logout') {
                    logout();
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: auraColor.withOpacity(0.6),
                      spreadRadius: 4,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createHabit,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Barra de nivel y experiencia
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Obx(() => Text(
                      'Nivel: ${completedHabitsController.level.value}',
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(width: 8),
                Obx(() => ExperienceProgressBar(
                      experience: completedHabitsController.experience.value,
                      level: completedHabitsController.level.value,
                    )),
              ],
            ),
          ),
          // Navegación de fechas
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(247, 214, 224, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left),
                  onPressed: previousDay,
                ),
                Text(
                  getFormattedDate(),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: nextDay,
                ),
              ],
            ),
          ),
          // Lista de hábitos
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: habitsController.getHabitsForDate(currentDate).length,
                itemBuilder: (context, index) {
                  final habit = habitsController.getHabitsForDate(currentDate)[index];
                  return BoolHabit(
                    habitName: habit.name,
                    habitCompleted: habit.completed,
                    timesPerDay: habit.timesPerDay,
                    currentCount: habit.currentCount,
                    onChanged: (value) => checkBoxTap(value, index),
                    onDelete: (context) => deleteHabit(index),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}