import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            title: Text(item),
            leading: Radio(
              value: item,
              groupValue: _specificTask,
              onChanged: (value) {
                setState(() {
                  _specificTask = value;
                  widget.task.specificTask = _specificTask;
                });
              }));
        }),
    );
  }
}