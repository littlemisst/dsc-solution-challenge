import 'dart:convert';

import 'package:me_daily/model/bloodPressure.dart';
import 'package:me_daily/model/medicalHistory.dart';
import 'package:me_daily/model/sleep.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/model/temperature.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/model/water.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_daily/model/feeling.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/photo.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/model/menstrual.dart';

class FirestoreService {
  final String uid;
  FirestoreService({this.uid});

  final CollectionReference userData =
      Firestore.instance.collection('userData');

//Retrieve Health chart
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

//Retrieve Sleep Chart
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

//Add and Retrieve Profile
  Profile _profileFromFirebase(DocumentSnapshot documentSnapshot) {
    return Profile.fromJson(documentSnapshot.data);
  }

  Stream<Profile> get profile {
    return userData.document(uid).snapshots().map(_profileFromFirebase);
  }

  Future submitProfile(Profile profile) async {
    return await userData.document(uid).setData(profile.toJson());
  }

//Add and Retrieve Photo
  List<Photo> _photoFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => Photo.fromJson(document.data))
        .toList();
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

//Add and Retrieve Tasks
  Future addTask(Task task, String documentID) async {
    return await userData
        .document(uid)
        .collection('tasks')
        .document(task.taskCreated.toString())
        .setData(task.toJson());
  }

  Future setCompleted(String documentId) async {
    return await userData
        .document(uid)
        .collection('tasks')
        .document(documentId)
        .updateData(<String, bool>{'completed': true});
  }

  Future addRepeatingTasks(Task task, String documentID) async {
    return await userData
        .document(uid)
        .collection('duplicateTasks')
        .document(task.taskCreated.toString())
        .setData(task.toJson());
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

//Add and Retrieve Daily Log
  Future addDailyLog(DailyLog entry) async {
    return await userData
        .document(uid)
        .collection('dailyLogs')
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

//Add and Retrieve Water
  Future addWaterLog(Water entry, String documentID) async {
    return await userData
        .document(uid)
        .collection('basicLogs')
        .document(documentID)
        .setData(entry.toJson());
  }

  Future updateWater(String documentID, int increment, int conversion) async {
    return await userData
        .document(uid)
        .collection('basicLogs')
        .document(documentID)
        .updateData(<String, dynamic>{
      'waterDrank': FieldValue.increment(increment),
      'waterInML': conversion
    });
  }

  List<Water> _waterLogFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => Water.fromJson(document.data))
        .toList();
  }

  Stream<List<Water>> get water {
    return userData
        .document(uid)
        .collection('basicLogs')
        .orderBy('logCreated')
        .where('type', isEqualTo: 'water')
        .snapshots()
        .map(_waterLogFromFirebase);
  }

//Add and Retrieve Temperature
  Future addTemperatureLog(Temperature entry, String documentID) async {
    return await userData
        .document(uid)
        .collection('basicLogs')
        .document(documentID)
        .setData(entry.toJson());
  }

  List<Temperature> _tempLogFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => Temperature.fromJson(document.data))
        .toList();
  }

  Stream<List<Temperature>> get temperature {
    return userData
        .document(uid)
        .collection('basicLogs')
        .orderBy('logCreated')
        .where('type', isEqualTo: 'temperature')
        .snapshots()
        .map(_tempLogFromFirebase);
  }

//Add and Retrieve Blood Pressure
  Future addBloodPressureLog(BloodPressure entry, String documentID) async {
    return await userData
        .document(uid)
        .collection('basicLogs')
        .document(documentID)
        .setData(entry.toJson());
  }

  List<BloodPressure> _bpLogFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => BloodPressure.fromJson(document.data))
        .toList();
  }

  Stream<List<BloodPressure>> get bloodPressure {
    return userData
        .document(uid)
        .collection('basicLogs')
        .orderBy('logCreated')
        .where('type', isEqualTo: 'bloodPressure')
        .snapshots()
        .map(_bpLogFromFirebase);
  }

//Add and Retrieve Add Summary
  Future sendSummary(UserSummary userSummary) async {
    return await userData
        .document(userSummary.recipient.uid)
        .collection("messages")
        .add(userSummary.toJson());
  }

  List<User> _recipientsFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => User.fromJson(document.data))
        .toList();
  }

  Stream<List<User>> get users {
    Firestore _firestore = Firestore.instance;
    return _firestore
        .collection('users')
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

//Add and Retrieve Location
  List<LocationLog> _locationLogsListFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => LocationLog.fromJson(document.data))
        .toList();
  }

  Stream<List<LocationLog>> get locationLogList {
    return userData
        .document(uid)
        .collection('locationLog')
        .orderBy('dateAndTime')
        .snapshots()
        .map(_locationLogsListFromFirebase);
  }

  Future saveLocation(LocationLog location) async {
    return await userData
        .document(uid)
        .collection('locationLog')
        .add(location.toJson());
  }

//Add and Retrieve User SUmmary
  List<UserSummary> _userMessagesFromFirebase(QuerySnapshot querySnapshot) {
    querySnapshot.documents.forEach((document) {
      print((document.data['previousLocations']));
    });
    return querySnapshot.documents
        .map((document) => UserSummary.fromJson(document.data))
        .toList();
  }

  Stream<List<UserSummary>> get messages {
    return userData
        .document(uid)
        .collection('messages')
        .orderBy('dateSent', descending: true)
        .snapshots()
        .map(_userMessagesFromFirebase);
  }

//Add and Retrieve Menstrual
  Future saveMenstrualPeriodLog(Menstrual menstrual) async {
    return await userData
        .document(uid)
        .collection('menstrualPeriodLog')
        .add(menstrual.toJson());
  }

  List<Menstrual> _menstrualLogFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => Menstrual.fromJson(document.data))
        .toList();
  }

  Stream<List<Menstrual>> get menstrualPeriodLog {
    return userData
        .document(uid)
        .collection('menstrualPeriodLog')
        .orderBy('periodStarts')
        .limit(1)
        .snapshots()
        .map(_menstrualLogFromFirebase);
  }

  Stream<List<Menstrual>> get periodSummary {
    return userData
        .document(uid)
        .collection('menstrualPeriodLog')
        .orderBy('periodEnds')
        .snapshots()
        .map(_menstrualLogFromFirebase);
  }

//Add and Retrieve Medical History
  Future addMedicalHistory(MedicalHistory history) async {
    return await userData
        .document(uid)
        .collection('medicalHistory')
        .document('medicalHistory')
        .setData(history.toJson());
  }

  Future updateMedicalHistory(MedicalHistory medicalHistory) async {
    return await userData
        .document(uid)
        .collection('medicalHistory')
        .document('medicalHistory')
        .updateData(medicalHistory.toJson());
  }

  List<MedicalHistory> _historyFromFirebase(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((document) => MedicalHistory.fromJson(document.data))
        .toList();
  }

  Stream<List<MedicalHistory>> get history {
    return userData
        .document(uid)
        .collection('medicalHistory')
        .snapshots()
        .map(_historyFromFirebase);
  }
}
