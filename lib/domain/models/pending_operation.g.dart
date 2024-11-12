// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_operation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendingOperationAdapter extends TypeAdapter<PendingOperation> {
  @override
  final int typeId = 3;

  @override
  PendingOperation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingOperation(
      type: fields[0] as OperationType,
      user: fields[1] as User,
    );
  }

  @override
  void write(BinaryWriter writer, PendingOperation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingOperationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OperationTypeAdapter extends TypeAdapter<OperationType> {
  @override
  final int typeId = 2;

  @override
  OperationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OperationType.register;
      case 1:
        return OperationType.update;
      default:
        return OperationType.register;
    }
  }

  @override
  void write(BinaryWriter writer, OperationType obj) {
    switch (obj) {
      case OperationType.register:
        writer.writeByte(0);
        break;
      case OperationType.update:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
