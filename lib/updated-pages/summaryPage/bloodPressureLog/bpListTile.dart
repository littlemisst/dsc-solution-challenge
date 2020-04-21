
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

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
    String dateFormat = DateFormat.yMMMMEEEEd().format(model.logCreated);
    String timeFormat = DateFormat.jm().format(model.logCreated);
    const fontSize = 15.0;
    return ContentContainer(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: ListTile(
        title: Column(children: <Widget>[
          Align(child: Text('$dateFormat at $timeFormat', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)), alignment: Alignment.centerLeft),
          Align(child: Text('${model.systolic} / ${model.diastolic}', style: TextStyle(fontSize: fontSize)),alignment: Alignment.centerLeft), 
          Align(child: Text('${model.diagnosis}', style: TextStyle(fontSize: fontSize)),alignment: Alignment.centerLeft)
        ])
      )
    );
  }
}


