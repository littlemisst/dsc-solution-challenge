import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TimePicker extends StatefulWidget {
  const TimePicker(this.taskTime, this.displayTimePicker);
   final DateTime taskTime;
   final VoidCallback displayTimePicker;

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
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
              onPressed: widget.displayTimePicker, 
              child: Row(children: <Widget>[
                Icon(Icons.alarm),
                SizedBox(width: 15),
                widget.taskTime != null ?
                Text('Change Time') : Text('Select Time'),
              ])),
            widget.taskTime != null ? 
            Container(
              padding: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Text('Task Time: ', style: TextStyle(fontSize: 15)),
                  SizedBox(width: 10),
                  Align(alignment: Alignment.topLeft,
                  child: Text('${DateFormat.jm().format(widget.taskTime)}', 
                    style: TextStyle(fontSize: 15)))
                ])
              ])
            ) : 
            Container(
              padding: EdgeInsets.all(15),
              child: Align(alignment: Alignment.topLeft,
                child: Text('Time not selected')
              )
            ),
          ]
        )
      )
    );
  }
}
