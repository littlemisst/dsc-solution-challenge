import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';

final db = Firestore.instance;

Future<void> updateTask() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final uid = user.uid;

  CollectionReference ref = Firestore.instance
      .collection('userData')
      .document(uid)
      .collection('tasks');

  CollectionReference secondRef = Firestore.instance
      .collection('userData')
      .document(uid)
      .collection('logs');

  QuerySnapshot tasksQuery = await ref.getDocuments();
  QuerySnapshot logsQuery = await secondRef.getDocuments();
  for (var document in tasksQuery.documents) {
    DateTime day = document.data["taskStarted"].toDate();
    String taskType = document.data["taskType"].toString();
    String specificTask = document.data["specificTask"].toString();
    for (var log in logsQuery.documents) {
      DateTime dayDone = log.data["taskDone"].toDate();
      if (day == dayDone && log.data["taskType"] == taskType && log.data["specificTask"] == specificTask) {
        ref.document(document.documentID).updateData({'completed': true});
      };
    }
  }
}
