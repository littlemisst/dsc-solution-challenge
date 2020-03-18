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

  void _chooseEmotion(String emotion) {
    setState(() {
      _logs.emotion = emotion;
    });
  }

  Widget _buildChooseEmotions() {
    return Row(
      children: <Widget>[
        Expanded(child: IconItem(AssetImage("images/well.png"), 'good', 60, Colors.lightGreen[200], () => _chooseEmotion('good'))),
        Expanded(child:IconItem(AssetImage("images/neutral.png"), 'neutral', 60, Colors.orange[200], () => _chooseEmotion('neutral'))),
        Expanded(child:IconItem(AssetImage("images/unwell.png"), 'unwell', 60, Colors.blue[200], () => _chooseEmotion('unwell'))),
        Expanded(child:IconItem(AssetImage("images/sick.png"), 'sick', 60, Colors.grey, () => _chooseEmotion('sick'))),
      ],
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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('How are you doing?', style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            _buildChooseEmotions(),
          ],
        ),
      );
  }
}
