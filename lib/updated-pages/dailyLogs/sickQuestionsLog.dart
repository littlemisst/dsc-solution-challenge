import 'package:flutter/material.dart';
import 'package:flutter_scale/flutter_scale.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/timePicker.dart';
import 'package:me_daily/common-widgets/dateRangePicker.dart';
import 'package:me_daily/common-widgets/datePickerWidget.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/dailyLogs/basicQuestionsLog.dart';
import 'package:me_daily/updated-pages/dailyLogs/checkBoxContainer.dart';
import 'package:me_daily/updated-pages/dailyLogs/expandableRadioWidget.dart';
import 'package:me_daily/updated-pages/dailyLogs/stepperWidget.dart';
import 'package:provider/provider.dart';

class SickQuestionsLogPage extends StatefulWidget {
  final DailyLog entry;
  SickQuestionsLogPage({Key key, @required this.entry}) : super(key: key);

  @override
  _SickQuestionsLogPageState createState() => _SickQuestionsLogPageState();
}

class _SickQuestionsLogPageState extends State<SickQuestionsLogPage> {
  int _currentStep = 0;
  List<String> _symptoms = Strings.symptoms;
  List<bool> _symptomsValues = List<bool>();

  String _taskType;
  String _specificTask;
  String _choice;
  Task task;
  
  @override
  void initState() {
    super.initState();
    widget.entry.symptoms = List<String>();

    task = Task(taskType: _taskType
    );
    _taskType = '';
    _specificTask = '';
    _choice = '';

    setState(() {
      for(int i=0; i < _symptoms.length; i++){
        _symptomsValues.add(false);
      }
    });
  }

  void _setSpecificTask(value) {
    setState(() {
      _specificTask = value;
      task.specificTask = _specificTask;
    });
  }

   void _setChoice(value) {
    setState(() {
      _choice = value;
    });
  }

  List<Step> get _steps => [
    Step(
      isActive: _currentStep >= 0,
      title: Text('Symptoms'),
      subtitle: Text('Check the symptoms you are experiencing'),
      content: CheckBoxGrid(_symptoms, _symptomsValues, widget.entry.symptoms),
      state: _currentStep > 0 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 1,
      title: Text('Symptoms Started'),
      subtitle: Text('Enter the time the symptoms started'),
      content: TimePicker(
                elevation: 1,
                taskTime: widget.entry.timeOfOccurance,
                setTime: (dateTime) => setState(() => widget.entry.timeOfOccurance = dateTime),
              ),
      state: _currentStep > 1 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 2,
      title: Text('What do you want to do?'),
      content: _buildTasks(),
      state: _currentStep > 2 ? StepState.complete : StepState.editing
      ),
  ];

  void _onStepContinue() {
    if (_currentStep == 0 && widget.entry.symptoms.isNotEmpty) {
       setState(() {
          _currentStep ++;
      });
    }
    if (_currentStep == 1 && widget.entry.timeOfOccurance != null) {
       setState(() {
          _currentStep ++;
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep < 0) return;
      setState(() {
        _currentStep -= 1;
      });
  }

  Widget _buildTasks() {
    return _choice == '' ? 
      Container(
        child: Row(children: <Widget>[
          FlatButton(child: 
            Text('Add Medicine'),
            color: Theme.of(context).accentColor,
            onPressed: () => _setChoice('medicine'),
          ),
          SizedBox(width: 10),
          FlatButton(child:
            Text('Add Appointment'),
            color: Theme.of(context).backgroundColor,
            onPressed: () => _setChoice('appointment'),
          ),
        ])
      ) :
    _choice == 'medicine' ? _buildAddMedicine() : _buildAddAppointment();
  }

  Widget _buildAddMedicine() {
      final user = Provider.of<User>(context);
      final _firestoreService = FirestoreService(uid: user.uid);
       _taskType = 'take medicine';
      task.taskType = _taskType;
      print(task.taskType);
      return ContentContainer(
        width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              ExpandableRadioCard('Choose your medicine', Strings.medicine, _specificTask, (value) => _setSpecificTask(value)),
              SizedBox(height: 10),
              DateRangePickerWidget(
                elevation: 0,
                taskStarted: task.taskStarted,
                taskEnded: task.taskEnded,
                setTaskStarted: (date) => setState(() => task.taskStarted = date), 
                setTaskEnded: (date) => setState(() => task.taskEnded = date)),
              SizedBox(height: 10),
              TimePicker(
                elevation: 0,
                taskTime: task.taskTime,
                setTime: (dateTime) => setState(() => task.taskTime = dateTime),
              ),
               SizedBox(height: 10),
              FlatButton(onPressed: () {
                 _firestoreService.addTask(task);
              }, child: Text('ADD TASK'))
            ])
          )
    );
  }

   Widget _buildAddAppointment() {
     final user = Provider.of<User>(context);
      final _firestoreService = FirestoreService(uid: user.uid);
       _taskType = 'book an appointment';
      task.taskType = _taskType;
      return ContentContainer(
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              ExpandableRadioCard('Choose an appointment', Strings.appointment, _specificTask, (value) => _setSpecificTask(value)),
              SizedBox(height: 10),
              DatePickerWidget(
                elevation: 0,
                taskStarted: task.taskStarted,
                setTaskStarted: (date) => setState(() => task.taskStarted = date), 
                setTaskEnded: (date) => setState(() => task.taskEnded = date)),
              SizedBox(height: 10),
              TimePicker(
                elevation: 0,
                taskTime: task.taskTime,
                setTime: (dateTime) => setState(() => task.taskTime = dateTime),
              ),
              SizedBox(height: 10),
              FlatButton(onPressed: () {
                 _firestoreService.addTask(task);
              }, child: Text('ADD TASK'))
            ])
          )
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormat('What do you feel?', Theme.of(context).accentColor),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: StepperWidget(_currentStep, () => _onStepContinue(), ()=>_onStepCancel(), _steps),
      floatingActionButton: _currentStep == _steps.length -1 ? FloatingActionButton(child: Icon(Icons.keyboard_arrow_right, color: Colors.white) , onPressed: () =>
        Navigator.pushNamed(context, Strings.basicQuestionsLogRoute, arguments: widget.entry)) : null
    );
  }
}