import 'package:flutter/material.dart';
import 'package:me_daily/api/view_task_api.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/api/daily_logs_api.dart';
import 'package:me_daily/pages/viewLogsPage.dart';

class AddDailyLogs extends StatefulWidget {
  @override
  _AddDailyLogsState createState() => _AddDailyLogsState();
}

class _AddDailyLogsState extends State<AddDailyLogs> {
  final _formKey = GlobalKey<FormState>();

  Logs _logs = Logs();

  void _chooseEmotion(String emotion) {
    setState(() {
      _logs.emotion = emotion;
    });
  }

  Widget _buildChooseEmotions() {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed:()=> _chooseEmotion("rad"),
              child: Icon(
                Icons.sentiment_very_satisfied,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: ()=> _chooseEmotion("good"),
              child: Icon(
                Icons.sentiment_satisfied,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: ()=> _chooseEmotion("meh"),
              child: Icon(
                Icons.sentiment_neutral,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: ()=> _chooseEmotion("bad"),
              child: Icon(
                Icons.sentiment_dissatisfied,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: ()=> _chooseEmotion("Sad"),
              child: Icon(
                Icons.sentiment_very_dissatisfied,
                size: 50,
                color: Colors.pink[100],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrinkWater(){
    return Container(
      
    );
  }

  Widget _buildAddNotes() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Add notes"),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: (String value) {
        _logs.note = value;
      },
    );
  }

   Widget _buildTasksGrid(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.all(14),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.5),
        children: <Widget>[
          _gridItem(context, new AssetImage("images/dish.png"), 'Eat'),
          _gridItem(context, new AssetImage("images/wine_bottle.png"), 'Drink'),
          _gridItem(context, new AssetImage("images/barbell.png"), 'Exercise'),
          _gridItem(
              context, new AssetImage("images/medical_tablet.png"), 'Medicine'),
          _gridItem(context, new AssetImage("images/medical_history.png"),
              'Appointment'),
          _gridItem(context, new AssetImage("images/add.png"), 'More'),
        ],
      ),
    );
  }

  Widget _gridItem(BuildContext context, icon, text) {
    var flatButton = FlatButton(
        padding: EdgeInsets.all(8),
        child: ImageIcon(icon, size:40, color: Colors.white,),
        color: Colors.pink[100],
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () {
          _logs.taskType = text;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogViewItems(log: _logs)),
          );
        });
    return Column(
      children: <Widget>[
        flatButton,
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontSize: 11)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    updateTask();
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Daily Logs', style: TextStyle(color: Colors.pink[100])),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildChooseEmotions(),
            _buildTasksGrid(context),
            _buildAddNotes(),
            RaisedButton(
              child: Text('submit'),
              onPressed: () {
                if(!_formKey.currentState.validate()){
                  return;
                }

                submit(_logs);
              },
            )
          ],
        ),
      ),
    );
  }
}
