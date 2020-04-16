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
    task = Task(taskType: _taskType);
    _taskType = '';
  }

  void _chooseTask(String type) {
    setState(() {
      _taskType = type;
      task.taskType = _taskType;
    });
    print(task.taskType);
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
            IconItem(AssetImage("images/eat.png"), 'eat', 60,
                Theme.of(context).primaryColor, () => _chooseTask('eat')),
          ),
          GridItem(
            IconItem(AssetImage("images/drink.png"), 'drink', 60,
                Theme.of(context).primaryColor, () => _chooseTask('drink')),
          ),
          GridItem(
            IconItem(AssetImage("images/exercise.png"), 'exercise', 60,
                Theme.of(context).primaryColor, () => _chooseTask('exercise')),
          ),
          GridItem(
            IconItem(
                AssetImage("images/medicine.png"),
                'take medicine',
                60,
                Theme.of(context).primaryColor,
                () => _chooseTask('take medicine')),
          ),
          GridItem(
            IconItem(
                AssetImage("images/appointment.png"),
                'book an appointment',
                60,
                Theme.of(context).primaryColor,
                () => _chooseTask('book an appointment')),
          ),
          GridItem(
            IconItem(AssetImage("images/more.png"), 'more', 60,
                Theme.of(context).primaryColor, () => _chooseTask('more')),
          ),
        ], 2, 1));
  }
}
