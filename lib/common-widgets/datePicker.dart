import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({Key key, this.initialValue, this.text, this.onChanged}) : super(key:key);
  
  final String text;
  final DateTime initialValue;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yMd");
  return Container(
    child: Column(children: <Widget>[
      Align(alignment: Alignment.centerLeft, child: Text(text)),
      SizedBox(height: 5),
      DateTimeField(
        initialValue: initialValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate:  DateTime(DateTime.now().year - 50),
            lastDate: DateTime(DateTime.now().year + 50),
            initialDate: currentValue ?? DateTime.now(),
           );
        },
        onChanged: onChanged,
      ),
    ]),
  );
  }
}