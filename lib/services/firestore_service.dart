import 'package:me_daily/model/sleep.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/model/water.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_daily/model/feeling.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/photo.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/locationLog.dart';

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
          downloadURL: document.data['downloadURL'],
          description: document.data['description']);
    }).toList();
  }

  Stream<List<Photo>> get photos {
    return userData
        .document(uid)
        .collection('photos')
        .snapshots()
        .map(_photoFromFirebase);
  }

  Future uploadPhoto(
      String downloadURL, String fileName, String description) async {
    return await userData.document(uid).collection('photos').add({
      'downloadURL': downloadURL,
      'fileName': fileName,
      'description': description
    });
  }

  //retrieve to health chart
  List<Health> _healthFromFirebase(QuerySnapshot querySnapshot) {
    Map<String, int> _healthMap = Map();
    List<Health> _healthList = [];
    querySnapshot.documents.forEach((document) {
      if (!_healthMap.containsKey(document.data['feeling'])) {
        _healthMap[document.data['feeling']] = 1;
      } else {
        _healthMap[document.data['feeling']] += 1;
      }
    });

    _healthMap.forEach((key, value) {
      _healthList.add(Health(feeling: key, count: value));
    });

    return _healthList;
  }

  Stream<List<Health>> get feelings {
    return userData
        .document(uid)
        .collection('dailyLogs')
        .snapshots()
        .map(_healthFromFirebase);
  }

  //retrieve to sleep chart
  List<Sleep> _sleepFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((document) {
      return Sleep(
          dateTime: DateTime.parse(document.data['logCreated']),
          hoursSleep: document.data['hoursSlept']);
    }).toList();
  }

  Stream<List<Sleep>> get sleep {
    return userData
        .document(uid)
        .collection('dailyLogs')
        .orderBy('logCreated')
        .snapshots()
        .map(_sleepFromFirebase);
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
      profilePhotoFileName: documentSnapshot.data['profilePhotoFileName'],
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

  Future addRepeatingTasks(Task task) async {
    return await userData
        .document(uid)
        .collection('duplicateTasks')
        .add(task.toJson());
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

  Stream<List<Task>> get repetitiveTasks {
    return userData
        .document(uid)
        .collection('duplicateTasks')
        .snapshots()
        .map(_taskFromFirebase);
  }

  Stream<List<Task>> get allTasksStream =>
      CombineLatestStream.combine2(tasks, repetitiveTasks, (a, b) => a + b);

  //add and retrieve for daily logs
  Future addDailyLog(DailyLog entry) async {
    return await userData
        .document(uid)
        .collection('dailyLogs')
        .add(entry.toJson());
  }

  Future addWaterLog(Water entry) async {
    return await userData
        .document(uid)
        .collection('basicLogs')
        .add(entry.toJson());
  }

  List<DailyLog> _logsFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => DailyLog.fromJson(document.data))
        .toList();
  }

  Stream<List<DailyLog>> get logs {
    return userData
        .document(uid)
        .collection('dailyLogs')
        .orderBy('logCreated')
        .snapshots()
        .map(_logsFromFirebase);
  }

  //add location
  Future saveLocation(LocationLog location) async {
    return await userData
        .document(uid)
        .collection('locationLog')
        .add(location.toJson());
  }

  //add summary
  Future sendSummary(UserSummary userSummary) async {
    return await userData
        .document(userSummary
            .recipient.uid) //should generated once a recipient is chosen
        .collection("messages")
        .add(userSummary.toJson());
  }

  List<User> _recipientsFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((document) {
      return User(email: document.data['email'], uid: document.data['uid']);
    }).toList();
  }

  Stream<List<User>> get users {
    Firestore _firestore = Firestore.instance;
    return _firestore
        .collection("users")
        .snapshots()
        .map(_recipientsFromFirebase);
  }

  Future addUser(User user) async {
    Firestore _firestore = Firestore.instance;
    return _firestore
        .collection('users')
        .document(user.uid)
        .setData(user.toJson());
  }

  List<LocationLog> _locationLogsFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((document) {
      return LocationLog(
          dateAndTime: document.data['dateAndTime'].toDate(),
          locationName: document.data['locationName']);
    }).toList();
  }

  Stream<List<LocationLog>> get locationLog {
    return userData
        .document(uid)
        .collection('locationLog')
        .snapshots()
        .map(_locationLogsFromFirebase);
  }
}
