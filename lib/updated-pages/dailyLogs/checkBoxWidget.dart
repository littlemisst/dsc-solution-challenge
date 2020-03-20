import 'package:flutter/material.dart';

class SymptomsCheckBox extends StatefulWidget {
  const SymptomsCheckBox(this.title, this.boolValue, this.onChanged);
  final String title;
  final bool boolValue;
  final ValueChanged<bool> onChanged;
  @override
  _SymptomsCheckBoxState createState() => _SymptomsCheckBoxState();
}

class _SymptomsCheckBoxState extends State<SymptomsCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: Checkbox(
          value: widget.boolValue,
          activeColor: Colors.pink[100],
          onChanged: widget.onChanged
        )),
        Expanded(child: Text(widget.title, style: TextStyle(fontSize: 13)))
      ],
    );
  }
}