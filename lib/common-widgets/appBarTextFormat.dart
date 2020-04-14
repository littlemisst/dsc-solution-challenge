import 'package:flutter/material.dart';
class TextFormat extends StatelessWidget {
  const TextFormat(
    this.text,
    this.color
  );
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text, 
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontFamily: 'Montserrat', 
        color: color, 
        fontSize: 20)
    );
  }
}