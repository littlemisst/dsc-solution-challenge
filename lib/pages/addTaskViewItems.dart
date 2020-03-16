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
    widget.task.specificTask = _specificTask;
    print(widget.task.specificTask);
    switch (widget.task.taskType) {
      case "Eat":
        {
          _items = Strings.eatItems;
        }
        break;
      case "Drink":
        {
          _items = Strings.drinkItems;
        }
        break;
      case "Exercise":
        {
          _items = Strings.exerciseItems;
        }
        break;
      case "Medicine":
        {
          _items = Strings.medicineItems;
        }
        break;
      case "Appointment":
        {
          _items = Strings.appointmentItems;
        }
        break;
      case "More":
        {}
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
                });
              }));
        }),
    );
  }
}