import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_daily/model/photo.dart';
import 'package:me_daily/model/task.dart';

class FirestoreService {
  final String uid;
  FirestoreService({this.uid});

  final CollectionReference userData =
      Firestore.instance.collection('userData');

  List<Photo> _photoFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((document) {
      return Photo(
          fileName: document.data['fileName'],
          downloadURL: document.data['downloadURL']);
    }).toList();
  }

  Stream<List<Photo>> get photos {
    return userData
        .document(uid)
        .collection('photos')
        .snapshots()
        .map(_photoFromFirebase);
  }

  Future uploadPhoto(String downloadURL, String fileName) async {
    return await userData
        .document(uid)
        .collection('photos')
        .add({'downloadURL': downloadURL, 'fileName': fileName});
  }

  Future addTask(Task task) async {
    return await userData
      .document(uid)
      .collection('tasks')
      .add(task.toJson());
  }

  List<Task> _taskFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((document) {
      return Task(
        taskType: document.data['taskType'],
        specificTask: document.data['specificTask'],
        taskStarted: document.data['taskStarted'],
        taskEnded: document.data['taskEnded'],
        taskTime: document.data['taskTime']
      );
    }).toList();
  }

  Stream<List<Task>> get tasks {
    return userData
      .document(uid)
      .collection('tasks')
      .snapshots()
      .map(_taskFromFirebase);
  }
}
