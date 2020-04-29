
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/dateFormatter.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class TemperatureListTileModel {
  const TemperatureListTileModel({
    @required this.temperature,
    @required this.logCreated});
  final double temperature;
  final DateTime logCreated;
}

class TemperatureListTile extends StatelessWidget {
  const TemperatureListTile({@required this.model});
  final TemperatureListTileModel model;

  @override
  Widget build(BuildContext context) {
    String dateFormat = DateTimeFormatter(date: model.logCreated).withWeekDateFormat;
    String timeFormat = DateTimeFormatter(date: model.logCreated).timeFormat;
    const fontSize = 15.0;
    return ContentContainer(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: ListTile(
        leading: Icon(CupertinoIcons.circle_filled, color: model.temperature >= 37 ? Colors.red : Theme.of(context).primaryColor),
        title: Column(children: <Widget>[
          Align(child: Text('${model.temperature} degrees celcius', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold,
          color: model.temperature >= 37 ? Colors.red :Theme.of(context).primaryColor)),alignment: Alignment.centerLeft), 
          Align(child: Text('$dateFormat at $timeFormat', style: TextStyle(fontSize: fontSize)), 
          alignment: Alignment.centerLeft),
          
        ])
      )
    );
  }
}


