import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/sleep.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
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
    final hours = listOfHoursSlept.map((e) => e.hoursSleep);
    return hours.reduce((value, element) => value + element) / hours.length;
  }

  void onChangeRecipient(value) {
    setState(() {
      userSummary.recipient = value;
    });
  }

  void onSend(profile, user, averageHoursSlept, previousLocations) async {
    setState(() {
      userSummary.profile = profile;
      userSummary.sender = user;
      userSummary.averageHoursSlept = averageHoursSlept;
      userSummary.previousLocations = previousLocations;
    });
    await _firestoreService.sendSummary(userSummary);
    Navigator.popAndPushNamed(context, Strings.initialRoute);
  }

  void onPressed(
      recipient, profile, user, averageHoursSlept, previousLocations) {
    recipient != null
        ? showDialog(
            context: context,
            builder: (_) => _confirmSendDialog(
                context, profile, user, averageHoursSlept, previousLocations))
        : showDialog(
            context: context, builder: (_) => _checkRecipientDialog(context));
  }

  Widget _confirmSendDialog(
      context, profile, user, averageHoursSlept, previousLocations) {
    return AlertDialog(
      title: Text('Continue?'),
      content: Text(
          'You are about to share your information to ${userSummary.recipient.email}'),
      actions: <Widget>[
        FlatButton(
          onPressed: () =>
              onSend(profile, user, averageHoursSlept, previousLocations),
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final profile = Provider.of<Profile>(context);
    final listOfHoursSlept = Provider.of<List<Sleep>>(context) ?? [];
    final previousLocations = Provider.of<List<LocationLog>>(context) ?? [];

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
              DisplayBasicInformation(),
              SleepAnalysis(
                  averageHoursSlept: getAverageSleep(listOfHoursSlept)),
              DisplayPreviousLocations(
                previousLocations: previousLocations,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onPressed(userSummary.recipient, profile, user,
            getAverageSleep(listOfHoursSlept), previousLocations),
        child: Icon(Icons.share, color: Colors.white),
      ),
    );
  }
}
