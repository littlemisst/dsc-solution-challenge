import 'dart:math';

import 'package:flutter/material.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/updated-pages/sendDetails/analysis_page.dart';
import 'package:me_daily/updated-pages/sendDetails/display_activities_page.dart';
import 'package:me_daily/updated-pages/sendDetails/display_basic_information_page.dart';
import 'package:me_daily/updated-pages/sendDetails/display_previous_locations.dart';
import 'package:me_daily/updated-pages/sendDetails/display_temperature_history.dart';

class ViewMessage extends StatelessWidget {
  final UserSummary userSummary;
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

  ViewMessage({this.userSummary});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              DisplayBasicInformation(
                profile: userSummary.profile,
                age: getAge(userSummary.profile.birthDate),
                bmi: getBMI(
                    userSummary.profile.weight, userSummary.profile.height),
              ),
              Analysis(
                text: userSummary.averageHoursSlept,
                title: 'Sleep Analysis',
                subtitle: 'Average daily hours slept',
                nullMessage: 'No record',
              ),
              Analysis(
                text: userSummary.averageWaterDrank,
                title: 'Water Consumption',
                subtitle: 'Average daily water consumption',
                nullMessage: 'No record',
              ),
              DisplayTemperatureHistory(
                temperatureHistory: userSummary.temperatureHistory,
              ),
              DisplayPreviousLocations(
                previousLocations: userSummary.previousLocations,
              ),
              DisplayActivitiesPage(
                activities: userSummary.activities,
              )
            ],
          ),
        ),
      ),
    );
  }
}
