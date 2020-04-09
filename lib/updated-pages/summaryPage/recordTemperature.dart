import 'package:flutter/material.dart';

class RecordTemperature extends StatefulWidget {
  @override
  _RecordTemperatureState createState() => _RecordTemperatureState();
}

class _RecordTemperatureState extends State<RecordTemperature> {
  double temperature = 36.5;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text(
                  'Temperature',
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Slider(
                  value: temperature,
                  min: 30,
                  max: 45,
                  label: "$temperature",
                  activeColor: Colors.pink[100],
                  divisions: 150,
                  onChanged: (double value) {
                    setState(() {
                      temperature = value;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Text("$temperature"),
              ),
              Expanded(
                flex: 4,
                child: FlatButton(
                  onPressed: () {},
                  color: Colors.pink[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Record',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
