import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/bloodPressure.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/menstrual.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/sleep.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/temperature.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/model/water.dart';
import 'package:me_daily/routes/routes.dart';
import 'package:me_daily/service_locator.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

import 'model/medicalHistory.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<User>.value(value: FirebaseAuthentication().user),
      StreamProvider<List<User>>.value(value: FirestoreService().users),
    ], child: BuildMaterialApp());
  }
}

class BuildMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    return _user == null
        ? buildMaterialApp(context)
        : MultiProvider(providers: [
            StreamProvider<Profile>.value(
                value: FirestoreService(uid: _user.uid).profile),
            StreamProvider<List<Sleep>>.value(
                value: FirestoreService(uid: _user.uid).sleep),
            StreamProvider<List<DailyLog>>.value(
                value: FirestoreService(uid: _user.uid).logs),
            StreamProvider<List<LocationLog>>.value(
                value: FirestoreService(uid: _user.uid).locationLogList),
            StreamProvider.value(
                value: FirestoreService(uid: _user.uid).messages),
            StreamProvider<List<MedicalHistory>>.value(
                value: FirestoreService(uid: _user.uid).history),
            StreamProvider<List<Water>>.value(
                value: FirestoreService(uid: _user.uid).water),
            StreamProvider<List<BloodPressure>>.value(
                value: FirestoreService(uid: _user.uid).bloodPressure),
            StreamProvider<List<Temperature>>.value(
                value: FirestoreService(uid: _user.uid).temperature),
            StreamProvider<List<Task>>.value(
                value: FirestoreService(uid: _user.uid).tasks),
            StreamProvider<List<Menstrual>>.value(
                value: FirestoreService(uid: _user.uid).menstrualPeriodLog),
          ], child: buildMaterialApp(context));
  }
}

Widget buildMaterialApp(BuildContext context) {
  return MaterialApp(
    title: 'Me Daily',
    theme: ThemeData(
        primaryColor: Colors.cyan,
        accentColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.blueGrey[50],
        buttonColor: Colors.cyan,
        backgroundColor: Colors.white,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 1)),
    onGenerateRoute: Router.generateRoute,
    initialRoute: Strings.initialRoute,
  );
}
