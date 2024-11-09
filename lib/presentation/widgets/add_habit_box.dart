import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/presentation/controllers/list_habits.dart';

class NewHabitDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController timesPerDayController;
  final VoidCallback onAdd;
  final VoidCallback onCancel;
  final Function(String) onFrequencyChanged;

  const NewHabitDialog({
    super.key,
    required this.onAdd,
    required this.onCancel,
    required this.nameController,
    required this.timesPerDayController,
    required this.onFrequencyChanged,
  });

  @override
  NewHabitDialogState createState() => NewHabitDialogState();
}

class NewHabitDialogState extends State<NewHabitDialog> {
  final HabitsController habitsController = Get.find<HabitsController>();
  String? selectedHabit;
  String? selectedFrequency = 'Daily';

  // Lista con las opciones de frecuencia
  final List<String> frequencyOptions = ['Daily', 'Weekly', 'Monthly', 'Only Today'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Habit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            hint: const Text('Select a habit'),
            value: selectedHabit,
            onChanged: (String? newValue) {
              setState(() {
                selectedHabit = newValue;
                widget.nameController.text = newValue!;
              });
            },
            items: habitsController.predefinedHabits
                .map<DropdownMenuItem<String>>((habit) {
              return DropdownMenuItem<String>(
                value: habit.name,
                child: Text(habit.name),
              );
            }).toList(),
          ),
          TextField(
            controller: widget.nameController,
            decoration: const InputDecoration(hintText: 'Habit name'),
          ),
          TextField(
            controller: widget.timesPerDayController,
            decoration: const InputDecoration(hintText: 'Times per day'),
            keyboardType: TextInputType.number,
          ),
          DropdownButton<String>(
            value: selectedFrequency,
            hint: const Text('Select frequency'),
            onChanged: (String? newValue) {
              setState(() {
                selectedFrequency = newValue;
                widget.onFrequencyChanged(newValue!); // Llama a la función al cambiar la frecuencia
              });
            },
            items: frequencyOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        MaterialButton(onPressed: widget.onAdd, child: const Text('Add')),
        MaterialButton(
          onPressed: widget.onCancel,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}