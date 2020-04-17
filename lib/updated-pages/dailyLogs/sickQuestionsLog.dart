import 'package:flutter/material.dart';
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
import 'package:me_daily/updated-pages/addTasks/taskDifference.dart';
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
  List<String> _symptoms = Strings.symptomsList;
  List<bool> _symptomsValues = List<bool>();

  List<String> _symptomsAdded;
  DateTime _timeOfOccurance;
  
  String _taskType;
  String _specificTask;
  DateTime _taskStarted;
  DateTime _taskEnded;
  DateTime _taskTime;

  String _choice;
  Task task;
  DailyLog _entry;

  @override
  void initState() {
    super.initState();
    
    _symptomsAdded = [];
    _choice = '';

    setState(() {
      for(int i=0; i < _symptoms.length; i++){
        _symptomsValues.add(false);
      }
    });
  }

  void _setSpecificTask(value) {
    setState(() => _specificTask = value);
  }

   void _setChoice(value) {
    setState(() => _choice = value);
  }

  Task _taskFromState() {
    return Task(
      taskType: _taskType,
      specificTask: _specificTask,
      taskStarted: _taskStarted,
      taskEnded: _taskEnded,
      taskTime: _taskTime
    );
  }

  Future<void> _addTask(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final task = _taskFromState();
    await _firestoreService.addTask(task);
  }

   Future<void> _addRepeatingTask(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final task = _taskFromState();
    await _firestoreService.addRepeatingTasks(task);
  }

  void _submit() {
    int days = TaskDifference(_taskStarted, _taskEnded).days;
    _addTask(context);
    for (int i=0; i < days; i++) {
      _taskStarted = _taskStarted.add(Duration(days: 1));
      _addRepeatingTask(context);
    }
  } 

  void _next() {
    _entry = DailyLog(feeling: widget.entry.feeling, symptoms : _symptomsAdded, timeOfOccurance: _timeOfOccurance);
    Navigator.pushNamed(context, Strings.basicQuestionsLogRoute, arguments: _entry);
  }

  List<Step> get _steps => [
    Step(
      isActive: _currentStep >= 0,
      title: Text('Symptoms'),
      subtitle: Text('Check the symptoms you are experiencing'),
      content: CheckBoxGrid(_symptoms, _symptomsValues, _symptomsAdded),
      state: _currentStep > 0 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 1,
      title: Text('Symptoms Started'),
      subtitle: Text('Enter the time the symptoms started'),
      content: TimePicker(
          elevation: 1,
          taskTime: _timeOfOccurance,
          setTime: (dateTime) => setState(() => _timeOfOccurance = dateTime),
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
    if (_currentStep == 0 && _symptomsAdded.isNotEmpty) {
       setState(() => _currentStep ++);
    }
    if (_currentStep == 1 && _timeOfOccurance != null) {
       setState(() => _currentStep ++);
    }
  }

  void _onStepCancel() {
    if (_currentStep < 0) return;
      setState(() =>  _currentStep -= 1);
  }

  Widget _buildTasks() {
    return _choice == '' ? 
      Container(
        child: Row(children: <Widget>[
          FlatButton(child: 
            Text('Add Medicine'),
            color: Theme.of(context).accentColor,
            onPressed: () => _setChoice(Strings.medicine),
          ),
          SizedBox(width: 10),
          FlatButton(child:
            Text('Add Appointment'),
            color: Theme.of(context).backgroundColor,
            onPressed: () => _setChoice(Strings.appointment),
          ),
        ])
      ) :
    _choice == Strings.medicine ? _buildAddMedicine() : _buildAddAppointment();
  }

  Widget _buildAddMedicine() {
    _taskType = Strings.medicine;
    return ContentContainer(
      width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            ExpandableRadioCard('Choose your medicine', Strings.medicineList, _specificTask, (value) => _setSpecificTask(value)),
            SizedBox(height: 10),
            DateRangePickerWidget(
              elevation: 0,
              taskStarted: _taskStarted,
              taskEnded: _taskEnded,
              setTaskStarted: (date) => setState(() => _taskStarted = date), 
              setTaskEnded: (date) => setState(() => _taskEnded = date)),
            SizedBox(height: 10),
            TimePicker(
              elevation: 0,
              taskTime: _taskTime,
              setTime: (dateTime) => setState(() => _taskTime = dateTime),
            ),
              SizedBox(height: 10),
            FlatButton(onPressed: () => _submit(), child: Text('ADD TASK'))
          ])
        )
    );
  }

   Widget _buildAddAppointment() {
    _taskType =  Strings.appointment;
    return ContentContainer(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          ExpandableRadioCard('Choose an appointment', Strings.appointmentList, _specificTask, (value) => _setSpecificTask(value)),
          SizedBox(height: 10),
          DatePickerWidget(
            elevation: 0,
            taskStarted: _taskStarted,
            setTaskStarted: (date) => setState(() => _taskStarted = date), 
            setTaskEnded: (date) => setState(() => _taskEnded = date)),
          SizedBox(height: 10),
          TimePicker(
            elevation: 0,
            taskTime: _taskTime,
            setTime: (dateTime) => setState(() => _taskTime = dateTime),
          ),
          SizedBox(height: 10),
          FlatButton(onPressed: () => _submit(), child: Text('ADD TASK'))
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
      floatingActionButton: _currentStep == _steps.length -1 ? 
      FloatingActionButton(child: Icon(Icons.keyboard_arrow_right, color: Colors.white),
      onPressed: () => _next()) : null
    );
  }
}