import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/sleep.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/sendDetails/displayActivitiesPage.dart';
import 'package:me_daily/updated-pages/sendDetails/displayBasicInformationPage.dart';
import 'package:me_daily/updated-pages/sendDetails/recipientSelector.dart';
import 'package:me_daily/updated-pages/sendDetails/sleepAnalysisPage.dart';
import 'package:provider/provider.dart';

import 'displayPreviousLocations.dart';

class ShareDetailsPage extends StatefulWidget {
  @override
  _ShareDetailsPageState createState() => _ShareDetailsPageState();
}

class _ShareDetailsPageState extends State<ShareDetailsPage> {
  FirestoreService _firestoreService = FirestoreService();
  UserSummary userSummary = UserSummary();

  double getAverageSleep(List<Sleep> listOfHoursSlept) {
    // must be refactored
    if (listOfHoursSlept.isEmpty) {
      return null;
    } else {
      final hours = listOfHoursSlept.map((e) => e.hoursSleep);
      return hours.reduce((value, element) => value + element) / hours.length;
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

  void onPressed(
      profile, user, averageHoursSlept, previousLocations, activities) {
    userSummary.recipient != null
        ? showDialog(
            context: context,
            builder: (_) => _confirmSendDialog(context, profile, user,
                averageHoursSlept, previousLocations, activities))
        : showDialog(
            context: context, builder: (_) => _checkRecipientDialog(context));
  }

  Widget _confirmSendDialog(context, profile, user, averageHoursSlept,
      previousLocations, activities) {
    return AlertDialog(
      title: Text('Continue?'),
      content: Text(
          'You are about to share your information to ${userSummary.recipient.email}'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => onSend(
              profile, user, averageHoursSlept, previousLocations, activities),
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
      profile, user, averageHoursSlept, previousLocations, activities) async {
    setState(() {
      userSummary.profile = profile;
      userSummary.sender = user;
      userSummary.averageHoursSlept = averageHoursSlept;
      userSummary.previousLocations = previousLocations;
      userSummary.activities = activities;
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
    final previousLocations = Provider.of<List<LocationLog>>(context) ?? [];
    final List<DailyLog> logs = Provider.of<List<DailyLog>>(context) ?? [];

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
              DisplayBasicInformation(profile: profile),
              SleepAnalysis(
                  averageHoursSlept: getAverageSleep(listOfHoursSlept)),
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
            previousLocations,
            getActivities(logs)),
        child: Icon(Icons.share, color: Colors.white),
      ),
    );
  }
}
