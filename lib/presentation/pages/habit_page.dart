import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/presentation/controllers/completed_habits.dart';
import 'package:mi_mejor_ser/presentation/controllers/list_habits.dart';
import 'package:mi_mejor_ser/presentation/widgets/add_habit_button.dart';
import 'package:mi_mejor_ser/presentation/widgets/habit.dart';
import 'package:mi_mejor_ser/presentation/widgets/add_habit_box.dart';

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

  // Function to add a new habit
  void addHabitAction() {
    setState(() {
      habitsController.habits.add({
        'name': _newHabitDialogController.text,
        'completed': false,
        'timesPerDay': int.tryParse(_timesPerDayDialogController.text) ?? 1,
        'currentCount': 0,
      });
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
        builder: (context) {
          return newHabitDialog(
            // This is a custom widget
            nameController: _newHabitDialogController,
            timesPerDayController: _timesPerDayDialogController,
            onAdd: addHabitAction,
            onCancel: cancelAction,
          );
        });
  }

  // Controller for the list of completed habits
  CompletedHabitsController completedHabitsController = Get.find();

  // Function to handle the tap on the checkbox
  void checkBoxTap(bool? value, int index) {
    setState(() {
      if (value == true) {
        habitsController.habits[index]['currentCount']++;
        if (habitsController.habits[index]['currentCount'] ==
            habitsController.habits[index]['timesPerDay']) {
          habitsController.habits[index]['completed'] = true;
          completedHabitsController.addCompletedHabit();
          completedHabitsController.givingExperiencePerHabit(
              habitsController.habits[index]['timesPerDay']);
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
        title: const Text('Mi Mejor Ser'),
        actions: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'EXP: ${completedHabitsController.experienceGained}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: addHabitFloatingActionButton(
        onPressed: createHabit,
      ),
      body: ListView.builder(
        itemCount: habitsController.habits.length,
        itemBuilder: (context, index) {
          return BoolHabit(
            habitName: habitsController.habits[index]['name'],
            habitCompleted: habitsController.habits[index]['completed'],
            timesPerDay: habitsController.habits[index]['timesPerDay'],
            currentCount: habitsController.habits[index]['currentCount'],
            onChanged: (value) => checkBoxTap(value, index),
          );
        },
      ),
    );
  }
}