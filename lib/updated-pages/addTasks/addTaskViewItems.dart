import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/common-widgets/radioListViewBuilderWidget.dart';
import 'package:me_daily/common-widgets/timePicker.dart';
import 'package:me_daily/common-widgets/dateRangePicker.dart';
import 'package:me_daily/common-widgets/datePickerWidget.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
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
  DateTime _taskStarted;
  DateTime _taskEnded;
  DateTime _taskTime;

  List<dynamic> _items;

  @override
  void initState() {
    super.initState();
    _specificTask = '';
    _items = [];
  }

   Task _taskFromState() {
    return Task(
      taskType: widget.task.taskType,
      specificTask: _specificTask,
      taskStarted: _taskStarted,
      taskEnded: _taskEnded,
      taskTime: _taskTime
    );
  }

  Future<void> _addTask(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final task = _taskFromState();
    await _firestoreService.addTask(task);
  }

   Future<void> _addRepeatingTask(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final task = _taskFromState();
    await _firestoreService.addRepeatingTasks(task);
  }

  void _setSpecificTask(value) {
    setState(() =>
      _specificTask = value);
  }

  void _submit() {
    int days = TaskDifference(_taskStarted, _taskEnded).days;
    _addTask(context);
    for (int i=0; i < days; i++) {
      _taskStarted = _taskStarted.add(Duration(days: 1));
      _addRepeatingTask(context);
    }
    Navigator.popAndPushNamed(context, Strings.initialRoute);
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
    return ContentContainer(
      width: MediaQuery.of(context).size.width,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    
    switch (widget.task.taskType) {
      case Strings.eat:
          _items = Strings.foodList;
        break;
      case Strings.drink:
          _items = Strings.drinkList;
        break;
      case Strings.exercise:
          _items = Strings.exerciseList;
        break;
      case Strings.medicine:
          _items = Strings.medicineList;
        break;
      case Strings.appointment:
          _items = Strings.appointmentList;
        break;
      default:
          print("no list");
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: TextFormat(widget.task.taskType)),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              widget.task.taskType == Strings.more ? _buildMoreDialog() :
              _buildListView(),
              SizedBox(height: 15),
              widget.task.taskType == Strings.appointment ? DatePickerWidget(
                elevation: 1,
                taskStarted: _taskStarted,
                setTaskStarted: (date) => setState(() => _taskStarted = date),
                setTaskEnded: (date) => setState(() => _taskEnded = date))
              : DateRangePickerWidget(
                elevation: 1,
                taskStarted: _taskStarted,
                taskEnded: _taskEnded,
                setTaskStarted: (date) => setState(() => _taskStarted = date), 
                setTaskEnded: (date) => setState(() => _taskEnded = date)),
              SizedBox(height: 15),
              TimePicker(
                elevation: 1,
                taskTime: _taskTime,
                setTime: (dateTime) => setState(() => _taskTime = dateTime),
              )
            ]
          )
        ),
      floatingActionButton: 
      (_specificTask != null && _taskTime != null && _taskStarted != null) 
      ? FloatingActionToSave(() => _submit(), Icons.alarm) : null
    );
  }

}


