import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/dailyLogs/expandableIncrementWidget.dart';
import 'package:me_daily/updated-pages/dailyLogs/expandableRadioWidget.dart';
import 'package:provider/provider.dart';

class BasicQuestionsPage extends StatefulWidget {
  final DailyLog entry;
  BasicQuestionsPage({Key key, @required this.entry}) : super(key: key);
  @override
  _BasicQuestionsPageState createState() => _BasicQuestionsPageState();
}

class _BasicQuestionsPageState extends State<BasicQuestionsPage> {
  String _food;
  String _drink;
  String _exercise;
  int _hoursOfSleep = 0;
  int _glassOfWater = 0;

  void _setFood(value) {
    setState(() {
     _food = value;
     widget.entry.food = _food;
    });
  }

  void _setDrink(value) {
    setState(() {
     _drink = value;
     widget.entry.drink = _drink;
    });
  }

  void _setExercise(value) {
    setState(() {
     _exercise= value;
    widget.entry.exercise = _exercise;
    });
  }

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

  void _incrementGlassCount() {
    setState(() {
     _glassOfWater++;
    });
  }

  void _decrementGlassCount() {
    setState(() {
     _glassOfWater--;
    });
    if (_glassOfWater < 0) {
      _glassOfWater = 0;
    }
  }

  void _setWaterCount() {
    setState(() {
     widget.entry.waterDrank = _glassOfWater;
    });
  }


  @override
  void initState() {
    super.initState();
    _food = '';
    _drink = '';
    _exercise = '';
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/10, 10, MediaQuery.of(context).size.width/10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('WHAT HAVE YOU BEEN UP TO?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            ExpandableRadioCard(ImageIcon(AssetImage("images/food.png"), color: Colors.pink[100],),'FOOD', Strings.food, _food, (value) => _setFood(value)),
            SizedBox(height: 15),
            ExpandableRadioCard(ImageIcon(AssetImage("images/drink.png"), color: Colors.pink[100]),'DRINK', Strings.drink, _drink, (value) => _setDrink(value)),
            SizedBox(height: 15),
            ExpandableRadioCard(ImageIcon(AssetImage("images/exercise.png"), color: Colors.pink[100]),'EXERCISE', Strings.exercise, _exercise, (value) => _setExercise(value)),
            SizedBox(height: 15),
            ExpandableIncrementCard(AssetImage("images/sleep.png"), 'SLEEP', 'Number of hours: ', _hoursOfSleep, _incrementSleepHours, _decrementSleepHours, _setSleepHours),
            SizedBox(height: 15),
            ExpandableIncrementCard(AssetImage("images/water.png"), 'WATER', 'Glasses: ', _glassOfWater, _incrementGlassCount, _decrementGlassCount, _setWaterCount)
          ],
        ),
      ),
      floatingActionButton: FloatingActionToSave(() async {
        await _firestoreService.addDailyLog(widget.entry);
        Navigator.of(context).popUntil((route) => route.isFirst);
      }, Icons.check)
    );
  }
}
