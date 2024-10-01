import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/presentation/controllers/completed_habits.dart';
import 'package:mi_mejor_ser/presentation/widgets/add_habit_button.dart';
import 'package:mi_mejor_ser/presentation/widgets/bool_habit.dart';
import 'package:mi_mejor_ser/presentation/widgets/new_habit_box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Mateo: Debo añadir un controlador(en controllers) que tenga la lista de hábitos predefinidos y la lista de hábitos añadidos(ya veré si lo dejo como una o dos listas)
  // Mateo: Para más organización debo hacer lo de arriba y por los requisitos que piden Controladores.

  // Lista de hábitos, por ahora funciona para los hábitos predefinidos y los que se añadan
  List<Map<String, dynamic>> habits = [
    {
      'name': 'Exercise',
      'completed': false,
      'timesPerDay': 1, // Número de veces que se debe realizar al día
      'currentCount': 0 // Contador de veces realizadas en el día
    },
    {
      'name': 'Drink Water',
      'completed': false,
      'timesPerDay': 8,
      'currentCount': 0
    },
    // Agrega más hábitos según sea necesario
  ];

  // Controller for the text field in the dialog for adding a new habit for the name
  final TextEditingController _newHabitDialogController =
      TextEditingController();

  // Controller for the text field in the dialog for adding a new habit for the times per day
  final TextEditingController _timesPerDayDialogController =
      TextEditingController();

  // Function to add a new habit
  void addHabitAction() {
    setState(() {
      habits.add({
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

  CompletedHabitsController completedHabitsController = Get.find();

  // Function to handle the tap on the checkbox
  void checkBoxTap(bool? value, int index) {
    setState(() {
      if (value == true) {
        habits[index]['currentCount']++;
        if (habits[index]['currentCount'] == habits[index]['timesPerDay']) {
          habits[index]['completed'] = true;
          completedHabitsController.addCompletedHabit();
          completedHabitsController
              .givingExperiencePerHabit(habits[index]['timesPerDay']);
        }
      }
      // Aquí se podría añadir para que se elimine el hábito si se marca como completado y
      // se sume un punto al contador de hábitos completados, lo segundo me interesa más
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
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return BoolHabit(
            habitName: habits[index]['name'],
            habitCompleted: habits[index]['completed'],
            timesPerDay: habits[index]['timesPerDay'],
            currentCount: habits[index]['currentCount'],
            onChanged: (value) => checkBoxTap(value, index),
          );
        },
      ),
    );
  }
}
