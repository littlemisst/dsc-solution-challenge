import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/buildGrid.dart';
import 'package:me_daily/common-widgets/datePicker.dart';
import 'package:me_daily/common-widgets/timePicker.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/updated-pages/dailyLogs/basicQuestions.dart';
import 'package:me_daily/updated-pages/dailyLogs/checkBoxWidget.dart';

class SickQuestionPage extends StatefulWidget {
  final DailyLog entry;
  SickQuestionPage({Key key, @required this.entry}) : super(key: key);
  @override
  _SickQuestionPageState createState() => _SickQuestionPageState();
}

class _SickQuestionPageState extends State<SickQuestionPage> {
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

  Map<String, bool> symptoms = {};

  void _setCold(newValue) {
    setState(() {
      cold = newValue;
      symptoms['cold'] = cold;
    });
  }

  void _setCough(newValue) {
    setState(() {
     cough = newValue;
     symptoms['cough'] = cough;
    });
  }

  void _setDiarrhea(newValue) {
    setState(() {
      diarrhea = newValue;
      symptoms['diarrhea'] = diarrhea;
    });
  }

  void _setDizziness(newValue) {
    setState(() {
      dizziness = newValue;
      symptoms['dizziness'] = dizziness;
    });
  }

  void _setFever(newValue) {
    setState(() {
      fever = newValue;
      symptoms['fever'] = fever;
    });
  }

  void _setHeadache(newValue) {
    setState(() {
      headache = newValue;
      symptoms['headache'] = headache;
    });
  }

  void _setMusclePain(newValue) {
    setState(() {
      musclePain = newValue;
      symptoms['musclePain'] = musclePain;
    });
  }

  void _setVomiting(newValue) {
    setState(() {
      vomiting = newValue;
      symptoms['vomiting'] = vomiting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HOW DO YOU FEEL?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            _buildSymptoms(),
            _buildSymptomsStarted()
          ],
        )
      ),
      floatingActionButton: FlatButton(
        child: Text('NEXT', style: TextStyle(fontSize: 15)), 
        onPressed: () {
          setState(() {
            widget.entry.symptoms = symptoms;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => BasicQuestionsPage(entry: widget.entry)));
        }
      )
    );
  }
  Widget _buildSymptoms() {
    return Container(
      child: Align (
        child: Material(
          color: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          child: Column(children: <Widget>[
            Text('Check the symptoms you have experienced', style: TextStyle(fontSize: 15)),
            SizedBox(height: 15),
            _buildSymptomsGrid(),
            SizedBox(height: 15)
          ])
        )
      )
    );
  }
  Widget _buildSymptomsStarted() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('When did the symptoms started?', style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
          SizedBox(height: 15),
          DatePicker('Enter date', (DateTime value) => widget.entry.symptomsStarted = value),
          SizedBox(height: 15),
          TimePicker((DateTime value) => widget.entry.timeOfOccurance = value)
          ]
        )
    );   
  }
  
  Widget _buildSymptomsGrid() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.8,
      padding: EdgeInsets.all(5),
      child: BuildGridItems([
        SymptomsCheckBox('cold', cold, (value) => _setCold(value)),
        SymptomsCheckBox('cough', cough, (value) => _setCough(value)),
        SymptomsCheckBox('diarrhea', diarrhea, (value) => _setDiarrhea(value)),
        SymptomsCheckBox('dizziness', dizziness, (value) => _setDizziness(value)),
        SymptomsCheckBox('fever', fever, (value) => _setFever(value)),
        SymptomsCheckBox('headache', headache, (value) => _setHeadache(value)),
        SymptomsCheckBox('muscle pain', musclePain, (value) => _setMusclePain(value)),
        SymptomsCheckBox('vomiting', vomiting, (value) => _setVomiting(value)),
      ], 2, 1)
    );
  }
}