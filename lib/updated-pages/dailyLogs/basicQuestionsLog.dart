import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:me_daily/common-widgets/buildGrid.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/updated-pages/dailyLogs/checkBoxWidget.dart';
import 'package:me_daily/updated-pages/dailyLogs/stepperWidget.dart';

class BasicQuestionsLogPage extends StatefulWidget {
  @override
  _BasicQuestionsLogPageState createState() => _BasicQuestionsLogPageState();
}

class _BasicQuestionsLogPageState extends State<BasicQuestionsLogPage> {
  int _currentStep = 0;
  List<String> _tasksDone;


  @override
  void initState() {
    super.initState();
    _buildCheckListGrid();
    );
  }

   Widget _buildCheckListGrid() {
    return 
  }

  List<Step> _steps = [
    Step(
      title: Text('Eating'),
      content: Container(
      padding: EdgeInsets.all(5),
      child: BuildGridItems([
       LogCheckBox('title', false, () => _setTaskState())
      ], 2, 6)
    );
    )

  ];

  void _setTaskState(task, newValue, stringValue) {
    setState(() {
     task = newValue;
      _tasksDone.add(stringValue);
    });
  }

  void _onStepContinue() {
    if (_currentStep >= _steps.length) return;
      setState(() {
        _currentStep += 1;
      });
  }

  void _onStepCancel() {
    if (_currentStep <= 0) return;
      setState(() {
        _currentStep -= 1;
      });
  }


  List<String> _foodChecked = Strings.food;

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('What have you been up to?'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: StepperWidget(_currentStep, () => _onStepContinue(), ()=>_onStepCancel(), stepsList)
    );
  }
}