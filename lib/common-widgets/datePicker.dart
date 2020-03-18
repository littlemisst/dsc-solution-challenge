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
  return Column(children: <Widget>[
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
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100));
      },
      onChanged: onChanged,
    ),
  ]);
  }
}