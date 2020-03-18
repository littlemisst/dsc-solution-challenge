import 'package:flutter/material.dart';
import 'package:me_daily/api/view_task_api.dart';
import 'package:me_daily/common-widgets/iconItem.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/api/daily_logs_api.dart';

class AddDailyLogs extends StatefulWidget {
  @override
  _AddDailyLogsState createState() => _AddDailyLogsState();
}

class _AddDailyLogsState extends State<AddDailyLogs> {
  final _formKey = GlobalKey<FormState>();

  Logs _logs = Logs();

  Future<void> _chooseEmotion(String emotion) {
    setState(() {
      _logs.emotion = emotion;
    });
  }

  Widget _buildChooseEmotions() {
      return Row(
        children: <Widget>[
          Expanded(child: IconItem(AssetImage("images/well.png"), 'well', 60, Colors.lightGreen[200], () => _chooseEmotion('well'))),
          Expanded(child:IconItem(AssetImage("images/neutral.png"), 'neutral', 60, Colors.orange[200], () => _chooseEmotion('fine'))),
          Expanded(child:IconItem(AssetImage("images/unwell.png"), 'unwell', 60, Colors.blue[200], () => _chooseEmotion('unwell'))),
          Expanded(child:IconItem(AssetImage("images/sick.png"), 'sick', 60, Colors.grey[200], () => _chooseEmotion('unwell'))),
        ],
      );
  }

  Widget _buildDrinkWater(){
    return Container(
      
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
        child: Column(
          children: <Widget>[
            Text('How are you doing?', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 24),
            _buildChooseEmotions(),
          ],
        ),
      ),
    );
  }
}
