import 'package:flutter/material.dart';

class HabitCircularProgressBar extends StatelessWidget {
  final int currentCount;
  final int timesPerDay;

  const HabitCircularProgressBar({
    Key? key,
    required this.currentCount,
    required this.timesPerDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = currentCount / timesPerDay;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 5.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(const Color.fromRGBO(123, 223, 242, 1)),
          ),
        ),
        Text(
          '$currentCount/$timesPerDay',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}