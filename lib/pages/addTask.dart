import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/pages/taskViewItems.dart';

class AddTask extends StatelessWidget {
  final Task task;
  AddTask({Key key, @required this.task}) : super(key: key);
  final db = Firestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            _tasksGrid(context),
          ],
        ),
      )
    );
  }

  Widget _tasksGrid(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2),
        children: <Widget>[
          _gridItem(context, new AssetImage("images/dish.png"), 'Eat'),
          _gridItem(context, new AssetImage("images/wine_bottle.png"), 'Drink'),
          _gridItem(context, new AssetImage("images/barbell.png"), 'Exercise'),
          _gridItem(context, new AssetImage("images/medical_tablet.png"), 'Medicine'),
          _gridItem(context,
              new AssetImage("images/medical_history.png"), 'Appointment'),
          _gridItem(context, new AssetImage("images/add.png"), 'More')
        ],
      ),
    );
  }

  Widget _gridItem(BuildContext context, icon, text) {
    return Column(
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(10),
          child: ImageIcon(icon, size: 50, color: Colors.white),
          color: Colors.pink[100],
          shape: CircleBorder(side: BorderSide.none),
          onPressed: () {
            task.taskType = text;
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => TaskViewItems(task: task)),
            );
          }
        ),
        SizedBox(height: 10),
        Text(
          text, style: TextStyle(fontSize: 11),)
      ],
    );
  }
}
