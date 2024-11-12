// domain/models/pending_operation.dart
import 'package:hive/hive.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';

part 'pending_operation.g.dart';

@HiveType(typeId: 2)
enum OperationType {
  @HiveField(0)
  register,

  @HiveField(1)
  update,
}

@HiveType(typeId: 3)
class PendingOperation extends HiveObject {
  @HiveField(0)
  final OperationType type;

  @HiveField(1)
  final User user;

  PendingOperation({required this.type, required this.user});

  Map<String, dynamic> toMap() {
    return {
      'type': type.index, // Guarda como índice del enum
      'user': user.toMap(),
    };
  }

  factory PendingOperation.fromMap(Map<String, dynamic> map) {
    return PendingOperation(
      type: OperationType.values[map['type']],
      user: User.fromMap(Map<String, dynamic>.from(map['user'])),
    );
  }
}