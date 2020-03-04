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

  void _chooseEmotion(String emotion) {
    setState(() {
      _logs.emotion = emotion;
    });
  }

  Widget _buildChooseEmotions() {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed:()=> _chooseEmotion("rad"),
              child: Icon(
                Icons.sentiment_very_satisfied,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: ()=> _chooseEmotion("good"),
              child: Icon(
                Icons.sentiment_satisfied,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: ()=> _chooseEmotion("meh"),
              child: Icon(
                Icons.sentiment_neutral,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: ()=> _chooseEmotion("bad"),
              child: Icon(
                Icons.sentiment_dissatisfied,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: ()=> _chooseEmotion("Sad"),
              child: Icon(
                Icons.sentiment_very_dissatisfied,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNotes() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Add notes"),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: (String value) {
        _logs.note = value;
      },
    );
  }

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
            _buildChooseEmotions(),
            _buildAddNotes(),
            RaisedButton(
              child: Text('submit'),
              onPressed: () {
                if(!_formKey.currentState.validate()){
                  return;
                }

                submit(_logs);
              },
            )
          ],
        ),
      ),
    );
  }
}
