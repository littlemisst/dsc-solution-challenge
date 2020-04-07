import 'package:flutter/material.dart';
import 'package:flutter_scale/flutter_scale.dart';
import 'package:me_daily/common-widgets/buildGrid.dart';
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

  DateTime symptomsStartedTime = DateTime.now();
  // double _temperature;

  List<String> symptoms = [];
  void _setCold(newValue) {
    setState(() {
      cold = newValue;
      symptoms.add('cold');
    });
  }

  void _setCough(newValue) {
    setState(() {
     cough = newValue;
     symptoms.add('cough');
    });
  }

  void _setDiarrhea(newValue) {
    setState(() {
      diarrhea = newValue;
      symptoms.add('diarrhea');
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

  ScrollController _temperatureController;
  final celciusController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _temperatureController = ScrollController(initialScrollOffset: 7400);
    celciusController.addListener(() {
      widget.entry.temperature = double.parse(celciusController.text);
    });
  }

  void _handleTemperatureScaleChanged(int scalePoints) {
    int offSet = scalePoints ~/ 20;
    double celcius = (offSet * 10)/100;
    celciusController.text = celcius.toString();
  }


  Widget _buildTemperatureScale(context, controller, scaleChanged) {
  return HorizontalScale(
    maxValue: 60,
    scaleController: controller,
    onChanged: scaleChanged,
    textStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold),
    scaleColor: Colors.white10,
    lineColor: Colors.pink[100],
  );
}

Widget _buildTemperatureField(contex, controller) {
  return Container(
    width: 70,
    height: 50.0,
    child: TextField(
      controller: controller,
      style: TextStyle(fontSize: 15),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          hintText: '37.0 °C', suffixText: '°C'),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title:  Text('What do you feel?'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSymptoms(),
             SizedBox(height: 15),
            _buildTemperature(),
            SizedBox(height: 15),
            TimePicker(widget.entry.timeOfOccurance, () => _displayTimePicker(context))
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
            SizedBox(height: 15),
            Text('Check the symptoms you have been experiencing', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            _buildSymptomsGrid(),
            SizedBox(height: 15)
          ])
        )
      )
    );
  }
  
  Widget _buildSymptomsGrid() {
    return Container(
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
      ], 2, 6)
    );
  }

  Widget _buildTemperature() {
    return Container(
      child: Align(
        child: Material(
          color: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 15),
              child: Row(children: <Widget>[
              Text('Enter your current body temperature ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
               _buildTemperatureField(context, celciusController)
              ]),
            ),
            
            Container(
              padding: EdgeInsets.fromLTRB(60, 5, 60, 15),
              child: _buildTemperatureScale(context, _temperatureController, _handleTemperatureScaleChanged)),
          ])
        )
      )
    );
  }

  Future _displayTimePicker(BuildContext context) async {
    final now = DateTime.now();
   TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );
    if(time != null) {
      setState(() {
        widget.entry.timeOfOccurance = DateTime(now.year, now.month, now.day, time.hour, time.minute);
      });
    }
  }


}