import 'package:flutter/material.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/updated-pages/sendDetails/analysisPage.dart';
import 'package:me_daily/updated-pages/sendDetails/displayActivitiesPage.dart';
import 'package:me_daily/updated-pages/sendDetails/displayBasicInformationPage.dart';
import 'package:me_daily/updated-pages/sendDetails/displayPreviousLocations.dart';

class ViewMessage extends StatelessWidget {
  final UserSummary userSummary;
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
              DisplayBasicInformation(profile: userSummary.profile),
              Analysis(
                text: userSummary.averageWaterDrank,
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
