import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = Firestore.instance;
    
addTask(task) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final uid = user.uid;
  await db.collection('userData').document(uid).collection('tasks').add(task.toJson());
}