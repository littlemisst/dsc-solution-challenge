import 'package:flutter/material.dart';
class TextFormat extends StatelessWidget {
  const TextFormat(
    this.text
  );
  final String text;
 
  @override
  Widget build(BuildContext context) {
    return Text(text, 
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontFamily: 'Montserrat', 
        color: Theme.of(context).primaryColor, 
        fontSize: 20)
    );
  }
}