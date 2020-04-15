import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget ({Key key, this.text}) : super(key:key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.grey[400]));
  }
}