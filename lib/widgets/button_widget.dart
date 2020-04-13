import 'package:flutter/material.dart';

Widget button(Function function, IconData icon, tooltip) {
  return FloatingActionButton(
      tooltip: tooltip,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.pink[100],
      child: Icon(icon, size: 36.0, color: Colors.white));
      
}
