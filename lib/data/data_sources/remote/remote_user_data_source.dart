// data/data_sources/remote_user_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mi_mejor_ser/domain/models/user.dart';

class RemoteUserDataSource {
  final FirebaseFirestore firestore;

  RemoteUserDataSource({required this.firestore});

  Future<void> registerUser(User user) async {
    await firestore.collection('users').doc(user.username).set(user.toMap());
  }

  Future<User?> loginUser(String username, String password) async {
    DocumentSnapshot doc = await firestore.collection('users').doc(username).get();
    if (doc.exists) {
      User user = User.fromMap(doc.data() as Map<String, dynamic>);
      if (user.password == password) {
        return user;
      }
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await firestore.collection('users').doc(user.username).update(user.toMap());
  }

  Future<void> synchronizeUsers(List<User> localUsers) async {
    WriteBatch batch = firestore.batch();
    for (var user in localUsers) {
      DocumentReference docRef = firestore.collection('users').doc(user.username);
      batch.set(docRef, user.toMap(), SetOptions(merge: true));
    }
    await batch.commit();
  }

  Future<List<User>> fetchAllUsers() async {
    QuerySnapshot snapshot = await firestore.collection('users').get();
    return snapshot.docs.map((doc) => User.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}