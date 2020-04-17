import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/dailyLogs/checkBoxContainer.dart';
import 'package:me_daily/updated-pages/dailyLogs/incrementCardWidget.dart';
import 'package:me_daily/updated-pages/dailyLogs/itemSummaryBuilder.dart';
import 'package:me_daily/updated-pages/dailyLogs/listSummaryBuilderWidget.dart';
import 'package:me_daily/updated-pages/dailyLogs/stepperWidget.dart';
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

  int _hoursOfSleep = 0;

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

  void _setSleepHours() {
    setState(() {
     widget.entry.hoursSlept = _hoursOfSleep;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.entry.food = List<String>();
    widget.entry.drink = List<String>();
    widget.entry.exercise = List<String>();

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

  List<Step> get _steps => [
    Step(
      isActive: _currentStep >= 0,
      title: Text('Eating',),
      content: CheckBoxGrid(_food, _foodValues, widget.entry.food),
      state: _currentStep > 0 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 1,
      title: Text('Drinking'),
      content: CheckBoxGrid(_drink, _drinkValues, widget.entry.drink),
      state: _currentStep > 1 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 2,
      title: Text('Exercising'),
      content: CheckBoxGrid(_exercise, _exerciseValues, widget.entry.exercise),
      state: _currentStep > 2 ? StepState.complete : StepState.editing
      ),
    Step(
      isActive: _currentStep >= 3,
      title: Text('Hours of Sleep'),
      content: IncrementCard('Hours', _hoursOfSleep, _incrementSleepHours, _decrementSleepHours, _setSleepHours),
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
    if (_currentStep == 0 && widget.entry.food.isNotEmpty) {
       setState(() {
          _currentStep ++;
      });
    }
    if (_currentStep == 1 && widget.entry.drink.isNotEmpty) {
      setState(() {
          _currentStep ++;
      });
    }
    if (_currentStep == 2 && widget.entry.exercise.isNotEmpty) {
      setState(() {
          _currentStep ++;
      });
    }
    if (_currentStep == 3 && widget.entry.hoursSlept != null) {
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

  Widget _buildSummary() {
     return ContentContainer(
       width: MediaQuery.of(context).size.width,
       child: Container(
          padding: EdgeInsets.all(25),
          child: Column(children: <Widget>[
          ListSummaryBuilder('Eaten', widget.entry.food), 
          ListSummaryBuilder('Drank', widget.entry.drink),
          ListSummaryBuilder('Exercised', widget.entry.exercise),
          ItemSummaryBuilder('Hours Slept', widget.entry.hoursSlept),
        ]),
      ),
     );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextFormat('What have you been up to?', Theme.of(context).accentColor),
      ),
      body: StepperWidget(_currentStep, () => _onStepContinue(), ()=>_onStepCancel(), _steps),
      floatingActionButton: _currentStep == _steps.length -1 ? FloatingActionToSave(() async {
        await _firestoreService.addDailyLog(widget.entry);
        Navigator.of(context).popUntil((route) => route.isFirst);
      }, Icons.check) : null,
    );
  }
}