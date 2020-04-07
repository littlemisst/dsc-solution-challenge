import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/buildGrid.dart';
import 'package:me_daily/common-widgets/radioListViewBuilderWidget.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/updated-pages/dailyLogs/checkBoxWidget.dart';
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
  
  // Map<String, bool> values = {
  //   'foo' : true,
  //   'bar' : false
  // };

  @override
  void initState() {
    super.initState();
    setState(() {
      for(int i=0; i < _food.length; i++){
        _foodValues.add(false);
      }
      for(int i=0; i < _drink.length; i++){
        _drinkValues.add(false);
      }
    });
  }

  void _itemChange(List values, bool value, int index) {
    setState(() {
      values[index] = value;
    });
  }

  Widget _buildCheckBoxList() {
    print(_foodValues);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
      shrinkWrap: true,
      itemCount: _food.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 6) ,
      itemBuilder: (BuildContext context, int index) {
        return LogCheckBox(_food[index], _foodValues[index], (value) {
          _itemChange(_foodValues, value, index);
        });
      },
      )
    );
  }
//   }

Widget _buildCheckBoxDrinkList() {
    return Container(
       child: Align (
        child: Material(
          color: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _drink.length,
            itemBuilder: (BuildContext context, int index) {
              return LogCheckBox(_drink[index], _drinkValues[index], (value) {
                _itemChange(_drinkValues, value, index);
              });
            },
          )
        )
       )
    );
  }


  List<Step> get _steps => [
    Step(
      title: Text('Eating'),
      content: _buildCheckBoxList()),
      Step(
      title: Text('Drinking'),
      content: _buildCheckBoxDrinkList())

  ];


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