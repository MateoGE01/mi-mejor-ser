import 'package:flutter/material.dart';

// ignore: camel_case_types
class addHabitFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;

  const addHabitFloatingActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}