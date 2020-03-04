import 'package:flutter/material.dart';
import 'package:me_daily/api/add_task_api.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/pages/taskViewItems.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  final task = new Task(null, DateTime.now(), null, null, null);

  Future displayDatePicker(BuildContext context) async {
    final List<DateTime> dateSelected = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (dateSelected != null && dateSelected.length == 2) {
      setState(() {
        _startDate = dateSelected[0];
        task.taskStarted = _startDate;
        _endDate = dateSelected[1];
        task.taskEnded = _endDate;
      });
    }
  }

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
            _selectDatePicker(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[100],
          onPressed: () async {
            addTask(task);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Icon(Icons.add)),
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

  Widget _selectDatePicker(BuildContext context) {
    return Container(
        child: RaisedButton(
            child: Text('Select Date'),
            onPressed: () async {
              await displayDatePicker(context);
            }));
  }
}
