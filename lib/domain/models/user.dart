// domain/models/user.dart
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
  int experience;

  User({
    required this.username,
    required this.password,
    this.habits = const [],
    this.level = 1,
    this.experience = 0,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'habits': habits.map((habit) => habit.toMap()).toList(),
      'level': level,
      'experience': experience,
    };
  }

  // Factory para crear desde Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      password: map['password'],
      habits: List<Habit>.from(map['habits']?.map((x) => Habit.fromMap(x)) ?? []),
      level: map['level'],
      experience: map['experience'],
    );
  }
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
  DateTime? startDate;

  Habit({
    required this.name,
    this.completed = false,
    this.timesPerDay = 1,
    this.currentCount = 0,
    this.frequency = 'Daily',
    this.startDate,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'completed': completed,
      'timesPerDay': timesPerDay,
      'currentCount': currentCount,
      'frequency': frequency,
      'startDate': startDate?.toIso8601String(), // Correcto uso de ISO 8601
    };
  }

  // Factory para crear desde Map
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      name: map['name'],
      completed: map['completed'],
      timesPerDay: map['timesPerDay'],
      currentCount: map['currentCount'],
      frequency: map['frequency'],
      startDate: map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
    );
  }
}