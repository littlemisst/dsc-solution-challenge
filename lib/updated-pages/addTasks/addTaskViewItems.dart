import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/common-widgets/radioListViewBuilderWidget.dart';
import 'package:me_daily/common-widgets/timePicker.dart';
import 'package:me_daily/common-widgets/dateRangePicker.dart';
import 'package:me_daily/common-widgets/datePickerWidget.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/addTasks/taskDifference.dart';
import 'package:provider/provider.dart';

class TaskViewItems extends StatefulWidget {
  final Task task;
  TaskViewItems({Key key, @required this.task}) : super(key: key);
  @override
  _TaskViewItemsState createState() => _TaskViewItemsState();
}

class _TaskViewItemsState extends State<TaskViewItems> {
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

  Widget _buildMoreDialog() {
    String moreTask = '';
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Add Task',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
              onChanged: (value) => moreTask = value,
              )
            ),
            FlatButton(
              child: Align( alignment: Alignment.bottomRight,
                child: Text('ADD', style: TextStyle(fontSize: 15))), 
              onPressed: () => _setSpecificTask(moreTask)
          )
        ])
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
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
          print("no list");
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
              widget.task.taskType == 'more' ? _buildMoreDialog() :
              _buildListView(),
              SizedBox(height: 15),
              widget.task.taskType == 'book an appointment' ? DatePickerWidget(
                elevation: 1,
                taskStarted: widget.task.taskStarted,
                setTaskStarted: (date) => setState(() {
                  widget.task.taskStarted = date;
                }), 
                setTaskEnded: (date) => setState(() => widget.task.taskEnded = date))
              : DateRangePickerWidget(
                elevation: 1,
                taskStarted: widget.task.taskStarted,
                taskEnded: widget.task.taskEnded,
                setTaskStarted: (date) => setState(() => widget.task.taskStarted = date), 
                setTaskEnded: (date) => setState(() => widget.task.taskEnded = date)),
              SizedBox(height: 15),
              TimePicker(
                elevation: 1,
                taskTime: widget.task.taskTime,
                setTime: (dateTime) => setState(() => widget.task.taskTime = dateTime),
              )
            ]
          )
        ),
      floatingActionButton: 
      (widget.task.specificTask != null && widget.task.taskTime != null && widget.task.taskStarted != null) 
      ? FloatingActionToSave(() async {
         int days = TaskDifference(widget.task.taskStarted, widget.task.taskEnded).days;
        await _firestoreService.addTask(widget.task);
          for (int i=0; i < days; i++) {
            widget.task.taskStarted = widget.task.taskStarted.add(Duration(days: 1));
            await _firestoreService.addRepeatingTasks(widget.task);
          }
          
          Navigator.of(context).popUntil((route) => route.isFirst);
        }, Icons.alarm)
      : null
    );
  }

}


