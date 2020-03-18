import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';

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
