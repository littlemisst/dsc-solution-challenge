import 'package:flutter/material.dart';

class IndicatorText extends StatelessWidget {
  const IndicatorText(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft,
      child: Text(text, 
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: Colors.grey))
    );
  }
}