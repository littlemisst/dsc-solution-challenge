import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.task.taskType, style: TextStyle(color: Colors.pink[100])),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BuildRadioListView(_items, _specificTask, (value) => _setSpecificTask(value)));
  }
}