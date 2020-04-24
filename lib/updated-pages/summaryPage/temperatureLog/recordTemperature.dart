import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/recordLogWidget.dart';
import 'package:me_daily/common-widgets/viewHistory.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/temperature.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class RecordTemperature extends StatefulWidget {
  @override
  _RecordTemperatureState createState() => _RecordTemperatureState();
}

class _RecordTemperatureState extends State<RecordTemperature> {
  double _temperature = 36.5;

  Temperature _temperatureFromState() {
    return Temperature(type: 'temperature', temperature: _temperature, logCreated: DateTime.now());
  }

  Future<void> _addTemperatureLog(BuildContext context) async {
    String documentID = DateTime.now().toIso8601String();
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final entry = _temperatureFromState();
    await _firestoreService.addTemperatureLog(entry, documentID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  'Current Temperature'
                ),
              ),
            ),
            ViewHistory(() => Navigator.pushNamed(context, Strings.temperatureHistoryPage))
          ]),
          Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Slider(
                  value: _temperature,
                  min: 30,
                  max: 45,
                  label: "$_temperature",
                  activeColor: Theme.of(context).accentColor,
                  divisions: 150,
                  onChanged: (double value) { setState(() =>  _temperature = value);
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Text("$_temperature"),
              ),
              RecordButton(()=>_addTemperatureLog(context))
            ],
          )
        ],
      ),
    );
  }
}
