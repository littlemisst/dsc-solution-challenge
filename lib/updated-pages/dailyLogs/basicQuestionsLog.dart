import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/alertDialog.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/checkBoxContainer.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/common-widgets/stepperWidget.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/dailyLogs/incrementCardWidget.dart';
import 'package:me_daily/updated-pages/dailyLogs/itemSummaryBuilder.dart';
import 'package:me_daily/updated-pages/dailyLogs/listSummaryBuilderWidget.dart';
import 'package:provider/provider.dart';

class BasicQuestionsLogPage extends StatefulWidget {
  final DailyLog entry;
  BasicQuestionsLogPage({Key key, @required this.entry}) : super(key: key);

  @override
  _BasicQuestionsLogPageState createState() => _BasicQuestionsLogPageState();
}

class _BasicQuestionsLogPageState extends State<BasicQuestionsLogPage> {
  int _currentStep = 0;
  List<String> _food = Strings.foodList;
  List<bool> _foodValues = List<bool>();

  List<String> _drink = Strings.drinkList;
  List<bool> _drinkValues = List<bool>();
  
  List<String> _exercise = Strings.exerciseList;
  List<bool> _exerciseValues = List<bool>();

  List<String> _foodAdded;
  List<String> _drinkAdded;
  List<String> _exerciseAdded;

  int _hoursOfSleep;

  void _incrementSleepHours() {
    setState(() {
     _hoursOfSleep++;
    });
  }

  void _decrementSleepHours() {
    setState(() {
     _hoursOfSleep--;
    });
    if (_hoursOfSleep < 0) {
      _hoursOfSleep = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _hoursOfSleep = 0;
    _foodAdded = [];
    _drinkAdded = [];
    _exerciseAdded = [];

    setState(() {
      for(int i=0; i < _food.length; i++){
        _foodValues.add(false);
      }
      for(int i=0; i < _drink.length; i++){
        _drinkValues.add(false);
      }
      for(int i=0; i < _exercise.length; i++){
        _exerciseValues.add(false);
      }
    });
  }

   DailyLog _logFromState() {
    return DailyLog(
      feeling: widget.entry.feeling,
      food: _foodAdded,
      drink: _drinkAdded,
      exercise: _exerciseAdded,
      hoursSlept: _hoursOfSleep,
      symptoms: widget.entry.symptoms,
      timeOfOccurance: widget.entry.timeOfOccurance
    );
  }

  Future<void> _addLog(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final log = _logFromState();
    await _firestoreService.addDailyLog(log);
  }

  void _submit() {
    _addLog(context);
    Navigator.popAndPushNamed(context, Strings.initialRoute);
  } 

  List<Step> get _steps => [
    Step(
      isActive: _currentStep >= 0,
      title: Text('Eating',),
      content: CheckBoxGrid(6, _food, _foodValues, _foodAdded),
      state: _currentStep > 0 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 1,
      title: Text('Drinking'),
      content: CheckBoxGrid(6, _drink, _drinkValues, _drinkAdded),
      state: _currentStep > 1 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 2,
      title: Text('Exercising'),
      content: CheckBoxGrid(6, _exercise, _exerciseValues, _exerciseAdded),
      state: _currentStep > 2 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 3,
      title: Text('Hours of Sleep'),
      content: IncrementCard(
        timesText: 'Hours', 
        intText: _hoursOfSleep, 
        onPressedIncrement: _incrementSleepHours, 
        onPressedDecrement: _decrementSleepHours),
      state: _currentStep > 3 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 4,
      title: Text('Today\'s Log Summary'),
      content: _buildSummary(),
      state: _currentStep > 4 ? StepState.complete : StepState.editing
      )
  ];

  void _onStepContinue() {
    if (_currentStep == 0 && _foodAdded.isNotEmpty) {
       setState(() => _currentStep ++);
    }
    if (_currentStep == 1 && _drinkAdded.isNotEmpty) {
      setState(() =>  _currentStep ++);
    }
    if (_currentStep == 2 && _exerciseAdded.isNotEmpty) {
      setState(() =>  _currentStep ++);
    }
    if (_currentStep == 3 && _hoursOfSleep > 0) {
      setState(() =>  _currentStep ++);
    }
  }

  void _onStepCancel() {
    if (_currentStep < 0) return;
      setState(() {
        _currentStep -= 1;
      });
  }

  Widget _buildSummary() {
     return ContentContainer(
       width: MediaQuery.of(context).size.width,
       child: Container(
          padding: EdgeInsets.all(25),
          child: Column(children: <Widget>[
          ListSummaryBuilder('Eaten', _foodAdded), 
          ListSummaryBuilder('Drank', _drinkAdded),
          ListSummaryBuilder('Exercised', _exerciseAdded),
          ItemSummaryBuilder('Hours Slept', _hoursOfSleep),
        ]),
      ),
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('What have you been up to?'),
      ),
      body: StepperWidget(StepperType.vertical, _currentStep, () => _onStepContinue(), ()=>_onStepCancel(), _steps),
      floatingActionButton: _currentStep == _steps.length -1 ? 
      FloatingActionToSave(() async {
          final action = await Dialogs.showDialogBox(context, Strings.confirmLog);
          if (action == DialogAction.yes) _submit();
        }, Icons.check) : null,
    );
  }
}