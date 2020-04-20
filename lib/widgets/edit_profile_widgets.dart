import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


Widget buildGender(context, value, state) {
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
    value: value,
  ));
}

Widget buildCivilStatus(context,value, state) {
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
    value: value,
  ));
}

Widget buildBloodType(context, value, onChanged) {
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
        value: value,
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

Widget buildTextFormField(context, String label, initialValue, onChanged) {
    return Container(
      width: 240,
      child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          onChanged: onChanged
      ),
    );
}

Widget buildDateTimePicker(context, initialValue, onChanged) {
    final format = DateFormat("yMMMMd");
    return Container(
    width: 240,
    child: DateTimeField(
        initialValue: initialValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Birthdate',
          // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
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
    );
}

Widget buildHeightWeightField(contex, controller, initialValue, suffix) {
  return Container(
    width: 100,
    height: 50.0,
    child: TextField(
      controller: controller,
      style: TextStyle(fontSize: 15),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: initialValue, suffixText: suffix,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    ),
  );
}
