// data/data_sources/pending_operations_data_source.dart
import 'package:hive/hive.dart';
import 'package:mi_mejor_ser/domain/models/pending_operation.dart';

class PendingOperationsDataSource {
  final Box<PendingOperation> pendingBox;

  PendingOperationsDataSource(this.pendingBox);

  Future<void> addOperation(PendingOperation operation) async {
    await pendingBox.add(operation);
  }

  List<PendingOperation> getAllOperations() {
    return pendingBox.values.toList();
  }

  Future<void> clearOperations() async {
    await pendingBox.clear();
  }
}
