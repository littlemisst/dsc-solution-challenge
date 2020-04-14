import 'package:flutter/material.dart';

Widget buildGender(context, model, initialValue, state) {
  return Container(
    width: 240,
    child: DropdownButtonFormField<String>(
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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

Widget buildCivilStatus(context, model, initialValue, state) {
  return Container(
    width: 240,
    child: DropdownButtonFormField<String>(
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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

Widget buildBloodType(context, model, initialValue, onChanged) {
  return  Container(
    width: 240,
    child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your bloodtype';
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        items: [
          DropdownMenuItem<String>(child: Text('A+'), value: 'A+'),
          DropdownMenuItem<String>(child: Text('A-'), value: 'A-'),
          DropdownMenuItem<String>(child: Text('B+'), value: 'B+'),
          DropdownMenuItem<String>(child: Text('B-'), value: 'B-'),
          DropdownMenuItem<String>(child: Text('O+'), value: 'O+'),
          DropdownMenuItem<String>(child: Text('O-'), value: 'O-'),
          DropdownMenuItem<String>(child: Text('AB+'), value: 'AB+'),
          DropdownMenuItem<String>(child: Text('AB-'), value: 'AB-'),
        ],
        onChanged: onChanged,
        hint: Text('Blood Type', style: TextStyle(fontSize: 15.0)),
        value: initialValue,
      ),
  );
}

Widget buildDescription(context, initialValue, description, onChanged) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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

