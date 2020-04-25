import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({Key key, this.label, this.initialValue, this.onChanged}) : super(key:key);
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: Text(label)),
        SizedBox(height: 5),
        TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelStyle: TextStyle(fontSize: 15),
        ),
        onChanged: onChanged),
    ])
    );
  }
}