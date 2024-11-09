import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  List<Habit> habits;

  @HiveField(3)
  int level;

  @HiveField(4)
  int experience; // Cambiado de 'experienceGained' a 'experience'

  User({
    required this.username,
    required this.password,
    this.habits = const [],
    this.level = 1,
    this.experience = 0, // Actualizado
  });
}

@HiveType(typeId: 1)
class Habit extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool completed;

  @HiveField(2)
  int timesPerDay;

  @HiveField(3)
  int currentCount;

  @HiveField(4)
  String frequency;

  @HiveField(5)
  DateTime? startDate; // Agregado el campo 'startDate'

  Habit({
    required this.name,
    this.completed = false,
    this.timesPerDay = 1,
    this.currentCount = 0,
    this.frequency = 'Daily',
    this.startDate, // Agregado al constructor
  });
}