import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'package:me_daily/common-widgets/radioListViewBuilderWidget.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/task.dart';

class TaskViewItems extends StatefulWidget {
  final Task task;
  TaskViewItems({Key key, @required this.task}) : super(key: key);
  @override
  _TaskViewItemsState createState() => _TaskViewItemsState();
}

class _TaskViewItemsState extends State<TaskViewItems> {
  Task task;
  String _specificTask;
  List<dynamic> _items;

  @override
  void initState() {
    super.initState();
    _specificTask = '';
    _items = [];
  }

  void _setSpecificTask(value) {
    setState(() {
      _specificTask = value;
      widget.task.specificTask = _specificTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.task.taskType) {
      case "eat":
        {
          _items = Strings.food;
        }
        break;
      case "drink":
        {
          _items = Strings.drink;
        }
        break;
      case "exercise":
        {
          _items = Strings.exercise;
        }
        break;
      case "take medicine":
        {
          _items = Strings.medicine;
        }
        break;
      case "book an appointment":
        {
          _items = Strings.appointment;
        }
        break;
      default:
        {
          print("should not be!");
        }
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ADD TASK - ${widget.task.taskType}'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _buildListView(),
              SizedBox(height: 15),
              _buildSelectDates(),
              SizedBox(height: 15),
              _buildTimePicker()
            ]
          )
        ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[100],
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.check, color: Colors.white)));
  }

  Widget _buildListView() {
    return Container(
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: BuildRadioListView(
            _items, _specificTask, (value) => _setSpecificTask(value))
      )
    );
  }

  Widget _buildSelectDates() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: ()=> _displayDatePicker(context), 
              child: Row(children: <Widget>[
                Icon(Icons.calendar_today),
                SizedBox(width: 15),
                widget.task.taskStarted != null ?
                Text('Change Date') : Text('Select Date'),
              ])),
            widget.task.taskStarted != null ? 
            Container(
              padding: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Text('Start of Task: ', style: TextStyle(fontSize: 15)),
                  SizedBox(width: 10),
                  Align(alignment: Alignment.topLeft,
                  child: Text(
                    DateFormat.yMMMd().format(widget.task.taskStarted), 
                    style: TextStyle(fontSize: 15)))
                ]), 
                SizedBox(height: 10),
                 Row(children: <Widget>[
                  Text('End of Task: ', style: TextStyle(fontSize: 15)),
                  SizedBox(width: 10),
                  Align(alignment: Alignment.topLeft,
                  child: Text(
                    DateFormat.yMMMd().format(widget.task.taskEnded), 
                    style: TextStyle(fontSize: 15)))
                ]),
              ])
            ) : 
            Container(
              padding: EdgeInsets.all(15),
              child: Align(alignment: Alignment.topLeft,
                child: Text('No dates selected')
              )
            ),
        ])
        
      )
    );
  }
  Future _displayDatePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
      context: context, 
      initialFirstDate: DateTime.now(), 
      initialLastDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year - 50), 
      lastDate: DateTime(DateTime.now().year + 50),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        widget.task.taskStarted = picked[0];
        widget.task.taskEnded = picked[1];
      });
    }
  }
  Widget _buildTimePicker() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: ()=> _displayTimePicker(context), 
              child: Row(children: <Widget>[
                Icon(Icons.alarm),
                SizedBox(width: 15),
                widget.task.taskTime != null ?
                Text('Change Time') : Text('Select Time'),
              ])),
            widget.task.taskTime != null ? 
            Container(
              padding: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Text('Task Time: ', style: TextStyle(fontSize: 15)),
                  SizedBox(width: 10),
                  Align(alignment: Alignment.topLeft,
                  child: Text(widget.task.taskTime, 
                    style: TextStyle(fontSize: 15)))
                ])
              ])
            ) : 
            Container(
              padding: EdgeInsets.all(15),
              child: Align(alignment: Alignment.topLeft,
                child: Text('Time not selected')
              )
            ),
          ]
        )
      )
    );
  }

  Future _displayTimePicker(BuildContext context) async {
   TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );
    if(time != null) {
      setState(() {
        widget.task.taskTime = '${time.hour} : ${time.minute}';
      });
    }
  }
}
