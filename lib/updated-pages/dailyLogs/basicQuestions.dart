import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/dailyLogs/expandableWidget.dart';
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
     widget.entry.hoursSlept = _hoursOfSleep;
    });
  }

  void _decrementSleepHours() {
    setState(() {
     _hoursOfSleep--;
    widget.entry.hoursSlept = _hoursOfSleep;
    });
    if (_hoursOfSleep < 0) {
      _hoursOfSleep = 0;
    }
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
            Text('What have you been up to?', style: TextStyle(fontSize: 20)),
            SizedBox(height: 15),
            ExpandableCard(ImageIcon(AssetImage("images/food.png"), color: Colors.pink[100],),'FOOD', Strings.food, _food, (value) => _setFood(value)),
            SizedBox(height: 15),
            ExpandableCard(ImageIcon(AssetImage("images/drink.png"), color: Colors.pink[100]),'DRINK', Strings.drink, _drink, (value) => _setDrink(value)),
            SizedBox(height: 15),
            ExpandableCard(ImageIcon(AssetImage("images/exercise.png"), color: Colors.pink[100]),'EXERCISE', Strings.exercise, _exercise, (value) => _setExercise(value)),
             SizedBox(height: 15),
            ExpansionTile(leading: ImageIcon(AssetImage("images/sleep.png"), color: Colors.pink[100]),
                title: Text('SLEEP'),
                children: <Widget>[
                  Row(children: <Widget>[
                    Text('Number of hours: ', style: TextStyle(fontSize: 15)),
                    SizedBox(width: 10),
                    Text('$_hoursOfSleep', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    FlatButton(child: ImageIcon(AssetImage("images/add.png"), color: Colors.pink[100],), color: Colors.white, shape: CircleBorder(side: BorderSide.none),onPressed: _incrementSleepHours),
                    FlatButton(child: ImageIcon(AssetImage("images/minus.png"), color: Colors.pink[100],), color: Colors.white, shape: CircleBorder(side: BorderSide.none),onPressed: _decrementSleepHours)
                  ],)
                ],
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[100],
        onPressed: () async {
          print(widget.entry);
          await _firestoreService.addDailyLog(widget.entry);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Icon(Icons.check, color: Colors.white)),
    );
  }
}