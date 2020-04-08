import 'package:flutter/material.dart';

Widget buildNameField(context, name, onChanged) {
  return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },

      decoration: const InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(fontSize: 15),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      onChanged: onChanged);
}

Widget buildGender(context, model, initialValue, state) {
  return Center(
      child: DropdownButtonFormField<String>(
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter your gender';
      }
      return null;
    },
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
        return 'Please enter your address';
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

Widget buildCivilStatus(context, model, initialValue, state) {
  return Container(
      child: DropdownButtonFormField<String>(
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter your civil status';
      }
      return null;
    },
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
