import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/buildGrid.dart';
import 'package:me_daily/common-widgets/datePicker.dart';
import 'package:me_daily/common-widgets/timePicker.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/updated-pages/dailyLogs/basicQuestions.dart';
import 'package:me_daily/updated-pages/dailyLogs/checkBoxWidget.dart';

class SickQuestionPage extends StatefulWidget {
  @override
  _SickQuestionPageState createState() => _SickQuestionPageState();
}

class _SickQuestionPageState extends State<SickQuestionPage> {
  DailyLog entry;
  bool cold = false;
  bool cough = false;
  bool diarrhea = false;
  bool dizziness = false;
  bool fever = false;
  bool headache = false;
  bool musclePain = false;
  bool vomiting = false;

  DateTime symptomsStarted = DateTime.now();
  DateTime symptomsStartedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/10, 10, MediaQuery.of(context).size.width/10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HOW DO YOU FEEL?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            Text('Check the symptoms you have experienced', style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
            SizedBox(height: 15),
            _buildSymptomsGrid(),
            SizedBox(height: 15),
            _buildSymptomsStarted()
          ],
        )
      ),
      floatingActionButton: FlatButton(
        child: Text('NEXT', style: TextStyle(fontSize: 15)), 
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BasicQuestionsPage(entry: entry)))
      )
    );
  }
  Widget _buildSymptomsStarted() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('When did the symptoms started?', style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
          SizedBox(height: 15),
          DatePicker('Enter date', (DateTime value) => symptomsStarted = value),
          SizedBox(height: 15),
          TimePicker((DateTime value) => symptomsStartedTime = value)
          ]
        )
    );   
  }
  
  Widget _buildSymptomsGrid() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.8,
      padding: EdgeInsets.all(5),
      child: BuildGridItems([
        SymptomsCheckBox('cold', cold, (bool newValue) => setState(() {cold = newValue;})),
        SymptomsCheckBox('cough', cough, (bool newValue) => setState(() {cough = newValue;})),
        SymptomsCheckBox('diarrhea', diarrhea, (bool newValue) => setState(() {diarrhea = newValue;})),
        SymptomsCheckBox('dizziness', dizziness, (bool newValue) => setState(() {dizziness = newValue;})),
        SymptomsCheckBox('fever', fever, (bool newValue) => setState(() {fever = newValue;})),
        SymptomsCheckBox('headache', headache, (bool newValue) => setState(() {headache = newValue;})),
        SymptomsCheckBox('muscle pain', musclePain, (bool newValue) => setState(() {musclePain = newValue;})),
        SymptomsCheckBox('vomiting', vomiting, (bool newValue) => setState(() {vomiting = newValue;})),
      ], 2, 3)
    );
  }
}