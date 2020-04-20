import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/iconItem.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/constants/strings.dart';

class AddDailyLogs extends StatefulWidget {
  @override
  _AddDailyLogsState createState() => _AddDailyLogsState();
}

class _AddDailyLogsState extends State<AddDailyLogs> {
  String _emotion;
  DailyLog entry;

  @override
  void initState() {
    super.initState();
    entry = DailyLog(feeling: _emotion);
  }

  void _chooseEmotion(String emotion) {
    _emotion = emotion;
    entry = DailyLog(feeling : _emotion);
    (_emotion == Strings.good || _emotion == Strings.okay) ?
      Navigator.pushNamed(context, Strings.basicQuestionsLogRoute, arguments: entry) :
      Navigator.pushNamed(context, Strings.sickQuestionsLogRoute, arguments: entry);
  }

  Widget _buildChooseEmotions() {
    return Row(
      children: <Widget>[
        Expanded(
            child: IconItem(AssetImage("images/well.png"), Strings.good, 60,
                Theme.of(context).accentColor, () => _chooseEmotion(Strings.good))),
        Expanded(
            child: IconItem(AssetImage("images/neutral.png"), Strings.okay, 60,
                Colors.cyan[300], () => _chooseEmotion(Strings.okay))),
        Expanded(
            child: IconItem(AssetImage("images/unwell.png"), Strings.unwell, 60,
                Colors.cyan[100], () => _chooseEmotion(Strings.unwell))),
        Expanded(
            child: IconItem(AssetImage("images/sick.png"), Strings.sick, 60,
                Colors.grey, () => _chooseEmotion(Strings.sick))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: FlatButton(
            child: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.popAndPushNamed(context, Strings.initialRoute),
          ),
          title: TextFormat('DAILY LOGS'),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 10,
              MediaQuery.of(context).size.height / 5,
              MediaQuery.of(context).size.width / 10,
              0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('How are you feeling?',
                  style: TextStyle(fontSize: 15, fontFamily: 'Montserrat')),
              SizedBox(height: 30),
              _buildChooseEmotions()
            ],
          ),
        ));
  }
}
