import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/pages/taskViewItems.dart';


class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  
  final task = new Task(null, DateTime.now(), null, null, null);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _tasksGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _tasksGrid(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.all(18),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2),
        children: <Widget>[
          _gridItem(context, new AssetImage("images/dish.png"), 'Eat'),
          _gridItem(context, new AssetImage("images/wine_bottle.png"), 'Drink'),
          _gridItem(context, new AssetImage("images/barbell.png"), 'Exercise'),
          _gridItem(
              context, new AssetImage("images/medical_tablet.png"), 'Medicine'),
          _gridItem(context, new AssetImage("images/medical_history.png"),
              'Appointment'),
          _gridItem(context, new AssetImage("images/add.png"), 'More'),
        ],
      ),
    );
  }

  Widget _gridItem(BuildContext context, icon, text) {
    var flatButton = FlatButton(
        padding: EdgeInsets.all(10),
        child: ImageIcon(icon, size: 50, color: Colors.white),
        color: Colors.pink[100],
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () {
          task.taskType = text;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskViewItems(task: task)),
          );
        });
    return Column(
      children: <Widget>[
        flatButton,
        SizedBox(height: 10),
        Text(text, style: TextStyle(fontSize: 11)),
      ],
    );
  }
}
