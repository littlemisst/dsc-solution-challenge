import 'package:flutter/material.dart';


class RaisedButtonIcon extends StatelessWidget {
  const RaisedButtonIcon(this.icon, this.label, this.onPressed);
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
    icon: Icon(icon, color: Colors.white),
    label: Text(label, style: TextStyle(color: Colors.white)),
    color: Theme.of(context).primaryColor,
    onPressed: onPressed
  );
  }
}