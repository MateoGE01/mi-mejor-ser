import 'package:flutter/material.dart';

class BoolHabit extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final int? timesPerDay;
  final int? currentCount;
  final Function(bool?)? onChanged;

  const BoolHabit(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      this.onChanged,
      this.timesPerDay,
      this.currentCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            // Checkbox
            Checkbox(value: habitCompleted, onChanged: onChanged),
            Text('$habitName $currentCount/$timesPerDay'),
          ],
        ),
      ),
    );
  }
}
