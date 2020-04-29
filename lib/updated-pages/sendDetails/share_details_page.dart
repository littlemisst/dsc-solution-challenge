import 'dart:math';

import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/bloodPressure.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/sleep.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/model/temperature.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/model/water.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/sendDetails/analysis_page.dart';
import 'package:me_daily/updated-pages/sendDetails/display_activities_page.dart';
import 'package:me_daily/updated-pages/sendDetails/display_basic_information_page.dart';
import 'package:me_daily/updated-pages/sendDetails/display_previous_locations.dart';
import 'package:me_daily/updated-pages/sendDetails/display_temperature_history.dart';
import 'package:me_daily/updated-pages/sendDetails/recipient_selector.dart';
import 'package:provider/provider.dart';

class ShareDetailsPage extends StatefulWidget {
  @override
  _ShareDetailsPageState createState() => _ShareDetailsPageState();
}

class _ShareDetailsPageState extends State<ShareDetailsPage> {
  FirestoreService _firestoreService = FirestoreService();
  UserSummary userSummary = UserSummary();
  int age;
  double bmi;

  int getAge(DateTime birthdate) {
    DateTime dateNow = DateTime.now();

    int age = dateNow.year - birthdate.year;

    if (birthdate.month > dateNow.month) {
      age--;
    }
    if (birthdate.month == dateNow.month) {
      if (birthdate.day > dateNow.day) {
        age--;
      }
    }
    return age;
  }

  double getBMI(weight, height) {
    double bmi = weight / pow(height, 2);
    return bmi;
  }

  double getAverageSleep(List<Sleep> listOfHoursSlept) {
    // must be refactored
    if (listOfHoursSlept.isEmpty) {
      return null;
    } else {
      final hours = listOfHoursSlept.map((e) => e.hoursSleep);
      return hours.reduce((value, element) => value + element) / hours.length;
    }
  }

  double getAverageWaterDrank(List<Water> listOfWaterDrank) {
    // must be refactored
    if (listOfWaterDrank.isEmpty) {
      return null;
    } else {
      final listOfWaterConsumption = listOfWaterDrank.map((e) => e.waterInML);
      return listOfWaterConsumption
              .reduce((value, element) => value + element) /
          listOfWaterConsumption.length;
    }
  }

  List<String> getActivities(List<DailyLog> listOfLogs) {
    if (listOfLogs.isEmpty) {
      return [];
    }
    List<String> activities = [];
    List<String> listOfActivities = [];
    listOfLogs.forEach((element) {
      listOfActivities.addAll(element.exercise);
    });
    listOfActivities.forEach((element) {
      if (!activities.contains(element)) {
        activities.add(element);
      }
    });
    return activities;
  }

  void onChangeRecipient(value) {
    setState(() {
      userSummary.recipient = value;
    });
  }

  void onPressed(profile, user, averageHoursSlept, averageWaterDrank,
      previousLocations, activities, bloodPressureHistory, temperatureHistory) {
    userSummary.recipient != null
        ? showDialog(
            context: context,
            builder: (_) => _confirmSendDialog(
                context,
                profile,
                user,
                averageHoursSlept,
                averageWaterDrank,
                previousLocations,
                activities,
                bloodPressureHistory,
                temperatureHistory))
        : showDialog(
            context: context, builder: (_) => _checkRecipientDialog(context));
  }

  Widget _confirmSendDialog(
      context,
      profile,
      user,
      averageHoursSlept,
      averageWaterDrank,
      previousLocations,
      activities,
      bloodPressureHistory,
      temperatureHistory) {
    return AlertDialog(
      title: Text('Continue?'),
      content: Text(
          'You are about to share your information to ${userSummary.recipient.email}'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => onSend(
              profile,
              user,
              averageHoursSlept,
              averageWaterDrank,
              previousLocations,
              activities,
              bloodPressureHistory,
              temperatureHistory),
          child: Text('Continue'),
        ),
        FlatButton(
          onPressed: () {},
          child: Text('Cancel'),
        )
      ],
    );
  }

  Widget _checkRecipientDialog(context) {
    return AlertDialog(
        title: Text('Recipient no match'),
        content: Text('Please enter a valid email'));
  }

  void onSend(
      profile,
      user,
      averageHoursSlept,
      averageWaterDrank,
      previousLocations,
      activities,
      bloodPressureHistory,
      temperatureHistory) async {
    setState(() {
      userSummary.profile = profile;
      userSummary.sender = user;
      userSummary.averageHoursSlept = averageHoursSlept;
      userSummary.averageWaterDrank = averageWaterDrank;
      userSummary.previousLocations = previousLocations;
      userSummary.activities = activities;
      userSummary.bloodPressureHistory = bloodPressureHistory;
      userSummary.temperatureHistory = temperatureHistory;
      userSummary.dateSent = DateTime.now();
    });
    await _firestoreService.sendSummary(userSummary);
    Navigator.popAndPushNamed(context, Strings.initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final profile = Provider.of<Profile>(context) ?? null;
    final listOfHoursSlept = Provider.of<List<Sleep>>(context) ?? [];
    final listOfWaterDrank = Provider.of<List<Water>>(context) ?? [];
    final previousLocations = Provider.of<List<LocationLog>>(context) ?? [];
    final List<DailyLog> logs = Provider.of<List<DailyLog>>(context) ?? [];
    final List<BloodPressure> bloodPressureHistory =
        Provider.of<List<BloodPressure>>(context) ?? [];
    final List<Temperature> temperatureHistory =
        Provider.of<List<Temperature>>(context) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              RecipientSelector(onChangeRecipient: onChangeRecipient),
              DisplayBasicInformation(
                profile: profile,
                age: profile == null ? null : getAge(profile.birthDate),
                bmi: profile == null
                    ? null
                    : getBMI(profile.weight, profile.height),
              ),
              Analysis(
                text: getAverageSleep(listOfHoursSlept),
                title: 'Sleep Analysis',
                subtitle: 'Average daily hours slept',
                nullMessage: 'No record',
              ),
              Analysis(
                text: getAverageWaterDrank(listOfWaterDrank),
                title: 'Water Consumption',
                subtitle: 'Average daily water consumption',
                nullMessage: 'No record',
              ),
              DisplayTemperatureHistory(
                temperatureHistory: temperatureHistory,
              ),
              DisplayPreviousLocations(
                previousLocations: previousLocations,
              ),
              DisplayActivitiesPage(
                activities: getActivities(logs),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onPressed(
            profile,
            user,
            getAverageSleep(listOfHoursSlept),
            getAverageWaterDrank(listOfWaterDrank),
            previousLocations,
            getActivities(logs),
            bloodPressureHistory,
            temperatureHistory),
        child: Icon(Icons.share, color: Colors.white),
      ),
    );
  }
}
