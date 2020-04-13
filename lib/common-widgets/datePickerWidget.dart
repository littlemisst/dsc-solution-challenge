import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key key, this.elevation, this.taskStarted, this.setTaskStarted, this.setTaskEnded}) : super(key:key);
  final double elevation;
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
        elevation: widget.elevation,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget>[
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _displayDate(context),
              child: Row(children: <Widget>[
                Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
                SizedBox(width: 15),
                widget.taskStarted != null ?
                Text('Change Date') : Text('Select Date'),
              ])),
            widget.taskStarted != null ? 
            Container(
              padding: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Text('Task Date: ', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 10),
                  Align(alignment: Alignment.topLeft,
                  child: Text(
                    DateFormat.yMMMd().format(widget.taskStarted), 
                    style: TextStyle(fontSize: 13)))
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
