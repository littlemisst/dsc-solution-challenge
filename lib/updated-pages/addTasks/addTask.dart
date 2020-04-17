import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/buildGrid.dart';
import 'package:me_daily/common-widgets/iconItem.dart';
import 'package:me_daily/updated-pages/addTasks/addTaskViewItems.dart';
import 'package:me_daily/updated-pages/addTasks/gridItemWidget.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/constants/strings.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _taskType;
  Task task;

  @override
  void initState() {
    super.initState();
  }

  void _chooseTask(String type) {
    _taskType = type;
    task = Task(taskType: _taskType);
    if (task.taskType != null) {
      Navigator.popAndPushNamed(context, Strings.taskViewItemsRoute,
          arguments: task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: FlatButton(
            child: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.popAndPushNamed(context, Strings.initialRoute),
          ),
          title: TextFormat('ADD TASK', Theme.of(context).primaryColor),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _buildTasksGrid(context),
            ],
          ),
        ));
  }

  Widget _buildTasksGrid(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: BuildGridItems([
          GridItem(
            IconItem(AssetImage("images/eat.png"), Strings.eat, 60,
                Theme.of(context).primaryColor, () => _chooseTask(Strings.eat)),
          ),
          GridItem(
            IconItem(AssetImage("images/drink.png"), Strings.drink, 60,
                Theme.of(context).primaryColor, () => _chooseTask(Strings.drink)),
          ),
          GridItem(
            IconItem(AssetImage("images/exercise.png"), Strings.exercise, 60,
                Theme.of(context).primaryColor, () => _chooseTask(Strings.exercise)),
          ),
          GridItem(
            IconItem(
                AssetImage("images/medicine.png"),
                Strings.medicine,
                60,
                Theme.of(context).primaryColor,
                () => _chooseTask(Strings.medicine)),
          ),
          GridItem(
            IconItem(
                AssetImage("images/appointment.png"),
                Strings.appointment,
                60,
                Theme.of(context).primaryColor,
                () => _chooseTask(Strings.appointment)),
          ),
          GridItem(
            IconItem(AssetImage("images/more.png"), Strings.more, 60,
                Theme.of(context).primaryColor, () => _chooseTask(Strings.more)),
          ),
        ], 2, 1));
  }
}
