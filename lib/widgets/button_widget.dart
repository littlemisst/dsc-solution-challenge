import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key key, this.function, this.icon, this.toolTip}): super(key:key);
  final Function function;
  final IconData icon;
  final String toolTip;

  @override
  Widget build(BuildContext context) {
  return FloatingActionButton(
      tooltip: toolTip,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(icon, size: 36.0, color: Colors.white));
  }
}