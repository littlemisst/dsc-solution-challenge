import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  @override
  TasksListState createState() => TasksListState();
}

class TasksListState extends State<TasksList> {
  Widget buildListOfTasks(context, document) {
    final _user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: _user.uid);
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(10, 0, 15, 0),
      leading: Checkbox(
          value: document.completed,
          tristate: false,
          onChanged: (bool value) async {
            await _firestoreService
                .setCompleted(document.taskCreated.toString());
          }),
      title: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              document.specificTask,
              style: TextStyle(fontSize: 13),
            ),
            Text(document.taskType,
                style: TextStyle(fontSize: 11, color: Colors.blueGrey))
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Task> _taskList = Provider.of<List<Task>>(context) ?? [];
    _taskList.retainWhere((element) => !element.completed);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Text(
              'List of Tasks',
            ),
          ),
        ),
        _taskList.isEmpty
            ? Expanded(
                child: Text(
                  'No recorded task',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _taskList.length,
                    itemBuilder: (context, index) {
                      return buildListOfTasks(context, _taskList[index]);
                    }),
              ),
      ]),
    );
  }
}
