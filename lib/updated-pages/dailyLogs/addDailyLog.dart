import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/buildGrid.dart';
import 'package:me_daily/common-widgets/iconItem.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/updated-pages/addTasks/gridItemWidget.dart';

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
    return Container(
      child: BuildGridItems([
        GridItem(
            child: IconItem(AssetImage("images/well.png"), Strings.good, 60,
                Theme.of(context).accentColor, () => _chooseEmotion(Strings.good))),
        GridItem(
            child: IconItem(AssetImage("images/neutral.png"), Strings.okay, 60,
                Colors.cyan[300], () => _chooseEmotion(Strings.okay))),
        GridItem(
            child: IconItem(AssetImage("images/unwell.png"), Strings.unwell, 60,
                Colors.cyan[100], () => _chooseEmotion(Strings.unwell))),
        GridItem(
            child: IconItem(AssetImage("images/sick.png"), Strings.sick, 60,
                Colors.grey, () => _chooseEmotion(Strings.sick)))
      ], 2, 1)
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
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('HOW ARE YOU FEELING?',
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              SizedBox(height: 10),
              _buildChooseEmotions()
            ],
          ),
        ));
  }
}
