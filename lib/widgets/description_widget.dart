import 'package:flutter/material.dart';

Widget buildDescription(context, initialValue, description, onChanged) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
    items: [
      DropdownMenuItem<String>(
          child: Text('Prescription'), value: 'Prescription'),
      DropdownMenuItem<String>(child: Text('Receipt'), value: 'Receipt'),
      DropdownMenuItem<String>(
          child: Text('Maintenance'), value: 'Maintenance'),
      DropdownMenuItem<String>(
          child: Text('Laboratory Result'), value: 'Laboratory Result'),
      DropdownMenuItem<String>(
          child: Text('Medical Certificate'), value: 'Medical Certificate'),
      DropdownMenuItem<String>(child: Text('Others'), value: 'Others'),
    ],
    onChanged: onChanged,
    hint: Text('Description'),
    value: initialValue,
  );
}

