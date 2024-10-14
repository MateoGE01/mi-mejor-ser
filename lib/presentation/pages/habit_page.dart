import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/presentation/controllers/completed_habits.dart';
import 'package:mi_mejor_ser/presentation/controllers/list_habits.dart';
import 'package:mi_mejor_ser/presentation/widgets/add_habit_button.dart';
import 'package:mi_mejor_ser/presentation/widgets/exp_progress_bar.dart';
import 'package:mi_mejor_ser/presentation/widgets/habit.dart';
import 'package:mi_mejor_ser/presentation/widgets/add_habit_box.dart';
import 'package:intl/intl.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  // List of habits, this is the controller
  final HabitsController habitsController = Get.find();

  // Controller for the text field in the dialog for adding a new habit for the name
  final TextEditingController _newHabitDialogController =
      TextEditingController();

  // Controller for the text field in the dialog for adding a new habit for the times per day
  final TextEditingController _timesPerDayDialogController =
      TextEditingController();

  // Controller for the list of completed habits
  CompletedHabitsController completedHabitsController = Get.find();

  // Variable to hold the current date
  DateTime currentDate = DateTime.now();

  // Variable to hold the selected frequency
  String? selectedFrequency = 'Daily';

  // Function to format the date
  String getFormattedDate() {
    return DateFormat.yMMMMd().format(currentDate);
  }

  // Function to go back one day
  void previousDay() {
    setState(() {
      currentDate = currentDate.subtract(const Duration(days: 1));
    });
  }

  // Function to go forward one day
  void nextDay() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 1));
    });
  }

  // Function to add a new habit
  void addHabitAction() {
    setState(() {
      habitsController.addHabit(
        getFormattedDate(),
        _newHabitDialogController.text,
        int.tryParse(_timesPerDayDialogController.text) ?? 1,
        selectedFrequency ?? 'Daily',
      );
    });
    _newHabitDialogController.clear();
    _timesPerDayDialogController.clear();
    Navigator.of(context).pop();
  }

  // Function to cancel the action of adding a new habit
  void cancelAction() {
    setState(() {
      // Clear the text field
      _newHabitDialogController.clear();
      _timesPerDayDialogController.clear();
      // Close the dialog
      Navigator.of(context).pop();
    });
  }

  // Function to create a new habit
  void createHabit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return newHabitDialog(
          nameController: _newHabitDialogController,
          timesPerDayController: _timesPerDayDialogController,
          onAdd: addHabitAction,
          onCancel: () {
            Navigator.of(context).pop();
          },
          onFrequencyChanged: (String frequency) {
            setState(() {
              selectedFrequency =
                  frequency; // Actualiza la frecuencia seleccionada
            });
          },
        );
      },
    );
  }

  // Function to handle the tap on the checkbox
  void checkBoxTap(bool? value, int index) {
    setState(() {
      final currentDateHabits =
          habitsController.getHabitsForDate(getFormattedDate());

      if (value == true) {
        currentDateHabits[index]['currentCount']++;

        if (currentDateHabits[index]['currentCount'] ==
            currentDateHabits[index]['timesPerDay']) {
          currentDateHabits[index]['completed'] = true;

          completedHabitsController
              .addCompletedHabit(); //no se usa, esta función lo que hace es sumar 1 a la variable _completedHabitsTotal
          completedHabitsController.givingExperiencePerHabit(
              currentDateHabits[index]['timesPerDay']);
        }
      }
      // Aquí se podría añadir para que se elimine el hábito si se marca como completado
    });
  }

  // Build the widget, this is basically the habits page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Mi Mejor Ser'),
            Obx(() {
              return Row(
                children: [
                  Text(
                    'Nivel: ${completedHabitsController.level}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  ExperienceProgressBar(),
                ],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: addHabitFloatingActionButton(
        onPressed: createHabit,
      ),
      body: ListView.builder(
        itemCount: habitsController.getHabitsForDate(getFormattedDate()).length,
        itemBuilder: (context, index) {
          final habit =
              habitsController.getHabitsForDate(getFormattedDate())[index];
          return BoolHabit(
            habitName: habit['name'],
            habitCompleted: habit['completed'],
            timesPerDay: habit['timesPerDay'],
            currentCount: habit['currentCount'],
            onChanged: (value) => checkBoxTap(value, index),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Button to go back one day
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: previousDay,
            ),
            Text(
              getFormattedDate(),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            // Button to go forward one day
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: nextDay,
            ),
          ],
        ),
      ),
    );
  }
}
