import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
    this.text,
    this.onChanged
  );
  final String text;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yMMMMd");
  return Container(
    width: 240,
    child: Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          labelText: text,
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
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