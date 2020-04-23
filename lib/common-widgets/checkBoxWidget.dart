import 'package:flutter/material.dart';

class LogCheckBox extends StatefulWidget {
  const LogCheckBox(this.title, this.boolValue, this.onChanged);
  final String title;
  final bool boolValue;
  final ValueChanged<bool> onChanged;
  @override
  _LogCheckBoxState createState() => _LogCheckBoxState();
}

class _LogCheckBoxState extends State<LogCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: Checkbox(
          value: widget.boolValue,
          activeColor: Theme.of(context).accentColor,
          onChanged: widget.onChanged
        )),
        Expanded(child: Text(widget.title, style: TextStyle(fontSize: 13)))
      ],
    );
  }
}