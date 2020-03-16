import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/task.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';


class AddTask extends StatefulWidget {
  
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _taskType;
  String _specificTask;
  DateTime _startTask;
  DateTime _endTask;
  DateTime _time;
  List<dynamic> _items;
  Task task;

  @override
  void initState() {
    super.initState();
    _startTask =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _endTask =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _time = DateTime.now();
    _taskType = '';
    _specificTask = '';
    _items = [];
  }

  Task _taskFromState() {
    return Task(
      taskType: _taskType,
      specificTask: _specificTask,
      taskStarted: _startTask,
      taskEnded: _endTask,
      taskTime: _time
    );
  }
  


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text('CHOOSE A TASK TO DO', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 15),
            _buildTasksGrid(context),
            SizedBox(height: 24),
            _buildDatePicker('start'),
            SizedBox(height: 24),
            _buildDatePicker('end'),
            SizedBox(height: 24),
            _buildTimePicker()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[100],
          onPressed: () async {
            await _firestoreService.addTask(_taskFromState());
          },
          child: Icon(
            Icons.alarm,
            color: Colors.white,
          )),
    );
  }

  Widget _buildTasksGrid(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.all(14),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1),
        children: <Widget>[
          _buildGridItem(context, new AssetImage("images/food.png"), 'Eat'),
          _buildGridItem(
              context, new AssetImage("images/drink.png"), 'Drink'),
          _buildGridItem(
              context, new AssetImage("images/exercise.png"), 'Exercise'),
          _buildGridItem(
              context, new AssetImage("images/medicine.png"), 'Medicine'),
          _buildGridItem(context, new AssetImage("images/appointments.png"),
              'Appointment'),
          _buildGridItem(context, new AssetImage("images/more.png"), 'More'),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, icon, text) {
    var flatButton = FlatButton(
        padding: EdgeInsets.all(15),
        child: ImageIcon(
          icon,
          size: 40,
          color: Colors.pink[100],
        ),
        color: Colors.white,
        shape: CircleBorder(side: BorderSide(color: Colors.grey)),
        onPressed: () async {
          setState(() {
            _taskType = text;
            _buildTaskViewList(context);
          });
        }
      );
    return Column(
      children: <Widget>[
        flatButton,
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontSize: 11)),
      ],
    );
  }

  void _buildTaskViewList(BuildContext context) {
    _items = [];
    switch (_taskType) {
      case "Eat":
        {
          _items = Strings.eatItems;
        }
        break;
      case "Drink":
        {
          _items = Strings.drinkItems;
        }
        break;
      case "Exercise":
        {
          _items = Strings.exerciseItems;
        }
        break;
      case "Medicine":
        {
          _items = Strings.medicineItems;
        }
        break;
      case "Appointment":
        {
          _items = Strings.appointmentItems;
        }
        break;
      case "More":
        {}
        break;
      default:
        {
          print("should not be!");
        }
    }
    showModalBottomSheet(
      context: context,
      builder: (context) { 
        return Container(
        child: ListView.builder(
          itemCount: _items.length, 
          itemBuilder: (context, index) {
             return _taskListView(_items, index);
          }),
        );
      }
    );
  }

  Widget _taskListView(items, index) {
    print(_specificTask);
    return ListTile(
      title: Text(items[index]),
      leading: Radio(
        value: items[index],
        groupValue: _specificTask,
        onChanged: (value) {
          setState(() {
            _specificTask = value;
          }
        );
      })
    );
  }


  Widget _buildDatePicker(indicator) {
    final format = DateFormat("yMMMMd");
    return Column(children: <Widget>[
      DateTimeField(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              labelText: indicator + ' date'),
          format: format,
          onShowPicker: (context, currentValue) async {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          onChanged: (value) {
            setState(() {
              if (indicator == 'start') {
                _startTask = value;
              } else if (indicator == 'end') {
                _endTask = value;
              }
            });
          }),
    ]);
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
                  _time = value;
                })
              }),
    ]);
  }

  
}
