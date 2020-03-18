import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/updated-pages/dailyLogs/expandableWidget.dart';

class BasicQuestionsPage extends StatefulWidget {
  @override
  _BasicQuestionsPageState createState() => _BasicQuestionsPageState();
}

class _BasicQuestionsPageState extends State<BasicQuestionsPage> {
  String _food;
  String _drink;
  String _exercise;

  void _setFood(value) {
    setState(() {
     _food = value;
      //insert pag butang sa db;
    });
  }

  void _setDrink(value) {
    setState(() {
     _drink = value;
      //insert pag butang sa db;
    });
  }

  void _setExercise(value) {
    setState(() {
     _exercise= value;
      //insert pag butang sa db;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.height/10, MediaQuery.of(context).size.width/10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('What have you been up to?', style: TextStyle(fontSize: 20)),
            SizedBox(height: 15),
            ExpandableCard(ImageIcon(AssetImage("images/food.png"), color: Colors.pink[100],),'FOOD', Strings.food, _food, (value) => _setFood(value)),
            SizedBox(height: 15),
            ExpandableCard(ImageIcon(AssetImage("images/drink.png"), color: Colors.pink[100]),'DRINK', Strings.drink, _drink, (value) => _setDrink(value)),
             SizedBox(height: 15),
            ExpandableCard(ImageIcon(AssetImage("images/exercise.png"), color: Colors.pink[100]),'EXERCISE', Strings.exercise, _exercise, (value) => _setExercise(value))
          ],
        ),
      )
    );
  }
}