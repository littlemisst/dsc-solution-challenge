import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/api/add_task_api.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/pages/taskViewItems.dart';


class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final task = new Task(null, DateTime.now(), null, null, null, null);
  DateTime _startTask =DateTime.now();
  DateTime _endTask = DateTime.now();
  DateTime _time = DateTime.now();

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
            Text('CHOOSE A TASK TO DO', style: TextStyle(fontSize: 18.0)),
            _tasksGrid(context),
            SizedBox(height: 24),
            _showDatePicker('start'),
            SizedBox(height: 24),
            _showDatePicker('end'),
            SizedBox(height: 24),
            _showTimePicker()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[100],
        onPressed: ()  {
          if (task.taskType == null || task.specificTask == null || task.taskEnded == null || task.taskStarted == null || task.time == null) {
          print('may null');
        } else {
          addTask(task);
        }

        Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Icon(Icons.alarm, color: Colors.white,)
      ),
    );
  }

  Widget _tasksGrid(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(14),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 3 / 2),
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
        padding: EdgeInsets.all(8),
        child: ImageIcon(icon, size:40, color: Colors.white,),
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
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget _showDatePicker(indicator) {
    final format = DateFormat("yMMMMd");
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
            labelText: indicator),
        format: format,
        onShowPicker: (context, currentValue) async {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        onChanged: (value) {
          setState(() {
            if (indicator == 'start') {
              _startTask = value;
              task.taskStarted = _startTask;
            } else if (indicator == 'end') {
              _endTask = value;
              task.taskEnded = _endTask;
            }
          });
        }  
      ),
    ]);
  }

  Widget _showTimePicker() {
    final format = DateFormat("HH:mm");
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
            labelText: 'time'),
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
        onChanged: (value) => {
         setState(() {
          _time = value;
          task.time= _time;
          })
        }
      ),
    ]);
  }
}
