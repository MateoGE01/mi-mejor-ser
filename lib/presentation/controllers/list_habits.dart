// Mateo: Aquí pondré la lista habits que está en la clase _MyHomePageState y la función addHabitAction
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  // Mapa para almacenar hábitos por fecha
  final _habitsByDate = <String, List<Map<String, dynamic>>>{}.obs;
  Map<String, List<Map<String, dynamic>>> get habitsByDate => _habitsByDate;

  List<Map<String, dynamic>> get predefinedHabits => _predefinedHabits;

  // Mapa para almacenar el progreso de los hábitos por fecha y nombre
  final habitProgressByDate = <String, Map<String, Map<String, dynamic>>>{}.obs;

  // Método para agregar un hábito a una fecha específica
  void addHabit(String date, String name, int timesPerDay, String frequency) {
    if (!_habitsByDate.containsKey(date)) {
      _habitsByDate[date] = [];
    }
    _habitsByDate[date]!.add({
      'name': name,
      'completed': false,
      'timesPerDay': timesPerDay,
      'currentCount': 0,
      'frequency': frequency, // Agregar la frecuencia
    });
  }

  // Método para obtener los hábitos de una fecha específica
  List<Map<String, dynamic>> getHabitsForDate(String date) {
    List<Map<String, dynamic>> habitsForDate = [];

    _habitsByDate.forEach((key, habits) {
      for (var habit in habits) {
        if (habitAppliesToDate(habit, key, date)) {
          // Inicializar el progreso si no existe para la fecha actual
          if (!habitProgressByDate.containsKey(date)) {
            habitProgressByDate[date] = {};
          }
          if (!habitProgressByDate[date]!.containsKey(habit['name'])) {
            habitProgressByDate[date]![habit['name']] = {
              'currentCount': 0,
              'completed': false,
            };
          }

          // Agregar los datos del progreso al hábito
          var progress = habitProgressByDate[date]![habit['name']]!;
          habitsForDate.add({
            ...habit,
            'currentCount': progress['currentCount'],
            'completed': progress['completed'],
          });
        }
      }
    });

    return habitsForDate;
  }

  // Método para verificar si un hábito debe aplicarse en una fecha específica
  bool habitAppliesToDate(Map<String, dynamic> habit, String startDate, String currentDate) {
      DateTime start = DateFormat('MMMM d, y').parse(startDate);
      DateTime current = DateFormat('MMMM d, y').parse(currentDate);

      switch (habit['frequency']) {
        case 'Daily':
          return true;
        case 'Weekly':
          return current.difference(start).inDays % 7 == 0;
        case 'Monthly':
          return start.day == current.day;
        case 'Only Today':
          return startDate == currentDate;
        default:
          return false;
      }
    }
}
