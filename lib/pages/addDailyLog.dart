import 'package:flutter/material.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/api/daily_logs_api.dart';

class AddDailyLogs extends StatefulWidget {
  @override
  _AddDailyLogsState createState() => _AddDailyLogsState();
}

class _AddDailyLogsState extends State<AddDailyLogs> {
  final _formKey = GlobalKey<FormState>();

  Logs _logs = Logs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Daily Logs', style: TextStyle(color: Colors.pink[100])),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (String value) {
                _logs.emotion = value;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (String value) {
                _logs.medicine = value;
              },
            ),
            RaisedButton(
              child: Text('submit'),
              onPressed: ()=> submit(_logs),
            )
          ],
        ),
      ),
    );
  }
}
