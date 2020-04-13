import 'package:flutter/material.dart';

class RecordBloodPressure extends StatefulWidget {
  @override
  _RecordBloodPressureState createState() => _RecordBloodPressureState();
}

class _RecordBloodPressureState extends State<RecordBloodPressure> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Text(
                'Blood Pressure',
              ),
            ),
          )),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 15, height: 1),
                    decoration: InputDecoration(labelText: 'Systolic'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 15, height: 1),
                    decoration: InputDecoration(labelText: 'Diastolic'),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  color: Theme.of(context).buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Record',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
