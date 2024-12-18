import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mi_mejor_ser/presentation/widgets/habit_circular_progress_bar.dart';

class BoolHabit extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final int timesPerDay;
  final int currentCount;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onDelete;

  const BoolHabit({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.timesPerDay,
    required this.currentCount,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: const Color.fromRGBO(247, 214, 224, 1),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
                178, 247, 239, 1), // Color de fondo del contenedor
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              // Checkbox con borde y sombra
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          color: Colors.grey[800]!,
                          width: 1), // Borde más delgado
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          Colors.transparent, // Eliminar borde interno
                    ),
                    child: Checkbox(
                      value: habitCompleted,
                      onChanged: onChanged,
                      activeColor: const Color.fromRGBO(
                          123, 223, 242, 1), // Color cuando está marcado
                      checkColor: const Color.fromRGBO(239, 247, 246,
                          1), // Color de la marca de verificación
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8), // Espacio entre el checkbox y el texto
              Text(
                habitName,
                style: const TextStyle(fontSize: 16), // Tamaño del texto aumentado
              ),
              const Spacer(),
              HabitCircularProgressBar(
                currentCount: currentCount,
                timesPerDay: timesPerDay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
