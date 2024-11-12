// lib/data/repositories/user_repository_impl.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';
import 'package:mi_mejor_ser/domain/repositories/user_repository.dart';
import '../data_sources/remote/remote_user_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mi_mejor_ser/domain/models/pending_operation.dart';
import '../data_sources/pending_operations_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final Box<User> userBox;
  final RemoteUserDataSource remoteDataSource;
  final PendingOperationsDataSource pendingOperations;

  UserRepositoryImpl(this.userBox, Box<PendingOperation> pendingOperationsBox)
      : remoteDataSource =
            RemoteUserDataSource(firestore: FirebaseFirestore.instance),
        pendingOperations = PendingOperationsDataSource(pendingOperationsBox);

  @override
  Future<void> registerUser(User user) async {
    if (userBox.containsKey(user.username)) {
      throw Exception('Username already exists');
    }
    await userBox.put(user.username, user);
    print('Usuario guardado localmente: ${user.username}');
    try {
      await remoteDataSource.registerUser(user);
    } catch (e) {
      await pendingOperations.addOperation(
          PendingOperation(type: OperationType.register, user: user));
    }
  }

  @override
  Future<User?> loginUser(String username, String password) async {
    // Intentar obtener del backend primero
    try {
      User? remoteUser = await remoteDataSource.loginUser(username, password);
      if (remoteUser != null) {
        await userBox.put(username, remoteUser);
        return remoteUser;
      }
    } catch (e) {
      // Fallo al obtener del backend, intentar localmente
    }

    // Obtener localmente si el backend falla
    final localUser = userBox.get(username);
    if (localUser != null && localUser.password == password) {
      return localUser;
    }
    return null;
  }

  @override
  Future<void> updateUser(User user) async {
    await userBox.put(user.username, user);
    try {
      await remoteDataSource.updateUser(user);
    } catch (e) {
      await pendingOperations.addOperation(
        PendingOperation(type: OperationType.update, user: user),
      );
    }
  }

  Future<void> synchronizeData() async {
    try {
      List<User> remoteUsers = await remoteDataSource.fetchAllUsers();
      for (var user in remoteUsers) {
        await userBox.put(user.username, user);
      }
    } catch (e) {
      // Manejar errores de sincronización
    }
  }

  void listenToRemoteChanges() {
    remoteDataSource.firestore
        .collection('users')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docChanges) {
        if (doc.type == DocumentChangeType.modified ||
            doc.type == DocumentChangeType.added) {
          User updatedUser =
              User.fromMap(doc.doc.data() as Map<String, dynamic>);
          userBox.put(updatedUser.username, updatedUser);
        }
        if (doc.type == DocumentChangeType.removed) {
          userBox.delete(doc.doc.id);
        }
      }
    });
  }

  Future<void> synchronizePendingOperations() async {
    List<PendingOperation> operations = pendingOperations.getAllOperations();
    for (var op in operations) {
      try {
        if (op.type == OperationType.register) {
          await remoteDataSource.registerUser(op.user);
        } else if (op.type == OperationType.update) {
          await remoteDataSource.updateUser(op.user);
        }
      } catch (e) {
        // Si falla, conservar la operación para intentar más tarde
        continue;
      }
    }
    await pendingOperations.clearOperations();
  }

  void listenToConnectivityChanges() {
    // Implementa un listener para cambios de conectividad
    // Por ejemplo, usando el paquete connectivity_plus
    // Cuando esté en línea, llama a synchronizePendingOperations
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        synchronizePendingOperations();
      }
    });
  }
}