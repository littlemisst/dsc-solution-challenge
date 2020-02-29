import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskViewItems extends StatefulWidget {
  final Task task;
  TaskViewItems({Key key, @required this.task}) : super(key: key);
  @override
  _TaskViewItemsState createState() => _TaskViewItemsState();
}

class _TaskViewItemsState extends State<TaskViewItems> {
   final db = Firestore.instance;
  
  var _eatItems = ["bread", "cereal", "rice", "pasta", "noodles", "vegetables", "legumes", "fruits", "dairy", "lean meat", "fish", "poultry", "eggs", "nuts", "others"];
  var _drinkItems = ["water", "coffee", "milk", "tea", "soda", "juice", "no soda", "no coffee"];
  var _medicineItems = ["fever", "cold", "maintenance", "aches", "diarrhea", "sore throat", "allergies", "vitamins"];
  var _exerciseItems = ["walking", "jogging", "weights", "cycling", "yoga"];
  var _appointmentItems = ["routine check-up", "laboratory", "counseling", "vaccination", "sick visit", "eye care", "dental"];

  String _specificTask = "";
  @override
  Widget build(BuildContext context) {
    var items = [];
    switch (widget.task.taskType) {
      case "Eat": {
        items = _eatItems;
      }
        break;
      case "Drink": {
        items = _drinkItems;
      }
        break;
      case "Exercise": {
        items = _exerciseItems;
      }  
        break;
      case "Medicine": {
        items = _medicineItems;
      }
        break;
      case "Appointment": {
        items = _appointmentItems;
      }
        break;
      case "More": {
        items = _eatItems;
      }
        break;
      default: {
        print("should not be!");
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
      
          return ListTile(title: Text(item),
          leading: Radio(
            value: item,
            groupValue: _specificTask,
            onChanged: (value) {
              setState(() {
                _specificTask = value;
                widget.task.specificTask = _specificTask;
              });
            }
          ));
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await db.collection('tasks').add(widget.task.toJson());
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Icon(Icons.add)
        ),
    );
  }
}

