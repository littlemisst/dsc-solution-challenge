import 'package:flutter/material.dart';
class TextFormat extends StatelessWidget {
  const TextFormat(
    this.text,
  );
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, 
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontFamily: 'Montserrat', 
        color: Colors.black, 
        fontSize: 20)
    );
  }
}