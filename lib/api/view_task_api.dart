import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = Firestore.instance;

Stream<QuerySnapshot> fetchTasks() async* {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final uid = user.uid;
  yield* Firestore.instance
      .collection('userData')
      .document(uid)
      .collection('tasks')
      .snapshots();
}
