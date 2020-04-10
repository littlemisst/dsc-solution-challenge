import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class TasksDetails extends StatefulWidget {
  @override
  _TasksDetailsState createState() => _TasksDetailsState();
}

class _TasksDetailsState extends State<TasksDetails> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    return StreamBuilder<List<Task>>(
      stream: FirestoreService(uid: _user.uid).tasks,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Tasks',
                  style: TextStyle(),
                ),
              ),
              Text(
                snapshots.data.length.toString(),
                style: TextStyle(color: Colors.pink[100], fontSize: 40),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
