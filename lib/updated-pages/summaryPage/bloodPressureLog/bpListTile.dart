
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/dateFormatter.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';

class BloodPressureListTileModel {
  const BloodPressureListTileModel({
    @required this.systolic,
    @required this.diastolic,
    @required this.diagnosis,
    @required this.logCreated});
  final int systolic;
  final int diastolic;
  final String diagnosis;
  final DateTime logCreated;
}

class BloodPressureListTile extends StatelessWidget {
  const BloodPressureListTile({@required this.model});
  final BloodPressureListTileModel model;

  @override
  Widget build(BuildContext context) {
    String dateFormat = DateTimeFormatter(date: model.logCreated).withWeekDateFormat;
    String timeFormat = DateTimeFormatter(date: model.logCreated).timeFormat;
    const fontSize = 15.0;

    return ContentContainer(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: ListTile(
        leading: Icon(Icons.healing,
        color:  model.diagnosis == Strings.normal ? Colors.green : Colors.red
        ), 
        title: Column(children: <Widget>[
          Align(child: Text('${model.systolic} / ${model.diastolic}', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold,
          color:  model.diagnosis == Strings.normal ? Colors.green : Colors.red)),alignment: Alignment.centerLeft), 
          Align(child: Text('${model.diagnosis}', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, 
          color:  model.diagnosis == Strings.normal ? Colors.green : Colors.red,
          )),alignment: Alignment.centerLeft),
          Align(child: Text('$dateFormat at $timeFormat', style: TextStyle(fontSize: fontSize)), alignment: Alignment.centerLeft),
        ])
      )
    );
  }
}


