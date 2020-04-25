import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    return StreamBuilder<List<Task>>(
      stream: FirestoreService(uid: _user.uid).tasks,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          return ListView.builder(
              itemCount: snapshots.data.length,
              itemBuilder: (context, index) {
                Task _task = snapshots.data[index];
                if (!_task.completed) {
                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                    leading:
                        Checkbox(value: _task.completed, tristate: false, onChanged: (bool value) {
                          setState(() {
                            _task.completed = true;
                          });
                        }),
                    title: Align(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            _task.specificTask,
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            _task.taskType,
                            style: TextStyle(fontSize: 11, color: Colors.blueGrey))
                        ],
                      ),
                      alignment: Alignment(-2, 0),
                    ),
                  );
                }
                return null;
              });
        }
        return Container();
      },
    );
  }
}
