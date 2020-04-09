import 'package:flutter/material.dart';

class RecordTemperature extends StatefulWidget {
  @override
  _RecordTemperatureState createState() => _RecordTemperatureState();
}

class _RecordTemperatureState extends State<RecordTemperature> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Text(
                'Temperature',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
