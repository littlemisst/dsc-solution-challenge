import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';

class DateRangePickerPeriodWidget extends StatefulWidget {
  const DateRangePickerPeriodWidget({Key key, this.elevation, this.taskStarted, this.taskEnded, this.setTaskStarted, this.setTaskEnded}) : super(key: key);
   final double elevation;
   final DateTime taskStarted;
   final DateTime taskEnded;
   final ValueChanged<DateTime> setTaskStarted;
   final ValueChanged<DateTime> setTaskEnded;

  @override
  _DateRangePickerPeriodWidgetState createState() => _DateRangePickerPeriodWidgetState();
}

class _DateRangePickerPeriodWidgetState extends State<DateRangePickerPeriodWidget> {

  Future _displayDatePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
      context: context, 
      initialFirstDate: DateTime.now(), 
      initialLastDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year - 50), 
      lastDate: DateTime(DateTime.now().year + 50),
    );
    DateTime startDate = DateTime(picked[0].year, picked[0].month, picked[0].day);
    DateTime endDate = DateTime(picked[1].year, picked[1].month, picked[1].day);
    if (picked != null && picked.length == 2) {
      widget.setTaskStarted(startDate);
      widget.setTaskEnded(endDate);
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
              onPressed: () => _displayDatePicker(context), 
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
                  Text('Start of Period: ', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 10),
                  Align(alignment: Alignment.topLeft,
                  child: Text(
                    DateFormat.yMMMd().format(widget.taskStarted), 
                    style: TextStyle(fontSize: 13)))
                ]), 
                SizedBox(height: 10),
                 Row(children: <Widget>[
                  Text('End of Period: ', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 10),
                  Align(alignment: Alignment.topLeft,
                  child: Text(
                    DateFormat.yMMMd().format(widget.taskEnded), 
                    style: TextStyle(fontSize: 13)))
                ]),
              ])
            ) : 
            Container(
              padding: EdgeInsets.all(15),
              child: Align(alignment: Alignment.topLeft,
                child: Text('No dates selected')
              )
            ),
        ])  
      )
    );
  }
}
