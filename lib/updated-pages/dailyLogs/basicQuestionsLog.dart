import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/updated-pages/dailyLogs/checkBoxContainer.dart';
import 'package:me_daily/updated-pages/dailyLogs/stepperWidget.dart';

class BasicQuestionsLogPage extends StatefulWidget {
  final DailyLog entry;
  BasicQuestionsLogPage({Key key, @required this.entry}) : super(key: key);

  @override
  _BasicQuestionsLogPageState createState() => _BasicQuestionsLogPageState();
}

class _BasicQuestionsLogPageState extends State<BasicQuestionsLogPage> {
  int _currentStep = 0;
  List<String> _food = Strings.food;
  List<String> _drink = Strings.drink;
  List<bool> _drinkValues = List<bool>();
  List<bool> _foodValues = List<bool>();


  @override
  void initState() {
    super.initState();
    widget.entry.food = List<String>();
    widget.entry.drink = List<String>();
    setState(() {
      for(int i=0; i < _food.length; i++){
        _foodValues.add(false);
      }
      for(int i=0; i < _drink.length; i++){
        _drinkValues.add(false);
      }
    });
  }


  List<Step> get _steps => [
    Step(
      title: Text('Eating'),
      content: CheckBoxGrid(_food, _foodValues, widget.entry.food)),
      Step(
      title: Text('Drinking'),
      content: CheckBoxGrid(_drink, _drinkValues, widget.entry.drink))

  ];


  void _onStepContinue() {
    if (_currentStep >= _steps.length) return;
    if (widget.entry.food.isNotEmpty || widget.entry.drink.isNotEmpty) {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('What have you been up to?'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: StepperWidget(_currentStep, () => _onStepContinue(), ()=>_onStepCancel(), _steps)
    );
  }
  

  



}