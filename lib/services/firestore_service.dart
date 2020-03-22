import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_daily/model/feeling.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/photo.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/task.dart';

class FirestoreService {
  final String uid;
  FirestoreService({this.uid});

  final CollectionReference userData =
      Firestore.instance.collection('userData');

  //add and retrieve photos
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

  // retrieve to health chart
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

//add and retrieve for profile
  Profile _profileFromFirebase(DocumentSnapshot documentSnapshot) {
    return Profile(
      name: documentSnapshot.data['name'],
      address: documentSnapshot.data['address'],
      birthDate: documentSnapshot.data['birthDate'].toDate(),
      gender: documentSnapshot.data['gender'],
      civilStatus: documentSnapshot.data['civilStatus'],
      bloodType: documentSnapshot.data['bloodType'],
      height: documentSnapshot.data['height'],
      weight: documentSnapshot.data['weight'],
      downloadUrl: documentSnapshot.data['downloadUrl'],
    );
  }

  Stream<Profile> get profile {
    return userData.document(uid).snapshots().map(_profileFromFirebase);
  }

  Future submitProfile(Profile profile) async {
    return await userData.document(uid).setData(profile.toJson());
  }

//add and retrieve for task
  Future addTask(Task task) async {
    return await userData.document(uid).collection('tasks').add(task.toJson());
  }

  List<Task> _taskFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => Task.fromJson(document.data))
        .toList();
  }

  Stream<List<Task>> get tasks {
    return userData
        .document(uid)
        .collection('tasks')
        .snapshots()
        .map(_taskFromFirebase);
  }

  //add and retrieve for daily logs
  Future addDailyLog(DailyLog entry) async {
    return await userData
        .document(uid)
        .collection('dailyLogs')
        .add(entry.toJson());
  }
}
