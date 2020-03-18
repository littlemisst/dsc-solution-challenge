import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/common-widgets/datePicker.dart';
import 'package:me_daily/common-widgets/iconItem.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/pages/addTaskViewItems.dart';

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
    task = Task(
      taskType: _taskType
    );
  }

  Future<void> _chooseTask(String taskType) {
    setState(() {
      _taskType = taskType;
      task.taskType = taskType;
    });
    if (_taskType == 'more') {
      _buildMoreDialog(context);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TaskViewItems(task: task)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text('What do you want to do?', style: TextStyle(fontSize: 15.0)),
            SizedBox(height: 15),
            _buildTasksGrid(context),
            SizedBox(height: 24),
            _buildSpecificTaskBox(),
            SizedBox(height: 24),
            DatePicker('start date', (DateTime value) => task.taskStarted = value),
            SizedBox(height: 24),
            DatePicker('end date', (DateTime value) => task.taskEnded = value),
            SizedBox(height: 24),
            _buildTimePicker()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[100],
        onPressed: () async {
          await _firestoreService.addTask(task);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Icon(
          Icons.alarm,
          color: Colors.white,
        )),
    );
  }

  Widget _buildTasksGrid(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      padding: EdgeInsets.all(5),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.5),
        children: <Widget>[
          IconItem(AssetImage("images/food.png", ), 'eat', 40, Colors.pink[200], () => _chooseTask('eat')),
          IconItem(AssetImage("images/drink.png"), 'drink', 40, Colors.pink[200], () => _chooseTask('drink')),
          IconItem(AssetImage("images/exercise.png"), 'exercise', 40, Colors.pink[200], () => _chooseTask('exercise')),
          IconItem(AssetImage("images/medicine.png"), 'take medicine', 40, Colors.pink[200], () =>_chooseTask('take medicine')),
          IconItem(AssetImage("images/appointments.png"), 'book an appointment', 40, Colors.pink[200], () => _chooseTask('book an appointment')),
          IconItem(AssetImage("images/more.png"), 'more', 40, Colors.pink[200], () =>_chooseTask('more')),
        ],
      ),
    );
  }

  Widget _buildSpecificTaskBox() {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      width:  MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      child: RichText(
        text: TextSpan(
          text: task.taskType ?? '',
          style: TextStyle(
              color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: ' - '),
            TextSpan(text: task.specificTask ?? 'Enter a Task')]
          ),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(5)
      )
    );
  }

  Widget _buildTimePicker() {
    final format = DateFormat("HH:mm");
    return Column(children: <Widget>[
      DateTimeField(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              labelText: 'time'),
          format: format,
          onShowPicker: (context, currentValue) async {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.convert(time);
          },
          onChanged: (value) => {
                setState(() {
                  task.taskTime = value;
                })
              }),
    ]);
  }

  Future<void> _buildMoreDialog(BuildContext context) {
    String moreTask = '';
    return showDialog(context: context, builder: (context) => 
      AlertDialog(
        content: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            } return null;
          },
          decoration: InputDecoration(
            labelText: 'Add Task'
          ),
          onChanged: (value) => moreTask = value,
        ),
        
        actions: <Widget>[MaterialButton(
          onPressed: () {
            task.specificTask = moreTask;
            Navigator.of(context).pop();
            },
          child: Text('ADD TASK'),
          )],
      )
    );
  }

  
}
