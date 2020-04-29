import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/dateFormatter.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class MenstrualListTileModel {
  const MenstrualListTileModel({
    @required this.periodStarts,
    @required this.periodEnds,
    @required this.flow,
    @required this.cycle});
  final DateTime periodStarts;
  final DateTime periodEnds;
  final String flow;
  final String cycle;
}

class MenstrualListTile extends StatelessWidget {
  const MenstrualListTile({@required this.model});
  final MenstrualListTileModel model;

  @override
  Widget build(BuildContext context) {
    String formatStart = DateTimeFormatter(date: model.periodStarts).withWeekDateFormat;
    String formatEnd = DateTimeFormatter(date: model.periodEnds).withWeekDateFormat;
    const fontSize = 15.0;

    return ContentContainer(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: ListTile(
        leading: Icon(CupertinoIcons.circle_filled,
        color:  model.cycle != 'Irregular' || model.flow != 'Disaster' ? Theme.of(context).primaryColor : Colors.red
        ), 
        title: Column(children: <Widget>[
          Align(child: Text('Start : $formatStart', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, 
          color: Theme.of(context).primaryColor,
          )),alignment: Alignment.centerLeft),
          SizedBox(height: 2),
          Align(child: Text('End : $formatEnd', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, 
          color: Theme.of(context).primaryColor)),alignment: Alignment.centerLeft),
          Align(child: Text(model.cycle, style: TextStyle(fontSize: fontSize)),alignment: Alignment.centerLeft),
          Align(child: Text(model.flow, style: TextStyle(fontSize: fontSize)),alignment: Alignment.centerLeft),
        ])
      )
    );
  }
}


