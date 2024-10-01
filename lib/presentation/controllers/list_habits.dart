// Mateo: Aquí pondré la lista habits que está en la clase _MyHomePageState y la función addHabitAction
import 'package:get/get.dart';

class HabitsController extends GetxController {
  // Lista de hábitos predefinidos
  final _predefinedHabits = <Map<String, dynamic>>[
    {
      'name': 'Exercise',
      'completed': false,
      'timesPerDay': 1, // Número de veces que se debe realizar al día
      'currentCount': 0 // Contador de veces realizadas en el día
    },
    {
      'name': 'Drink Water',
      'completed': false,
      'timesPerDay': 1, 
      'currentCount': 0
    },
    {
      'name': 'Read a Book',
      'completed': false,
      'timesPerDay': 1, 
      'currentCount': 0
    },
    {
      'name': 'Meditate',
      'completed': false,
      'timesPerDay': 1, 
      'currentCount': 0
    },
    {
      'name': 'Walk the Dog',
      'completed': false,
      'timesPerDay': 1, 
      'currentCount': 0
    },
    {
      'name': 'Brush Teeth',
      'completed': false,
      'timesPerDay': 1, 
      'currentCount': 0
    },
    {
      'name': 'Practice a Hobby',
      'completed': false,
      'timesPerDay': 1, 
      'currentCount': 0
    },
  ].obs;

  final _habits = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get predefinedHabits => _predefinedHabits;
  List<Map<String, dynamic>> get habits => _habits;
}