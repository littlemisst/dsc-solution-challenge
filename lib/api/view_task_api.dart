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

// Str  eam<QuerySnapshot> getTaskStartedDates(DateTime date) async* {
//   FirebaseUser user = await FirebaseAuth.instance.currentUser();
//   final uid = user.uid;
//   yield* Firestore.instance
//       .collection('userData')
//       .document(uid)
//       .collection('tasks')
//       .where('taskStarted', isEqualTo: date)
//       .snapshots();
// }

addNewTaskOnSpecificDate(date) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final uid = user.uid;
  await db
      .collection('userData')
      .document(uid)
      .collection('dates')
      .add(date.toJson());
}

Future<Map> getTasksOnSpecificDate() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final uid = user.uid;

  CollectionReference ref = Firestore.instance
      .collection('userData')
      .document(uid)
      .collection('tasks');
   
  QuerySnapshot eventsQuery = await ref.getDocuments();
  
  Map<DateTime,List<dynamic>> _tasks;
  _tasks = {};
  
  for (var document in eventsQuery.documents) {
    var taskList = <dynamic>[]; 
    DateTime day = document.data["taskStarted"].toDate();
    
      for (int i=eventsQuery.documents.indexOf(document); i < eventsQuery.documents.length; i++) {
        String task = eventsQuery.documents[i].data["task"].toString();
        
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