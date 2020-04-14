import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({Key key, this.label, this. value, this.onChanged}) : super(key:key);
  final String label;
  final Function onChanged;
  final value;

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 240,
    child: TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        labelText: label,
        labelStyle: TextStyle(fontSize: 15),
      ),
    onChanged: onChanged),
    );
  }
}