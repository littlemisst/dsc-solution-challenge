import 'package:flutter/material.dart';

Widget raisedButtonIcon(Function function, label, IconData icon) {
  return RaisedButton.icon(
    icon: Icon(icon, color: Colors.white),
    label: Text(label, style: TextStyle(color: Colors.white)),
    color: Colors.pink[100],
    onPressed: function
  );
}