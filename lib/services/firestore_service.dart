import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_daily/model/feeling.dart';
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
    return await userData.document(uid).collection('tasks').add(task.toJson());
  }

  List<Health> _healthFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((document) {
      return Health(
          feeling: document.data['feeling'], count: document.data['count']);
    }).toList();
  }

  Stream<List<Health>> get feelings {
    return Firestore.instance
        .collection('mockdata')
        .snapshots()
        .map(_healthFromFirebase);
  }
}
