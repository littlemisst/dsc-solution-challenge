import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/iconItem.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/updated-pages/dailyLogs/basicQuestions.dart';
import 'package:me_daily/updated-pages/dailyLogs/forTheSickQuestions.dart';

class AddDailyLogs extends StatefulWidget {
  @override
  _AddDailyLogsState createState() => _AddDailyLogsState();
}

class _AddDailyLogsState extends State<AddDailyLogs> {
  String _emotion;
  DailyLog entry;

  void _chooseEmotion(String emotion) {
    setState(() {
      _emotion = emotion;
      entry.feeling = _emotion;
    });
    print(entry.feeling);
    if (_emotion == 'good' || _emotion == 'neutral') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BasicQuestionsPage(entry: entry)));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SickQuestionPage()));
    }
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
  void initState() {
    super.initState();
    entry = DailyLog(
      feeling: _emotion
    );
    _emotion = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.height/5, MediaQuery.of(context).size.width/10, 0),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('How are you doing?', style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            _buildChooseEmotions(),
          ],
        ),
      )
    );
  }
}