import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:provider/provider.dart';

class TasksDetails extends StatefulWidget {
  @override
  _TasksDetailsState createState() => _TasksDetailsState();
}

class _TasksDetailsState extends State<TasksDetails> {
  getRemainingTasks(List<Task> taskList) {
    taskList.retainWhere((element) => !element.completed);
    return taskList.length;
  }

  @override
  Widget build(BuildContext context) {
    final _taskList = Provider.of<List<Task>>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            'Tasks',
          ),
        ),
        Text(
          getRemainingTasks(_taskList).toString(),
          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 40),
        )
      ],
    );
  }
}
