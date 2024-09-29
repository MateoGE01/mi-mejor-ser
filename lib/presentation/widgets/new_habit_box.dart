// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

// ignore: camel_case_types
class newHabitDialog extends StatelessWidget {
  final nameController;
  final timesPerDayController;
  final VoidCallback onAdd;
  final VoidCallback onCancel;

  const newHabitDialog(
      {super.key,
      required this.onAdd,
      required this.onCancel,
      this.nameController,
      this.timesPerDayController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Habit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Habit name'),
          ),
          TextField(
            controller: timesPerDayController,
            decoration: const InputDecoration(hintText: 'Times per day'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        MaterialButton(onPressed: onAdd, child: const Text('Add')),
        MaterialButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
