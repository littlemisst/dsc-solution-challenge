import 'package:flutter/material.dart';
import 'package:flutter_scale/flutter_scale.dart';



Widget buildBloodType(context, model, initialValue, onChanged) {
  return Container(
    width: 120.0,
    height: 60.0,
    child: DropdownButtonFormField<String>(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your bloodtype';
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
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

Widget buildWeightField(contex, controller) {
  return Container(
    width: 100,
    height: 50.0,
    child: TextField(
      controller: controller,
      style: TextStyle(fontSize: 15),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Weight', suffixText: 'kg', border: OutlineInputBorder()),
    ),
  );
}

Widget buildHeightField(context, controller) {
  return Container(
    height: 50.0,
    width: 100,
    child: TextField(
      controller: controller,
      style: TextStyle(fontSize: 15),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Height', suffixText: 'm', border: OutlineInputBorder()),
    ),
  );
}

Widget buildWeightScale(context, controller, scaleChanged) {
  return HorizontalScale(
    maxValue: 200,
    scaleController: controller,
    onChanged: scaleChanged,
    textStyle: TextStyle(
        fontSize: 15, color: Colors.pink[100], fontWeight: FontWeight.bold),
    scaleColor: Colors.white10,
    lineColor: Colors.pink[100],
  );
}

Widget buildHeightScale(context, controller, scaleChanged) {
  return HorizontalScale(
    maxValue: 5,
    scaleController: controller,
    scaleColor: Colors.white10,
    lineColor: Colors.pink[100],
    linesBetweenTwoPoints: 11,
    middleLineAt: 6,
    textStyle: TextStyle(
        fontSize: 15, color: Colors.pink[100], fontWeight: FontWeight.bold),
    onChanged: scaleChanged,
  );
}
