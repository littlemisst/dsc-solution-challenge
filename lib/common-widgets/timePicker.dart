import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatelessWidget {
  const TimePicker(this.onChanged);
  final ValueChanged<DateTime> onChanged;
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("HH:mm");
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            labelText: 'time'),
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime:
                TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
        onChanged: onChanged
      )
    ]);
  }
}
