import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key key, this.taskStarted, this.setTaskStarted, this.setTaskEnded}) : super(key:key);
   final DateTime taskStarted;
  final ValueChanged<DateTime> setTaskStarted;
  final ValueChanged<DateTime> setTaskEnded;

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
   Future _displayDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year - 50), 
      lastDate: DateTime(DateTime.now().year + 50),
    );
    if (picked != null) {
      setState(() {
        widget.setTaskStarted(picked);
        widget.setTaskEnded(picked);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () => _displayDate(context),
              child: Row(children: <Widget>[
                Icon(Icons.calendar_today),
                SizedBox(width: 15),
                widget.taskStarted != null ?
                Text('Change Date') : Text('Select Date'),
              ])),
            widget.taskStarted != null ? 
            Container(
              padding: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Text('Task Date: ', style: TextStyle(fontSize: 15)),
                  SizedBox(width: 10),
                  Align(alignment: Alignment.topLeft,
                  child: Text(
                    DateFormat.yMMMd().format(widget.taskStarted), 
                    style: TextStyle(fontSize: 15)))
                ]), 
              ])
            ) : 
            Container(
              padding: EdgeInsets.all(15),
              child: Align(alignment: Alignment.topLeft,
                child: Text('No date selected')
              )
            ),
        ])  
      )
    );
  }
}
