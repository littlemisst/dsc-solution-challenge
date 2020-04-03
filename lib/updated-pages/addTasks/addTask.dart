import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/buildGrid.dart';
import 'package:me_daily/common-widgets/datePicker.dart';
import 'package:me_daily/common-widgets/floatingAction.dart';
import 'package:me_daily/common-widgets/iconItem.dart';
import 'package:me_daily/common-widgets/timePicker.dart';
import 'package:me_daily/updated-pages/addTasks/addTaskViewItems.dart';
import 'package:me_daily/updated-pages/addTasks/gridItemWidget.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';

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
  }

  void _chooseTask(String taskType) {
    setState(() {
      _taskType = taskType;
      task.taskType = taskType;
    });
    if (_taskType == 'more') {
      _buildMoreDialog(context);
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TaskViewItems(task: task)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);

    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text('ADD TASK',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _buildTasksGrid(context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionToSave(() async {
          await _firestoreService.addTask(task);
          Navigator.of(context).popUntil((route) => route.isFirst);
        }, Icons.alarm));
  }

  Widget _buildTasksGrid(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: BuildGridItems([
          GridItem(
              IconItem(AssetImage("images/eat.png"), 'eat', 60, Colors.white,
                  () => _chooseTask('eat')),
              Colors.pink[300]),
          GridItem(
              IconItem(AssetImage("images/drink.png"), 'drink', 60,
                  Colors.white, () => _chooseTask('drink')),
              Colors.cyan[300]),
          GridItem(
              IconItem(AssetImage("images/exercise.png"), 'exercise', 60,
                  Colors.white, () => _chooseTask('exercise')),
              Colors.red[400]),
          GridItem(
              IconItem(AssetImage("images/medicine.png"), 'take medicine', 60,
                  Colors.white, () => _chooseTask('take medicine')),
              Colors.green[400]),
          GridItem(
              IconItem(
                  AssetImage("images/appointment.png"),
                  'book an appointment',
                  60,
                  Colors.white,
                  () => _chooseTask('book an appointment')),
              Colors.orange[400]),
          GridItem(
              IconItem(AssetImage("images/more.png"), 'more', 60, Colors.white,
                  () => _chooseTask('more')),
              Colors.amber[300]),
        ], 2, 1));
  }

  Future<void> _buildMoreDialog(BuildContext context) {
    String moreTask = '';
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextFormField(
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
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    task.specificTask = moreTask;
                    Navigator.of(context).pop();
                  },
                  child: Text('ADD TASK'),
                )
              ],
            ));
  }
}
