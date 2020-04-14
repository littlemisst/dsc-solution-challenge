import 'package:flutter/material.dart';
import 'package:flutter_scale/flutter_scale.dart';


Widget buildWeightField(contex, controller) {
  return Container(
    width: 100,
    height: 50.0,
    child: TextField(
      controller: controller,
      style: TextStyle(fontSize: 15),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Weight', suffixText: 'kg',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
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
          hintText: 'Height', suffixText: 'm',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    ),
  );
}

Widget buildWeightScale(context, controller, scaleChanged) {
  return HorizontalScale(
    maxValue: 500,
    scaleController: controller,
    onChanged: scaleChanged,
    textStyle: TextStyle(
        fontSize: 15, color: Colors.cyan, fontWeight: FontWeight.bold),
    scaleColor: Colors.white10,
    lineColor:Colors.cyan,
  );
}

Widget buildHeightScale(context, controller, scaleChanged) {
  return HorizontalScale(
    maxValue: 5,
    scaleController: controller,
    scaleColor: Colors.white10,
    lineColor:Colors.cyan,
    linesBetweenTwoPoints: 11,
    middleLineAt: 6,
    textStyle: TextStyle(
        fontSize: 15, color: Colors.cyan, fontWeight: FontWeight.bold),
    onChanged: scaleChanged,
  );
}
