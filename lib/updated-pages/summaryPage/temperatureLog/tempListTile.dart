
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    String dateFormat = DateFormat.yMMMMEEEEd().format(model.logCreated);
    String timeFormat = DateFormat.jm().format(model.logCreated);
    const fontSize = 15.0;
    return ContentContainer(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: ListTile(
        title: Column(children: <Widget>[
          Align(child: Text('$dateFormat at $timeFormat', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)), alignment: Alignment.centerLeft),
          Align(child: Text('${model.temperature} degrees celcius', style: TextStyle(fontSize: fontSize)),alignment: Alignment.centerLeft), 
        ])
      )
    );
  }
}


