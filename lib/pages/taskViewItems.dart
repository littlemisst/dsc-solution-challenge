import 'package:flutter/material.dart';
import 'package:me_daily/model/task.dart';


class TaskViewItems extends StatefulWidget {
  final Task task;
  TaskViewItems({Key key, @required this.task}) : super(key: key);
  @override
  _TaskViewItemsState createState() => _TaskViewItemsState();
}

class _TaskViewItemsState extends State<TaskViewItems> {
  // DateTime _startDate = DateTime.now();
  // DateTime _endDate = DateTime.now().add(Duration(days: 7));
  String _specificTask = "";

  // Future _displayDatePicker(BuildContext context) async {
  //   final List<DateTime> dateSelected = await DateRagePicker.showDatePicker(
  //       context: context,
  //       initialFirstDate: _startDate,
  //       initialLastDate: _endDate,
  //       firstDate: new DateTime(DateTime.now().year - 50),
  //       lastDate: new DateTime(DateTime.now().year + 50));
  //   if (dateSelected != null && dateSelected.length == 2) {
  //     setState(() {
  //       _startDate = dateSelected[0];
  //       widget.task.taskStarted = _startDate;
  //       _endDate = dateSelected[1];
  //       widget.task.taskEnded = _endDate;
  //     });
  //   }
  // }

  var _eatItems = [
    "bread",
    "cereal",
    "rice",
    "pasta",
    "noodles",
    "vegetables",
    "legumes",
    "fruits",
    "dairy",
    "lean meat",
    "fish",
    "poultry",
    "eggs",
    "nuts",
    "others"
  ];
  var _drinkItems = [
    "water",
    "coffee",
    "milk",
    "tea",
    "soda",
    "juice",
    "no soda",
    "no coffee"
  ];
  var _medicineItems = [
    "fever",
    "cold",
    "maintenance",
    "aches",
    "diarrhea",
    "sore throat",
    "allergies",
    "vitamins"
  ];
  var _exerciseItems = ["walking", "jogging", "weights", "cycling", "yoga"];
  var _appointmentItems = [
    "routine check-up",
    "laboratory",
    "counseling",
    "vaccination",
    "sick visit",
    "eye care",
    "dental"
  ];

  @override
  Widget build(BuildContext context) {
    var items = [];
    switch (widget.task.taskType) {
      case "Eat":
        {
          items = _eatItems;
        }
        break;
      case "Drink":
        {
          items = _drinkItems;
        }
        break;
      case "Exercise":
        {
          items = _exerciseItems;
        }
        break;
      case "Medicine":
        {
          items = _medicineItems;
        }
        break;
      case "Appointment":
        {
          items = _appointmentItems;
        }
        break;
      case "More":
        {
          items = _eatItems;
        }
        break;
      default:
        {
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
            return ListTile(
                title: Text(item),
                leading: Radio(
                    value: item,
                    groupValue: _specificTask,
                    onChanged: (value) {
                      setState(() {
                        _specificTask = value;
                        widget.task.specificTask = _specificTask;
                      });
                    }));
          }),
    );
  }
}
 