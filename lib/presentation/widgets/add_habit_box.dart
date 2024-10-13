import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_mejor_ser/presentation/controllers/list_habits.dart';

// ignore: camel_case_types
class newHabitDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController timesPerDayController;
  final VoidCallback onAdd;
  final VoidCallback onCancel;

  const newHabitDialog({
    super.key,
    required this.onAdd,
    required this.onCancel,
    required this.nameController,
    required this.timesPerDayController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _newHabitDialogState createState() => _newHabitDialogState();
}

// ignore: camel_case_types
class _newHabitDialogState extends State<newHabitDialog> {
  final HabitsController habitsController = Get.find<HabitsController>();
  String? selectedHabit;

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
                value: habit['name'],
                child: Text(habit['name']),
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
