import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

Widget buildNameField(context, name, onChanged) {
  return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Name',
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      onChanged: onChanged);
}

Widget buildGender(context, model, initialValue, state) {
  return Center(
      child: DropdownButtonFormField<String>(
    decoration: InputDecoration(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
    items: [
      DropdownMenuItem<String>(child: Text('Male'), value: 'Male'),
      DropdownMenuItem<String>(child: Text('Female'), value: 'Female'),
    ],
    onChanged: state,
    hint: Text('Gender'),
    value: initialValue,
  ));
}

Widget buildAddressField(context, address, onChanged) {
  return TextFormField(
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
    decoration: const InputDecoration(
      labelText: 'Address',
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
    onChanged: onChanged,
  );
}

Widget buildDatePicker(context, model, onChanged) {
  final format = DateFormat("yyyy-MM-dd");
  return Column(children: <Widget>[
    DateTimeField(
      decoration: InputDecoration(
        labelText: 'Birthdate',
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

Widget buildCivilStatus(context, model, initialValue, state) {
  return Container(
      child: DropdownButtonFormField<String>(
    decoration: InputDecoration(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
    items: [
      DropdownMenuItem<String>(child: Text('Single'), value: 'Single'),
      DropdownMenuItem<String>(child: Text('Married'), value: 'Married'),
    ],
    onChanged: state,
    hint: Text('Civil Status'),
    value: initialValue,
  ));
}
