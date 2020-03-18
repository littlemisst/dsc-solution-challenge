import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';

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

Future<Map> getTasksListOnSpecificDate(context) async {
  final user = Provider.of<User>(context);
  final uid = user.uid;

  CollectionReference ref = Firestore.instance
      .collection('userData')
      .document(uid)
      .collection('tasks');

  QuerySnapshot eventsQuery = await ref.getDocuments();

  Map<DateTime, List<dynamic>> _tasks;
  _tasks = {};

  for (var document in eventsQuery.documents) {
    var taskList = <dynamic>[];
    DateTime day = document.data["taskStarted"].toDate();

    for (int i = eventsQuery.documents.indexOf(document); i < eventsQuery.documents.length; i++) {
      String taskType = eventsQuery.documents[i].data["taskType"].toString();
      String specificTask = eventsQuery.documents[i].data["specificTask"].toString();
      String task = '$taskType $specificTask';
      if (day == eventsQuery.documents[i].data["taskStarted"].toDate()) {
        if (_tasks.containsKey(day)) {
          taskList.add(task);
        } else {
          taskList.add(task);
          _tasks[day] = taskList;
        }
      }
    }
  }
  print(_tasks);
  return _tasks;
}
