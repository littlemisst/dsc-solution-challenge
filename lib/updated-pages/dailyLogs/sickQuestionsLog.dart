import 'package:flutter/material.dart';
import 'package:flutter_scale/flutter_scale.dart';
import 'package:me_daily/common-widgets/timePicker.dart';
import 'package:me_daily/common-widgets/dateRangePicker.dart';
import 'package:me_daily/common-widgets/datePickerWidget.dart';
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

  ScrollController _temperatureController;
  final celciusController = TextEditingController();
  String _taskType;
  String _specificTask;
  Task task;
  
  @override
  void initState() {
    super.initState();
    widget.entry.symptoms = List<String>();

    _temperatureController = ScrollController(initialScrollOffset: 7400);
    celciusController.addListener(() {
      widget.entry.temperature = double.parse(celciusController.text);
    });

    task = Task(taskType: _taskType
    );
    _taskType = '';
    _specificTask = '';


    setState(() {
      for(int i=0; i < _symptoms.length; i++){
        _symptomsValues.add(false);
      }
    });
  }

  void _handleTemperatureScaleChanged(int scalePoints) {
    int offSet = scalePoints ~/ 20;
    double celcius = (offSet * 10)/100;
    celciusController.text = celcius.toString();
  }

  void _setSpecificTask(value) {
    setState(() {
      _specificTask = value;
      task.specificTask = _specificTask;
    });
  }

  List<Step> get _steps => [
    Step(
      title: Text('Symptoms'),
      subtitle: Text('Check the symptoms you are experiencing'),
      content: CheckBoxGrid(_symptoms, _symptomsValues, widget.entry.symptoms),
      state: _currentStep > 0 ? StepState.complete : StepState.editing
      ),
    Step(
      title: Text('Temperature'),
      subtitle: Text('Enter your current body temperature'),
      content: _buildTemperature(),
      state: _currentStep > 1 ? StepState.complete : StepState.editing
      ),
    Step(
      title: Text('Symptoms Started'),
      subtitle: Text('Enter the time the symptoms started'),
      content: TimePicker(
                elevation: 1,
                taskTime: widget.entry.timeOfOccurance,
                setTime: (dateTime) => setState(() => widget.entry.timeOfOccurance = dateTime),
              ),
      state: _currentStep > 2 ? StepState.complete : StepState.editing
      ),
    Step(
      title: Text('Add Medicine'),
      content: _buildAddMedicine(),
      state: _currentStep > 3 ? StepState.complete : StepState.editing
      ),
    Step(
      title: Text('Add an Appointment'),
      content: _buildAddAppointment(),
      state: _currentStep > 4 ? StepState.complete : StepState.editing
      )
  ];

  void _onStepContinue() {
    if (_currentStep == 0 && widget.entry.symptoms.isNotEmpty) {
       setState(() {
          _currentStep ++;
      });
    }
    if (_currentStep == 1 && widget.entry.temperature != null) {
       setState(() {
          _currentStep ++;
      });
    }
    if (_currentStep == 2 && widget.entry.timeOfOccurance != null) {
       setState(() {
          _currentStep ++;
          _taskType = 'take medicine';
          task.taskType = _taskType;
      });
    }
    if (_currentStep == 3) {
       setState(() {
          _currentStep ++;
          _taskType = 'book an appointment';
          task.taskType = _taskType;
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep < 0) return;
      setState(() {
        _currentStep -= 1;
      });
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
      width: MediaQuery.of(context).size.width / 3,
      height: 50.0,
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        style: TextStyle(fontSize: 15),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            hintText: '37.0 °C', suffixText: '°C',
            focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink[100])),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
      ),
    );
  }

   Widget _buildTemperature() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Align(
        child: Material(
          color: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(25),
            child:  Column(children: <Widget>[
              _buildTemperatureField(context, celciusController),
              SizedBox(height: 10),
              _buildTemperatureScale(context, _temperatureController, _handleTemperatureScaleChanged)
            ]),
          )
        )
      )
    );
  }

  Widget _buildAddMedicine() {
      final user = Provider.of<User>(context);
      final _firestoreService = FirestoreService(uid: user.uid);
      return Container(
      width: MediaQuery.of(context).size.width,
      child: Align(
        child: Material(
          color: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
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
        )
      )
    );
  }

   Widget _buildAddAppointment() {
     final user = Provider.of<User>(context);
      final _firestoreService = FirestoreService(uid: user.uid);
      return Container(
      width: MediaQuery.of(context).size.width,
      child: Align(
        child: Material(
          color: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
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
        )
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('What do you feel?'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: StepperWidget(_currentStep, () => _onStepContinue(), ()=>_onStepCancel(), _steps),
      floatingActionButton: _currentStep == _steps.length -1 ? FloatingActionButton(child: Icon(Icons.keyboard_arrow_right) , onPressed: () =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => BasicQuestionsLogPage(entry: widget.entry)))) : null
    );
  }
}